module Handler.Partials
( _userInfo'
, _plot'
, _graph'
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

_graph' :: Widget
_graph' = do
    addScriptRemote "/static/js/d3.min.js"
    $(widgetFile "partials/_graph")

_plotInterface' :: UserId -> Widget
_plotInterface' userId = do
    renderUrl <- getUrlRender
    let _plot = _plot'
    let _graph = _graph'
    let loadUrl = renderUrl $ MoodzR userId
    let createMoodUrl = renderUrl $ MoodR userId
    let loadVariablesUrl = renderUrl $ VariablesR userId
    let createVariableUrl = renderUrl $ VariableR userId
    $(widgetFile "partials/_plotInterface")

