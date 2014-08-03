module Handler.Variable.Auth
( authVariables
) where

import Import

import Yesod.Auth

authVariables :: UserId -> VariableId -> Handler a -> Handler a
authVariables userId variableId handler = do
    Entity uid _ <- requireAuth
    if userId /= uid
        then permissionDenied "Bad credentials"
        else do
            mv <- runDB $ get variableId
            case mv of
                Nothing -> notFound
                Just (Variable vuid _ _) -> if userId /= vuid
                    then permissionDenied "Bad credentials"
                    else handler

