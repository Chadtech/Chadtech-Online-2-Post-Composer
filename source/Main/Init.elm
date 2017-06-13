module Main.Init exposing (model, cmd)

import Types.Model exposing (Model, TextType(..))
import Types.Message exposing (Message(..))
import Array


model : Model
model =
    { content =
        Array.fromList
            [ ( "", Normal ) ]
    , title = ""
    , date = ""
    }


cmd : Cmd Message
cmd =
    Cmd.none
