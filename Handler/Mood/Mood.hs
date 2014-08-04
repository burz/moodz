module Handler.Mood.Mood
( getMoodR
) where

import Handler.Auth
import Handler.Partials

import Import
import Text.Julius

getMoodR :: UserId -> Handler Html
getMoodR userId = authUser' userId $ \(Entity _ user) -> do
    renderUrl <- getUrlRender
    defaultLayout $ do
        setTitle "Create Mood"
        let _userInfo = _userInfo' user
        let url = renderUrl $ MoodzR userId
        let home = renderUrl HomeR
        $(widgetFile "Mood/mood")

