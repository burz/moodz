module Handler.Mood.Partials
( _mood',
) where

import Import
import Text.Julius

_mood' :: UserId -> Widget
_mood' userId = do
    renderUrl <- getUrlRender
    let url = renderUrl $ MoodzR userId
    let home = renderUrl HomeR
    $(widgetFile "Mood/partials/_mood")

