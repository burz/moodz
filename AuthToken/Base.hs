module AuthToken.Base
( getToken
, authenticateToken
) where

import Import
import Data.Time

newToken :: UserId -> Handler AuthToken
newToken userId = do
    t <- liftIO getCurrentTime
    let v = "lolololol"
    return $ AuthToken userId t v

hasExpired :: AuthToken -> Bool
hasExpired time = False

getToken :: UserId -> Handler AuthToken
getToken userId = do
    as <- runDB $ selectList [AuthTokenUser ==. userId] [Desc AuthTokenLastUsed]
    case as of
        [] -> newToken userId
        (Entity _ a) : _ -> if hasExpired a then newToken userId else return a

authenticateToken :: UserId -> Text -> Handler Bool
authenticateToken userId value = do
    as <- runDB $ selectList [AuthTokenUser ==. userId, AuthTokenValue ==. value] []
    return $ case as of
        [] -> False
        (Entity _ a) : _ -> if hasExpired a then False else True

