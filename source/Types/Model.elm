module Types.Model exposing (..)

import Array exposing (Array)
import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, andThen, fail)
import Json.Decode.Pipeline as Pipeline exposing (required, optional, hardcoded)


type alias Model =
    { content : Array ( String, TextType )
    , title : String
    , date : String
    }


type TextType
    = Normal
    | Logic
    | Image



-- DECODER --


decoder : Decoder Model
decoder =
    Pipeline.decode Model
        |> required "body" (Decode.array contentDecoder)
        |> required "title" Decode.string
        |> required "date" Decode.string


contentDecoder : Decoder ( String, TextType )
contentDecoder =
    Decode.field "type" Decode.string
        |> andThen contentDecoderHelp


contentDecoderHelp : String -> Decoder ( String, TextType )
contentDecoderHelp type_ =
    case type_ of
        "normal" ->
            Decode.map2 (,)
                (toListString |> andThen concatDecoder)
                (Decode.succeed Normal)

        "logic" ->
            Decode.map2 (,)
                (toListString |> andThen concatDecoder)
                (Decode.succeed Logic)

        "image" ->
            Decode.map2 (,)
                (Decode.field "content" Decode.string)
                (Decode.succeed Image)

        _ ->
            Decode.fail "content is of unrecognized type (not normal, logic, or image)"


concatDecoder : List String -> Decoder String
concatDecoder =
    String.join "\n" >> Decode.succeed


toListString : Decoder (List String)
toListString =
    Decode.field "content" (Decode.list Decode.string)



-- ENCODER --


encode : Model -> Value
encode model =
    Encode.object
        [ ( "title", Encode.string model.title )
        , ( "date", Encode.string model.date )
        , ( "body", bodyEncoder (Array.toList model.content) )
        ]


bodyEncoder : List ( String, TextType ) -> Value
bodyEncoder =
    Encode.list << List.map sectionEncoder


sectionEncoder : ( String, TextType ) -> Value
sectionEncoder ( str, type_ ) =
    case type_ of
        Image ->
            Encode.object
                [ ( "content", Encode.string str )
                , str
                    |> toString
                    |> String.toLower
                    |> Encode.string
                    |> (,) "type"
                ]

        _ ->
            let
                paragraphs =
                    String.split "\n" str
                        |> List.map Encode.string
            in
                Encode.object
                    [ ( "content", Encode.list paragraphs )
                    , type_
                        |> toString
                        |> String.toLower
                        |> Encode.string
                        |> (,) "type"
                    ]
