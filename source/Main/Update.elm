module Main.Update exposing (update)

import Types.Model as Model exposing (Model, TextType(..))
import Types.Message exposing (Message(..), Direction(..))
import Array
import Array.Extra
import Ports
import Json.Decode as Json


update : Message -> Model -> ( Model, Cmd Message )
update message ({ content } as model) =
    case message of
        UpdateTitle newTitle ->
            { model
                | title = newTitle
            }
                ! []

        UpdateDate newDate ->
            { model
                | date = newDate
            }
                ! []

        UpdateSection index type_ str ->
            { model
                | content =
                    Array.set
                        index
                        ( str, type_ )
                        content
            }
                ! []

        ChangeSectionType index type_ ->
            case Array.get index content of
                Just ( text, _ ) ->
                    { model
                        | content =
                            Array.set
                                index
                                ( text, type_ )
                                content
                    }
                        ! []

                Nothing ->
                    model ! []

        DeleteSection index ->
            (removeSection index model) ! []

        AddSection ->
            { model
                | content =
                    Array.push
                        ( "", Normal )
                        content
            }
                ! []

        MoveSection index direction ->
            (moveSection index direction model) ! []

        Save ->
            model ! [ Ports.save (Model.encode model) ]

        Open ->
            model ! [ Ports.open () ]

        Load json ->
            case Json.decodeValue Model.decoder json of
                Ok val ->
                    val ! []

                Err err ->
                    model ! []



-- HELPERS


moveSection : Int -> Direction -> Model -> Model
moveSection index direction ({ content } as model) =
    case Array.get index content of
        Nothing ->
            model

        Just section ->
            model
                |> removeSection index
                |> insertSection
                    ((abs index) + (directionToInt direction))
                    section


directionToInt : Direction -> Int
directionToInt dir =
    case dir of
        Up ->
            -1

        Down ->
            1


removeSection : Int -> Model -> Model
removeSection index ({ content } as model) =
    { model
        | content =
            Array.Extra.removeAt
                index
                content
    }


insertSection : Int -> ( String, TextType ) -> Model -> Model
insertSection index section ({ content } as model) =
    let
        before =
            content
                |> Array.slice 0 index
                |> Array.push section

        after =
            Array.slice
                index
                (Array.length content)
                content
    in
        { model
            | content =
                Array.append before after
        }
