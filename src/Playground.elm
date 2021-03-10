{-
   https://www.youtube.com/watch?v=CbJ177VAcTQ&t=23s
-}


module Playground exposing (main)

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


lightBlue : Color
lightBlue =
    rgb255 70 108 169


blue : Color
blue =
    rgb255 19 64 139


darkBlue : Color
darkBlue =
    rgb255 5 36 84


yellow : Color
yellow =
    rgb255 206 206 11


gold : Color
gold =
    rgb255 206 135 11


black : Color
black =
    rgb255 13 13 13


purple : Color
purple =
    rgb255 94 14 137


darkPurple : Color
darkPurple =
    rgb255 56 3 85


lightPurple : Color
lightPurple =
    rgb255 134 67 170
