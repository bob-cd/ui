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
        , middle
        , footer
        ]


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


middle =
    row
        [ width fill
        , height fill
        ]
        [ sidebar, content ]


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


content =
    row
        [ width fill
        , height fill
        ]
        [ text "Content!" ]


footer =
    row
        [ Background.color black
        , width fill
        , height (px 30)
        ]
        [ colorify "this is footer text" gold ]
