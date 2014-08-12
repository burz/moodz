module Handler.Graph.Partials
( _graph'
, _graphInterface'
) where

import Handler.Mood.Partials

import Import
import Text.Julius

_graph' :: Widget
_graph' = do
    addScriptRemote "/static/js/d3.min.js"
    addScriptRemote "/static/js/jquery.tipsy.js"
    addStylesheetRemote "/static/css/tipsy.css"
    $(widgetFile "Graph/partials/_graph")

_graphInterface' :: UserId -> Widget
_graphInterface' userId = do
    renderUrl <- getUrlRender
    let _graph = _graph'
    let loadValuesBaseUrl = renderUrl $ VariablesR userId
    let loadMoodzUrl = renderUrl $ MoodzR userId
    let createMoodUrl = renderUrl $ MoodR userId
    let loadVariablesUrl = renderUrl $ VariablesR userId
    let createVariableUrl = renderUrl $ VariableR userId
    let _mood = _mood' userId
    $(widgetFile "Graph/partials/_graphInterface")

