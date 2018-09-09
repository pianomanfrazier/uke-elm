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
                (drawNoteOnStaff A4 NoAccidental Treble)
            ]
        )


type alias Config =
    { color : String
    }


config =
    { color = "#222"
    , hoverColor = "rgba(0,0,0,0.3)"
    }


trebleClef : Html msg
trebleClef =
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


bassClef : Html msg
bassClef =
    Svg.path
        [ d """M557 -125c0 28 23 51 51 51s51 -23 51 -51s-23 -51 -51 -51s-51 23 -51 51zM557 125c0 28 23 51 51 51s51 -23 51 -51s-23 -51 -51 -51s-51 23 -51 51zM232 263c172 0 293 -88 293 -251c0 -263 -263 -414 -516 -521c-3 -3 -6 -4 -9 -4c-7 0 -13 6 -13 13c0 3 1 6 4 9 c202 118 412 265 412 493c0 120 -63 235 -171 235c-74 0 -129 -54 -154 -126c11 5 22 8 34 8c55 0 100 -45 100 -100c0 -58 -44 -106 -100 -106c-60 0 -112 47 -112 106c0 133 102 244 232 244z"""
        , fill config.color
        , transform "translate(8.8,2) scale(0.004, -0.004)"
        ]
        []


cClef : Int -> Html msg
cClef offset =
    Svg.path
        [ d """M318 0c0 -33 7 -73 45 -73c29 0 57 31 88 31c123 0 229 -89 229 -208c0 -169 -93 -250 -265 -250c-83 0 -152 61 -152 142c0 42 34 77 76 77s76 -35 76 -77c0 -39 -49 -37 -49 -76c0 -23 24 -38 49 -38c116 0 140 90 140 222c0 106 -12 180 -104 180 c-72 0 -119 -71 -119 -149c0 -9 -7 -14 -14 -14s-13 5 -13 14c0 76 -31 147 -84 200v-471c0 -6 -4 -10 -10 -10h-21c-6 0 -10 4 -10 10v980c0 6 4 10 10 10h21c6 0 10 -4 10 -10v-471c53 53 84 124 84 200c0 9 6 14 13 14s14 -5 14 -14c0 -78 47 -149 119 -149 c92 0 104 74 104 180c0 132 -24 222 -140 222c-25 0 -49 -15 -49 -38c0 -39 49 -37 49 -76c0 -42 -34 -77 -76 -77s-76 35 -76 77c0 81 69 142 152 142c172 0 265 -81 265 -250c0 -119 -106 -208 -229 -208c-31 0 -59 31 -88 31c-38 0 -45 -40 -45 -73zM129 -500h-119 c-6 0 -10 4 -10 10v980c0 6 4 10 10 10h119c6 0 10 -4 10 -10v-980c0 -6 -4 -10 -10 -10z"""
        , fill config.color
        , transform ("translate(8.8," ++ String.fromInt offset ++ ") scale(0.004, -0.004)")
        ]
        []


altoClef : Html msg
altoClef =
    cClef 3


tenorClef : Html msg
tenorClef =
    cClef 2


drawClef : Clef -> Html msg
drawClef clef =
    case clef of
        Treble ->
            trebleClef

        Bass ->
            bassClef

        Alto ->
            altoClef

        Tenor ->
            tenorClef


clefReferenceNote : Clef -> Note
clefReferenceNote clef =
    case clef of
        Treble ->
            B4

        Bass ->
            D3

        Alto ->
            C4

        Tenor ->
            A3


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


drawNoteOnStaff : Note -> Accidental -> Clef -> List (Svg msg)
drawNoteOnStaff note accidental clef =
    let
        offset =
            toFloat (noteDistance (clefReferenceNote clef) note) / 2
    in
    [ g
        [ id "lines", transform "translate(0,2)" ]
        (List.map staffLine (List.range 1 5))
    , g
        [ id "clef", transform "translate(0,2)" ]
        [ drawClef clef
        ]
    , drawNote offset
    , g
        [ id "legerLines", transform "translate(0,5)" ]
        (legerLines offset)
    ]

drawNote : Float -> Svg msg
drawNote offset =
    g
    [ id "note", transform ("translate(14," ++ String.fromFloat (2 + offset) ++ ")") ]
    [ noteHead
    , noteStem (if offset > -1 then Up else Down)
    ]

legerLines : Float -> List (Svg msg)
legerLines offset =
    let
        lines =
            round offset
    in
    if lines > 2 then
        List.map legerLine (List.range 2 lines)
        |> List.drop 1

    else if lines < -2 then
        List.map legerLine (List.range lines -2)
        |> List.reverse
        |> List.drop 1

    else
        []


legerLine : Int -> Html msg
legerLine offset =
    line
        [ x1 "5.5"
        , x2 "7.8"
        , y1 "0"
        , y2 "0"
        , strokeWidth "0.1"
        , stroke config.color
        , transform ("translate(8," ++ String.fromInt offset ++ ")")
        ]
        []


noteHead : Html msg
noteHead =
    Svg.path
        [ d """M220 138c56 0 109 -29 109 -91c0 -72 -56 -121 -103 -149c-36 -21 -76 -36 -117 -36c-56 0 -109 29 -109 91c0 72 56 121 103 149c36 21 76 36 117 36z"""
        , fill config.color
        , transform "translate(0,3) scale(0.004, -0.004)"
        ]
        []


noteStem : StemDirection -> Html msg
noteStem stemDirection =
    case stemDirection of
        Up ->
            rect
                [ fill config.color
                , height "3.3"
                , width "0.13"
                , transform "translate(1.18,-0.5)"
                ]
                []
        
        Down -> 
            rect
                [ fill config.color
                , height "3.3"
                , width "0.13"
                , transform "translate(0,3.2)"
                ]
                []


noteDistance : Note -> Note -> Int
noteDistance note1 note2 =
    noteToInt note1 - noteToInt note2


interval : Note -> Note -> Int
interval note1 note2 =
    1 + noteDistance note1 note2


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


type StemDirection
    = Up
    | Down


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


noteToInt : Note -> Int
noteToInt note =
    case note of
        C1 ->
            0

        D1 ->
            1

        E1 ->
            2

        F1 ->
            3

        G1 ->
            4

        A1 ->
            5

        B1 ->
            6

        C2 ->
            7

        D2 ->
            8

        E2 ->
            9

        F2 ->
            10

        G2 ->
            11

        A2 ->
            12

        B2 ->
            13

        C3 ->
            14

        D3 ->
            15

        E3 ->
            16

        F3 ->
            17

        G3 ->
            18

        A3 ->
            19

        B3 ->
            20

        C4 ->
            21

        D4 ->
            22

        E4 ->
            23

        F4 ->
            24

        G4 ->
            25

        A4 ->
            26

        B4 ->
            27

        C5 ->
            28

        D5 ->
            29

        E5 ->
            30

        F5 ->
            31

        G5 ->
            32

        A5 ->
            33

        B5 ->
            34

        C6 ->
            35

        D6 ->
            36

        E6 ->
            37

        F6 ->
            38

        G6 ->
            39

        A6 ->
            40

        B6 ->
            41

        C7 ->
            42
