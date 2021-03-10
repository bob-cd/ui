{-
   https://www.youtube.com/watch?v=CbJ177VAcTQ&t=23s
-}


module Playground exposing (main)

import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


main =
    layout [] view


view =
    column
        [ width fill
        , height fill
        ]
        [ header
        , content
        , footer
        ]


header =
    row
        [ Border.width 1
        , paddingXY 20 10
        , width fill
        , Background.color darkBlue
        ]
        [ colorify "Logo" gold
        , el [ alignRight ] (colorify "MenuButton" gold)
        ]


content =
    row
        [ width fill
        , height fill
        ]
        [ text "Content!" ]


footer =
    row
        [ Background.color purple
        , width fill
        , height (px 30)
        ]
        [ colorify "this is footer text" gold ]


colorify : String -> Color -> Element msg
colorify text color =
    Element.el [ Font.color color ] (Element.text text)
