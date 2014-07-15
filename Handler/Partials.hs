module Handler.Partials
( _userInfo'
, _plot'
, _plotInterface'
) where

import Import
import Text.Julius
import Yesod.Auth

_userInfo' :: User -> Widget
_userInfo' user = $(widgetFile "partials/_userInfo")

_plot' :: Widget
_plot' = do
    addScriptRemote "/static/js/Chart.min.js"
    $(widgetFile "partials/_plot")

_plotInterface' :: UserId -> Widget
_plotInterface' userId = do
    renderUrl <- getUrlRender
    let _plot = _plot'
    let url = renderUrl $ MoodzR userId
    $(widgetFile "partials/_plotInterface")

