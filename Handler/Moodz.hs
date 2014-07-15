module Handler.Moodz
( getMoodzR
) where

import Import
import Yesod.Auth

makeResponse :: [Entity Mood] -> (ContentType, Content)
makeResponse moodz = (typeJson, toContent $ object ["moodz" .= moodz])

getMoodzR :: Handler Html
getMoodzR = do
    _ <- requireAuth
    moodz <- runDB $ selectList [] [Desc MoodCreated]
    sendResponse $ makeResponse moodz

