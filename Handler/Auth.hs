module Handler.Auth
( authUser'
, authUser
) where

import Import

import Yesod.Auth

authUser' :: UserId -> (Entity User -> Handler a) -> Handler a
authUser' userId handler = do
    e@(Entity uid _) <- requireAuth
    if userId /= uid
        then permissionDenied "Bad credentials"
        else handler e

authUser :: UserId -> Handler a -> Handler a
authUser userId handler = authUser' userId (\_ -> handler)

