module Handler.Mood.Moodz
( getMoodzR
, postMoodzR
) where

import Handler.Auth

import Import
import Data.Time
import Network.HTTP.Types (status201)

makeResponse :: [Entity Mood] -> (ContentType, Content)
makeResponse moodz = (typeJson, toContent $ object ["moodz" .= moodz])

getMoodzR :: UserId -> Handler ()
getMoodzR userId = authUser userId $ do
    moodz <- runDB $ selectList [MoodUser ==. userId] [Desc MoodCreated]
    sendResponse $ makeResponse moodz

postMoodzR :: UserId -> Handler Html
postMoodzR userId = authUser userId $ do
    MoodPost v n <- requireJsonBody
    t <- liftIO getCurrentTime
    _ <- runDB . insert $ Mood userId v t n
    sendResponseStatus status201 ("CREATED" :: Text)

