module Types.Model exposing (..)

import Array exposing (Array)


type alias Model =
    { content : Array ( String, TextType )
    , title : String
    , date : String
    }


type TextType
    = Normal
    | Logic
    | Image
