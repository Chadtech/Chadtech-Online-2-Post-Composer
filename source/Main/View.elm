module Main.View exposing (view)

import Html exposing (Html, p, text, div, textarea, a, input)
import Html.Attributes exposing (class, classList, value)
import Html.Events exposing (onInput, onClick)
import Types.Model exposing (Model, TextType(..))
import Types.Message exposing (Message(..), Direction(..))
import Array exposing (Array)
import Util exposing ((:=))


view : Model -> Html Message
view model =
    Array.indexedMap section model.content
        |> Array.append (header model)
        |> Array.push bottomButtons
        |> Array.toList
        |> div [ class "main" ]


header : Model -> Array (Html Message)
header { title, date } =
    Array.fromList
        [ titleBar
        , titleField title
        , dateField date
        ]


titleField : String -> Html Message
titleField title =
    div
        [ class "field-container" ]
        [ p [] [ text "Title" ]
        , input
            [ class "field"
            , value title
            , onInput UpdateTitle
            ]
            []
        ]


dateField : String -> Html Message
dateField date =
    div
        [ class "field-container" ]
        [ p [] [ text "Date" ]
        , input
            [ class "field"
            , value date
            , onInput UpdateDate
            ]
            []
        ]


bottomButtons : Html Message
bottomButtons =
    div
        [ class "section" ]
        [ a
            [ onClick AddSection ]
            [ text "Add Section" ]
        , a
            [ onClick Save ]
            [ text "Save" ]
        ]


section : Int -> ( String, TextType ) -> Html Message
section index ( str, type_ ) =
    div
        [ class "section" ]
        [ a
            [ onClick (MoveSection index Up) ]
            [ text "Move up" ]
        , a
            [ onClick (MoveSection index Down) ]
            [ text "Move down" ]
        , a
            [ classList
                [ "left-space" := True
                , "selected" := (type_ == Normal)
                ]
            , onClick (ChangeSectionType index Normal)
            ]
            [ text "Normal Text" ]
        , a
            [ classList
                [ "selected" := (type_ == Logic) ]
            , onClick (ChangeSectionType index Logic)
            ]
            [ text "Logic Text" ]
        , a
            [ classList
                [ "selected" := (type_ == Image) ]
            , onClick (ChangeSectionType index Image)
            ]
            [ text "Image" ]
        , a
            [ class "close"
            , onClick (DeleteSection index)
            ]
            [ text "X" ]
        , textarea
            [ classList [ "logic" := (type_ == Logic) ]
            , value str
            , onInput (UpdateSection index type_)
            ]
            []
        ]


titleBar : Html Message
titleBar =
    div
        [ class "title-bar" ]
        [ p
            []
            [ text "Chadtech Online 2 Post Composer" ]
        ]
