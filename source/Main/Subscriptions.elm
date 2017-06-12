module Main.Subscriptions exposing (subscriptions)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Ports exposing (..)


subscriptions : Model -> Sub Message
subscriptions model =
    fromJS HandlePort
