module Handler.Auth
( asyncAuth
) where

import Import

import Yesod.Auth

asyncAuth :: UserId -> Handler a -> Handler a
asyncAuth userId handler = do
    Entity uid _ <- requireAuth
    if userId /= uid 
        then permissionDenied "Bad credentials"
        else handler

