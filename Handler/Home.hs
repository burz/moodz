module Handler.Home
( getHomeR
) where

import Handler.Auth
import Handler.Partials

import Import

#ifndef DEVELOPMENT
import qualified Yesod.Auth as YA
#endif

getHomeR :: Handler Html
getHomeR = do
    auth <- maybeAuth
    case auth of
#ifndef DEVELOPMENT
        Nothing -> defaultLayout [whamlet|
            <center>
                <a href=@{AuthR YA.LoginR}>Sign in or sign up|]
#endif
        Just (Entity uid user) -> do
            defaultLayout $ do
                setTitle "Moodz"
                let _userInfo = _userInfo' user
                let _graphInterface = _graphInterface' uid
                $(widgetFile "homepage")

