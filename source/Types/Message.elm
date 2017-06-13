module Types.Message exposing (..)

import Types.Model exposing (TextType(..))


type Message
    = UpdateTitle String
    | UpdateDate String
    | UpdateSection Int TextType String
    | ChangeSectionType Int TextType
    | DeleteSection Int
    | AddSection
    | MoveSection Int Direction
    | Save


type Direction
    = Up
    | Down
