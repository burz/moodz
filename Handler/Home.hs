module Handler.Home
( getHomeR
) where

import AuthToken.Base
import Handler.Partials

import Import
import Yesod.Auth

getHomeR :: Handler Html
getHomeR = do
    auth <- maybeAuth
    case auth of
        Nothing -> defaultLayout [whamlet|
            <center>
                <a href=@{AuthR LoginR}>Sign in or sign up|]
        Just (Entity uid user) -> do
            authToken <- getToken uid
            defaultLayout $ do
                setTitle "Moodz"
                let _userInfo = _userInfo' user authToken
                let _plotInterface = _plotInterface'
                $(widgetFile "homepage")

