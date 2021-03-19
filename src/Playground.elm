{-
   https://www.youtube.com/watch?v=CbJ177VAcTQ&t=23s
-}


module Playground exposing (main)

import Browser
import Colors exposing (..)
import Debug exposing (log)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html, pre)
import Http
import Json.Print


type Model
    = Failure
    | Loading
    | Success String


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = \model -> layout [] (viewLayoutThing model)
        }


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "http://localhost:7887/pipelines"
        , expect = Http.expectString GotText
        }
    )


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            Html.text "Unable to contact Bob"

        Loading ->
            Html.text "Loading...!"

        Success fullText ->
            pre [] [ Html.text fullText ]


viewLayoutThing : Model -> Element msg
viewLayoutThing model =
    column
        [ width fill
        , height fill
        ]
        [ header
        , middle model
        , footer
        ]


header : Element msg
header =
    row
        [ Border.width 1
        , paddingXY 20 10
        , width fill
        , Background.color darkBlue
        ]
        [ colorify "🛠👷\u{200D}♀️ bob-cd" gold
        , el [ alignRight ] (colorify "MenuButton" gold)
        ]


middle model =
    row
        [ width fill
        , height fill
        ]
        [ sidebar, content model ]


sidebar =
    column
        [ height fill
        , Border.width 1
        , padding 20
        , Background.color lightBlue
        , Font.color gold
        , Border.widthEach
            { top = 1
            , bottom = 1
            , right = 1
            , left = 0
            }
        , Border.color lightBlue
        ]
        [ sidebarContent "item 1"
        , sidebarContent "item 2"
        ]


sidebarContent : String -> Element msg
sidebarContent t =
    row
        [ width fill
        , padding 10
        ]
        [ text t
        ]



-- (Json.Print.prettyString indent json)


type alias Config =
    { indent : Int
    , columns : Int
    }


thing model =
    let
        cfg =
            Config 2 80
    in
    case model of
        Failure ->
            [ text "couldn't load thing" ]

        Loading ->
            [ text "Loading...!" ]

        Success fullText ->
            let
                prettyJson =
                    Result.withDefault "" (Json.Print.prettyString cfg fullText)
            in
            [ text prettyJson ]


content model =
    row
        [ width fill
        , height fill
        ]
        (thing model)


footer =
    row
        [ Background.color black
        , width fill
        , height (px 30)
        ]
        [ colorify "this is footer text" gold ]
