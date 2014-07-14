module Handler.Mood
( getMoodR
, postMoodR
) where

import Handler.Partials

import Import
import Text.Julius
import Network.HTTP.Types (status201)
import Yesod.Auth

getMoodR :: Handler Html
getMoodR = do
    Entity _ user <- requireAuth
    renderUrl <- getUrlRender
    defaultLayout $ do
        setTitle "Create Mood"
        let _userInfo = _userInfo' user
        let url = renderUrl MoodR
        let home = renderUrl HomeR
        $(widgetFile "mood")

postMoodR :: Handler Html
postMoodR = do
    m <- requireJsonBody :: Handler Mood
    _ <- runDB $ insert m
    sendResponseStatus status201 ("CREATED" :: Text)

