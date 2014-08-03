module Handler.Mood.Mood
( getMoodR
) where

import Handler.Partials

import Import
import Text.Julius
import Yesod.Auth

getMoodR :: Handler Html
getMoodR = do
    Entity uid user <- requireAuth
    renderUrl <- getUrlRender
    defaultLayout $ do
        setTitle "Create Mood"
        let _userInfo = _userInfo' user
        let url = renderUrl $ MoodzR uid
        let home = renderUrl HomeR
        $(widgetFile "Mood/mood")

