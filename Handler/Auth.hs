module Handler.Auth
( maybeAuth
, requireAuth
, authUser'
, authUser
) where

import Import

#ifdef DEVELOPMENT
maybeAuth :: Handler (Maybe (Entity User))
maybeAuth = do
    let uid = Key $ PersistInt64 1
    mu <- runDB $ get uid
    return $ mu >>= \u -> Just $ Entity uid u

requireAuth :: Handler (Entity User)
requireAuth = do
    let uid = Key $ PersistInt64 1
    mu <- runDB $ get uid
    case mu of
        Nothing -> notFound
        Just u -> return $ Entity uid u
#else
import qualified Yesod.Auth as YA

maybeAuth :: Handler (Maybe (Entity User))
maybeAuth = YA.maybeAuth

requireAuth :: Handler (Entity User)
requireAuth = YA.requireAuth
#endif

authUser' :: UserId -> (Entity User -> Handler a) -> Handler a
authUser' userId handler = do
    e@(Entity uid _) <- requireAuth
    if userId /= uid
        then permissionDenied "Bad credentials"
        else handler e

authUser :: UserId -> Handler a -> Handler a
authUser userId handler = authUser' userId (\_ -> handler)

