module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { text : String }


init : Model
init =
    Model "Hello World"



-- UPDATE


type Msg
    = Append
    | Deppend


update : Msg -> Model -> Model
update msg model =
    case msg of
        Append ->
            { model | text = String.append model.text model.text }

        Deppend ->
            { model | text = String.slice 0 (String.length "Hello World" - String.length model.text) model.text }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Deppend ] [ text "-" ]
        , div [] [ text model.text ]
        , button [ onClick Append ] [ text "+" ]
        ]
