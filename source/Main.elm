module Main exposing (..)

import Html
import Main.Init as Init
import Main.View exposing (view)
import Main.Subscriptions exposing (subscriptions)
import Main.Update exposing (update)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


main : Program Never Model Message
main =
    Html.program
        { init = ( Init.model, Init.cmd )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
