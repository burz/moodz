module Handler.Partials
( _userInfo'
, _graph'
, _graphInterface'
) where

import Import
import Text.Julius
import Yesod.Auth

_userInfo' :: User -> Widget
_userInfo' user = $(widgetFile "partials/_userInfo")

_graph' :: Widget
_graph' = do
    addScriptRemote "/static/js/d3.min.js"
    $(widgetFile "partials/_graph")

_graphInterface' :: UserId -> Widget
_graphInterface' userId = do
    renderUrl <- getUrlRender
    let _graph = _graph'
    let loadValuesBaseUrl = renderUrl $ VariablesR userId
    let loadMoodzUrl = renderUrl $ MoodzR userId
    let createMoodUrl = renderUrl $ MoodR userId
    let loadVariablesUrl = renderUrl $ VariablesR userId
    let createVariableUrl = renderUrl $ VariableR userId
    $(widgetFile "partials/_graphInterface")

