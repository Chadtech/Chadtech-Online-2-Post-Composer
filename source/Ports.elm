port module Ports exposing (..)

import Json.Encode exposing (Value)


port save : Value -> Cmd msg
