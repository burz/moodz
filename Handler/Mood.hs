module Handler.Mood
( getMoodR
, postMoodR
) where

import Import
import Text.Julius
import Network.HTTP.Types (status201)

getMoodR :: Handler Html
getMoodR = do
    renderUrl <- getUrlRender
    defaultLayout $ do
        let url = renderUrl MoodR
        let home = renderUrl HomeR
        $(widgetFile "mood")

postMoodR :: Handler Html
postMoodR = do
    m <- requireJsonBody :: Handler Mood
    _ <- runDB $ insert m
    sendResponseStatus status201 ("CREATED" :: Text)

