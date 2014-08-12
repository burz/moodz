module Handler.Graph.Partials
( _graph'
, _graphInterface'
) where

import Handler.Mood.Partials
import Handler.Variable.Partials
import Handler.VariableValue.Partials

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
    messageRender <- getMessageRender
    let _graph = _graph'
    let loadValuesBaseUrl = renderUrl $ VariablesR userId
    let loadMoodzUrl = renderUrl $ MoodzR userId
    let loadVariablesUrl = renderUrl $ VariablesR userId
    let msgChooseVariable = messageRender MsgChooseVariable
    let _newMoodBody = _newMoodBody' userId
    let _newVariableBody = _newVariableBody' userId
    let _newVariableValueBody = _newVariableValueBody' userId
    let homeUrl = renderUrl HomeR
    $(widgetFile "Graph/partials/_graphInterface")

