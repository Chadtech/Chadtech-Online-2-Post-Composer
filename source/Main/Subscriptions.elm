module Main.Subscriptions exposing (subscriptions)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none
