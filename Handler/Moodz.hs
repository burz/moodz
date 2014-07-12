module Handler.Moodz
( getMoodzR
) where

import Import

makeResponse :: [Entity Mood] -> (ContentType, Content)
makeResponse moodz = (typeJson, toContent $ object ["moodz" .= moodz])

getMoodzR :: Handler Html
getMoodzR = do
    moodz <- runDB $ selectList [] [Desc MoodCreated]
    sendResponse $ makeResponse moodz

