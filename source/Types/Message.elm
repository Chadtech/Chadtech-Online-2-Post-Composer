module Types.Message exposing (..)

import Types.Model exposing (TextType(..))
import Json.Decode exposing (Value)


type Message
    = UpdateTitle String
    | UpdateDate String
    | UpdateSection Int TextType String
    | ChangeSectionType Int TextType
    | DeleteSection Int
    | AddSection
    | MoveSection Int Direction
    | Save
    | Open
    | Load Value


type Direction
    = Up
    | Down
