{-# LANGUAGE FlexibleInstances #-}

module Model where

import Yesod
import Data.Text (Text)
import Database.Persist.Quasi
import Data.Time
import Data.Typeable (Typeable)

import Prelude (Int, Show, ($), read)
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

instance FromJSON Mood where
    parseJSON (Object o) = (\v c n -> Mood (read v) c n)
        <$> o .: "value"
        <*> o .: "created"
        <*> o .: "notes"
    parseJSON _ = mzero

