module Handler.VariableValue.VariableValue
( getVariableValueR
) where

import Handler.Variable.Auth
import Handler.Partials

import Import
import Text.Julius

getVariableValueR :: UserId -> VariableId -> Handler Html
getVariableValueR userId variableId = authVariable' userId variableId
    $ \(Entity _ user) (Entity _ variable) -> do
        renderUrl <- getUrlRender
        defaultLayout $ do
            setTitle "Create Value"
            let _userInfo = _userInfo' user
            let url = renderUrl $ VariableValuesR userId variableId
            let home = renderUrl HomeR
            $(widgetFile "VariableValue/variableValue")

