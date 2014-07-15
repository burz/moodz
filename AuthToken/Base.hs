module AuthToken.Base
( getToken
, authenticateToken
) where

import Import
import Data.Text.Encoding (decodeUtf16LEWith)
import Data.Time
import System.Entropy

tokenSize :: Int
tokenSize = 64

newToken :: UserId -> Handler AuthToken
newToken userId = do
    t <- liftIO getCurrentTime
    b <- liftIO $ getEntropy tokenSize
    let at = AuthToken userId t (decodeUtf16LEWith badByteHandler b)
    _ <- runDB $ insert at
    return at
    where badByteHandler _ _ = Just '-'

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
    case as of
        [] -> return False
        (Entity aid a) : _ -> if hasExpired a
            then return False
            else if value /= authTokenValue a
                then return False
                else do
                    t <- liftIO $ getCurrentTime
                    _ <- runDB $ update aid [AuthTokenLastUsed +=. t]
                    return True

