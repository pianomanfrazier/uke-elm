module Main exposing (main)

-- import Html exposing (Html)

import Css exposing (color)
import Html.Styled exposing (Html)
import Svg.Styled as Svg exposing (..)
import Svg.Styled.Attributes as SSA exposing (..)


main =
    toUnstyled
        (svg
            [ width "90mm"
            , viewBox "8 0 12 10"
            , SSA.style "font-family: sans-serif; font-size: 11px;"
            ]
            [ g
                [ id "svgFlashCard" ]
                [ g
                    [ id "lines", transform "translate(0,2)" ]
                    (List.map staffLine [ 1, 2, 3, 4, 5 ])
                , g
                    [ id "clef", transform "translate(0,2)" ]
                    [ trebleCleff
                    ]
                , g
                    [ id "note", transform ("translate(14," ++ String.fromInt (3 - 1) ++ ")") ]
                    [ noteHead
                    , noteStem
                    ]
                ]
            ]
        )

type alias Config =
    { color: String
    }

config =
    { color = "#222" 
    , hoverColor = "rgba(0,0,0,0.3)"
    }


trebleCleff : Html msg
trebleCleff =
    Svg.path
        [ d """M376 262c4 0 9 1 13 1c155 0 256 -128 256 -261c0 -76 -33 -154 -107 -210c-22 -17 -47 -28 -73 -36c3 -35 5 -70 5 -105c0 -19 -1 -39 -2 -58c-7 -120 -90 -228 -208 -228c-108 0 -195 88 -195 197c0 58 53 103 112 103c54 0 95 -47 95 -103c0 -52 -43 -95 -95 -95
c-11 0 -21 2 -31 6c26 -39 68 -65 117 -65c96 0 157 92 163 191c1 18 2 37 2 55c0 31 -1 61 -4 92c-29 -5 -58 -8 -89 -8c-188 0 -333 172 -333 374c0 177 131 306 248 441c-19 62 -37 125 -45 190c-6 52 -7 104 -7 156c0 115 55 224 149 292c3 2 7 3 10 3c4 0 7 0 10 -3
c71 -84 133 -245 133 -358c0 -143 -86 -255 -180 -364c21 -68 39 -138 56 -207zM461 -203c68 24 113 95 113 164c0 90 -66 179 -173 190c24 -116 46 -231 60 -354zM74 28c0 -135 129 -247 264 -247c28 0 55 2 82 6c-14 127 -37 245 -63 364c-79 -8 -124 -61 -124 -119
c0 -44 25 -91 81 -123c5 -5 7 -10 7 -15c0 -11 -10 -22 -22 -22c-3 0 -6 1 -9 2c-80 43 -117 115 -117 185c0 88 58 174 160 197c-14 58 -29 117 -46 175c-107 -121 -213 -243 -213 -403zM408 1045c-99 -48 -162 -149 -162 -259c0 -74 18 -133 36 -194
c80 97 146 198 146 324c0 55 -4 79 -20 129z"""
        , fill config.color
        , transform "translate(8.8,4) scale(0.004, -0.004)"
        ]
        []


staffLine : Int -> Html msg
staffLine offset =
    line
        [ id "line1"
        , x1 "0"
        , x2 "12"
        , y1 "0"
        , y2 "0"
        , strokeWidth "0.1"
        , stroke config.color
        , transform ("translate(8," ++ String.fromInt offset ++ ")")
        ]
        []



-- TODO:
-- abstract out the note, take note name as parameter
-- deduce placement on staff e.g. drawNote C4 Treble
-- when it is above the middle line flip the stem
-- draw appropriate leger lines when off the staff
-- allow users to input notes onto the staff with mouse
-- TODO:
-- draw piano keyboard
-- allow users to play notes on keyboard
-- and show them on the staff


drawKeyboardNote : Note -> Accidental -> Html msg
drawKeyboardNote note accidental =
    svg [] []


drawNote : Note -> Accidental -> Clef -> Html msg
drawNote note accidental clef =
    svg [] []


noteHead : Html msg
noteHead =
    Svg.path
        [ d """M220 138c56 0 109 -29 109 -91c0 -72 -56 -121 -103 -149c-36 -21 -76 -36 -117 -36c-56 0 -109 29 -109 91c0 72 56 121 103 149c36 21 76 36 117 36z"""
        , fill config.color
        , transform "translate(0,3) scale(0.004, -0.004)"
        ]
        []


noteStem : Html msg
noteStem =
    rect
        [ fill config.color
        , height "3.3"
        , width "0.13"
        , ry "0.04"
        , transform "translate(1.18,-0.5)"
        ]
        []


type Note
    = C1
    | D1
    | E1
    | F1
    | G1
    | A1
    | B1
    | C2 -- low C
    | D2
    | E2
    | F2
    | G2
    | A2
    | B2
    | C3 -- bass C
    | D3
    | E3
    | F3
    | G3
    | A3
    | B3
    | C4 -- middle C
    | D4
    | E4
    | F4
    | G4
    | A4
    | B4
    | C5 -- treble C
    | D5
    | E5
    | F5
    | G5
    | A5
    | B5
    | C6 -- high C
    | D6
    | E6
    | F6
    | G6
    | A6
    | B6
    | C7


type Clef
    = Treble
    | Bass
    | Alto
    | Tenor


type Accidental
    = Sharp
    | Flat
    | DoubleSharp
    | DoubleFlat
    | Natural
    | NoAccidental
