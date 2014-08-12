module Handler.Partials
( _userInfo'
) where

import Import
import Yesod.Auth

_userInfo' :: User -> Widget
_userInfo' user = $(widgetFile "partials/_userInfo")

