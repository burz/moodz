module Handler.Mood.Partials
( _newMoodBody',
) where

import Import
import Text.Julius

_newMoodBody' :: UserId -> Widget
_newMoodBody' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ MoodzR userId
    let home = renderUrl HomeR
    $(widgetFile "Mood/partials/_mood")

