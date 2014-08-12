module Handler.Variable.Partials
( _newVariableBody'
) where

import Import
import Text.Julius

_newVariableBody' :: UserId -> Widget
_newVariableBody' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ VariablesR userId
    $(widgetFile "Variable/partials/_variable")

