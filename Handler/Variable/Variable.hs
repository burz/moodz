module Handler.Variable.Variable
( getVariableR
) where

import Handler.Auth
import Handler.Partials

import Import
import Text.Julius

getVariableR :: UserId -> Handler Html
getVariableR userId = authUser' userId $ \(Entity _ user) -> do
    renderUrl <- getUrlRender
    defaultLayout $ do
        setTitle "Create Variable"
        let _userInfo = _userInfo' user
        let url = renderUrl $ VariablesR userId
        let home = renderUrl HomeR
        $(widgetFile "Variable/variable")

