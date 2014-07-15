{-# LANGUAGE FlexibleInstances #-}

module Model where

import Yesod
import Data.Text (Text)
import Database.Persist.Quasi
import Data.Time
import Data.Typeable (Typeable)

import Prelude (String, Int, Show, ($), read, (<), (>), Maybe)
import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

instance ToJSON (Entity Mood) where
    toJSON (Entity mid m) = object
        [ "id" .= (String $ toPathPiece mid)
        , "value" .= moodValue m
        , "created" .= moodCreated m
        , "notes" .= moodNotes m
        ]

data MoodPost = MoodPost Int (Maybe Text)

readMoodValue :: String -> Int
readMoodValue t = let v = read t in if v > 100 then 100 else if v < 0 then 0 else v

instance FromJSON MoodPost where
    parseJSON (Object o) = (\v n -> MoodPost (readMoodValue v) n)
        <$> o .: "value"
        <*> o .: "notes"
    parseJSON _ = mzero

