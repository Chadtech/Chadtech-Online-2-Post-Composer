module Types.Model exposing (..)

import Array exposing (Array)
import Json.Encode as Json exposing (Value)


type alias Model =
    { content : Array ( String, TextType )
    , title : String
    , date : String
    }


type TextType
    = Normal
    | Logic
    | Image



-- ENCODER


encoder : Model -> Value
encoder model =
    Json.object
        [ ( "title", Json.string model.title )
        , ( "date", Json.string model.date )
        , ( "body", bodyEncoder (Array.toList model.content) )
        ]


bodyEncoder : List ( String, TextType ) -> Value
bodyEncoder =
    Json.list << List.map sectionEncoder


sectionEncoder : ( String, TextType ) -> Value
sectionEncoder ( str, type_ ) =
    case type_ of
        Image ->
            Json.object
                [ ( "content", Json.string str )
                , str
                    |> toString
                    |> String.toLower
                    |> Json.string
                    |> (,) "type"
                ]

        _ ->
            let
                paragraphs =
                    String.split "\n" str
                        |> List.map Json.string
            in
                Json.object
                    [ ( "content", Json.list paragraphs )
                    , type_
                        |> toString
                        |> String.toLower
                        |> Json.string
                        |> (,) "type"
                    ]
