port module Ports exposing (..)

import Json.Encode exposing (Value)


port save : Value -> Cmd msg


port open : () -> Cmd msg


port load : (Value -> msg) -> Sub msg
