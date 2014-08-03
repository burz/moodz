module Handler.Variable.Variables
( getVariablesR
, postVariablesR
) where

import Handler.Auth

import Import
import Data.Time
import Network.HTTP.Types (status201)

makeResponse :: [Entity Variable] -> (ContentType, Content)
makeResponse variables = (typeJson, toContent $ object ["variables" .= variables])

getVariablesR :: UserId -> Handler ()
getVariablesR userId = asyncAuth userId $ do
    variables <- runDB $ selectList [VariableUser ==. userId] [Desc VariableCreated]
    sendResponse $ makeResponse variables

postVariablesR :: UserId -> Handler ()
postVariablesR userId = asyncAuth userId $ do
    VariablePost n <- requireJsonBody
    t <- liftIO getCurrentTime
    _ <- runDB . insert $ Variable userId n t
    sendResponseStatus status201 ("CREATED" :: Text)

