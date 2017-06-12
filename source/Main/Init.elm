module Main.Init exposing (model, cmd)

import Types.Model exposing (Model)
import Types.Message exposing (Message(..))


model : Model
model =
    Model ""


cmd : Cmd Message
cmd =
    Cmd.none
