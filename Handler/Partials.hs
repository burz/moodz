module Handler.Partials
( _userInfo'
, _plot'
, _plotInterface'
) where

import Import
import Text.Julius
import Yesod.Auth

_userInfo' :: User -> AuthToken -> Widget
_userInfo' user authToken = $(widgetFile "partials/_userInfo")

_plot' :: Widget
_plot' = do
    addScriptRemote "/static/js/Chart.min.js"
    $(widgetFile "partials/_plot")

_plotInterface' :: Widget
_plotInterface' = do
    renderUrl <- getUrlRender
    let _plot = _plot'
    let url = renderUrl MoodzR
    $(widgetFile "partials/_plotInterface")

