module Handler.Variable.VariableValues
( getVariableValuesR
, postVariableValuesR
) where

import Handler.Variable.Auth

import Import
import Data.Time
import Network.HTTP.Types (status201)

makeResponse :: [Entity VariableValue] -> (ContentType, Content)
makeResponse vv = (typeJson, toContent $ object ["variableValues" .= vv])

getVariableValuesR :: UserId -> VariableId -> Handler ()
getVariableValuesR userId variableId = authVariables userId variableId $ do
    variableValues <- runDB $ selectList
        [VariableValueVariable ==. variableId] [Desc VariableValueCreated]
    sendResponse $ makeResponse variableValues

postVariableValuesR :: UserId -> VariableId -> Handler ()
postVariableValuesR userId variableId = authVariables userId variableId $ do
    VariableValuePost v n <- requireJsonBody
    t <- liftIO getCurrentTime
    _ <- runDB . insert $ VariableValue variableId v t n
    sendResponseStatus status201 ("CREATED" :: Text)

