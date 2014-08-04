module Handler.Variable.Auth
( VariableHandler
, authVariable'
, authVariable
) where

import Import

import Yesod.Auth

type VariableHandler a = Entity User -> Entity Variable -> Handler a

authVariable' :: UserId -> VariableId -> VariableHandler a -> Handler a
authVariable' userId variableId handler = do
    e@(Entity uid _) <- requireAuth
    if userId /= uid
        then permissionDenied "Bad credentials"
        else do
            mv <- runDB $ get variableId
            case mv of
                Nothing -> notFound
                Just v@(Variable vuid _ _) -> if userId /= vuid
                    then permissionDenied "Bad credentials"
                    else handler e $ Entity variableId v

authVariable :: UserId -> VariableId -> Handler a -> Handler a
authVariable userId variableId handler = authVariable' userId variableId $ \_ _ -> handler
