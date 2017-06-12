module Main.View exposing (view)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Types.Model exposing (Model)
import Types.Message exposing (Message(..))
import Components.Basics exposing (words, field, mainContainer)


view : Model -> Html Message
view model =
    mainContainer
        [ words "big" "Elm Project : Go!"
        , field
            UpdateField
            "Check out these Messages"
            model.field
        ]
