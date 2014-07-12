module Handler.Home
( getHomeR
) where

import Handler.Partials

import Import

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    let _plotInterface = _plotInterface'
    $(widgetFile "homepage")

