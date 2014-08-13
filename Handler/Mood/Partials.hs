module Handler.Mood.Partials
( _newMoodBody'
, _addMoreBody'
) where

import Import
import Text.Julius

_newMoodBody' :: UserId -> Widget
_newMoodBody' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ MoodzR userId
    $(widgetFile "Mood/partials/_mood")

_addMoreBody' :: UserId -> Widget
_addMoreBody' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ MoodzR userId
    $(widgetFile "Mood/partials/_addMore")

