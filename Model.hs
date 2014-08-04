{-# LANGUAGE FlexibleInstances #-}

module Model where

import Yesod
import Data.Text (Text)
import Database.Persist.Quasi
import Data.Time
import Data.Typeable (Typeable)

import Prelude (String, Int, Show, ($), read, (<), (>), Maybe(..), (==), Double)
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

validateMoodValue :: String -> Int
validateMoodValue t = let v = read t in if v > 100 then 100 else if v < 0 then 0 else v

throwOutEmptyString :: Text -> Maybe Text
throwOutEmptyString t = if t == "" then Nothing else Just t

instance FromJSON MoodPost where
    parseJSON (Object o) = (\v n ->
        MoodPost (validateMoodValue v) $ throwOutEmptyString n)
        <$> o .: "value"
        <*> o .: "notes"
    parseJSON _ = mzero

instance ToJSON (Entity Variable) where
    toJSON (Entity vid v) = object
        [ "id" .= (String $ toPathPiece vid)
        , "name" .= variableName v
        , "created" .= variableCreated v
        ]

data VariablePost = VariablePost Text

instance FromJSON VariablePost where
    parseJSON (Object o) = VariablePost
        <$> o .: "name"
    parseJSON _ = mzero

instance ToJSON (Entity VariableValue) where
    toJSON (Entity vid v) = object
        [ "id" .= (String $ toPathPiece vid)
        , "value" .= variableValueValue v
        , "created" .= variableValueCreated v
        , "notes" .= variableValueNotes v
        ]

data VariableValuePost = VariableValuePost Double (Maybe Text)

instance FromJSON VariableValuePost where
    parseJSON (Object o) = (\v n ->
        VariableValuePost (read v) $ throwOutEmptyString n)
        <$> o .: "value"
        <*> o .: "notes"
    parseJSON _ = mzero

