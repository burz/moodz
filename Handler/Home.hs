module Handler.Home
( getHomeR
) where

import Handler.Partials
import Handler.Graph.Partials

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
            defaultLayout $ do
                setTitle "Moodz"
                let _userInfo = _userInfo' user
                let _graphInterface = _graphInterface' uid
                $(widgetFile "homepage")

