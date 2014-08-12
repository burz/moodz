module Handler.VariableValue.Partials
( _newVariableValueBody'
) where

import Import
import Text.Julius

_newVariableValueBody' :: UserId -> Widget
_newVariableValueBody' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ VariablesR userId
    $(widgetFile "VariableValue/partials/_variableValue")

