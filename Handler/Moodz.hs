module Handler.Moodz
( getMoodzR
, postMoodzR
) where

import Import
import Data.Time
import Network.HTTP.Types (status201)
import Yesod.Auth

makeResponse :: [Entity Mood] -> (ContentType, Content)
makeResponse moodz = (typeJson, toContent $ object ["moodz" .= moodz])

asyncAuth :: UserId -> Handler a -> Handler a
asyncAuth userId handler = do
    Entity uid _ <- requireAuth
    if userId /= uid
        then permissionDenied "Bad credentials"
        else handler

getMoodzR :: UserId -> Handler ()
getMoodzR userId = asyncAuth userId $ do
    moodz <- runDB $ selectList [MoodUser ==. userId] [Desc MoodCreated]
    sendResponse $ makeResponse moodz

postMoodzR :: UserId -> Handler Html
postMoodzR userId = asyncAuth userId $ do
    MoodPost v n <- requireJsonBody
    t <- liftIO getCurrentTime
    _ <- runDB . insert $ Mood userId v t n
    sendResponseStatus status201 ("CREATED" :: Text)

