module Main exposing (main)

import Browser
import Html
import Html exposing (Html, div, h1, h2, option, p, select, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Svg as SS exposing (Svg, circle, g, rect, style, svg, text_)
import Svg.Attributes as SSA exposing (cx, fill, height, id, r, stroke, strokeWidth, textAnchor, transform, viewBox, width, x, y)



-- MAIN
-- ellie-app https://ellie-app.com/7V3KVksCKkGa1


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { chord : Chord
    }


type Chord
    = C
    | D
    | E
    | F
    | G
    | A
    | B
    | G7
    | D7
    | A7
    | E7
    | Blank


chordList = [Blank, C, D, E, F, G, A, B, G7, D7, A7, E7]

chordToList : Chord -> List Int
chordToList chord =
    case chord of
        C ->
            [ 0, 0, 0, 3 ]

        D ->
            [ 2, 2, 2, 0 ]

        E ->
            [ 4, 4, 4, 2 ]

        F ->
            [ 2, 0, 1, 0 ]

        G ->
            [ 0, 2, 3, 2 ]

        A ->
            [ 2, 1, 0, 0 ]

        B ->
            [ 4, 3, 2, 2 ]

        G7 ->
            [ 0, 2, 1, 2 ]

        D7 ->
            [ 2, 0, 2, 0 ]

        A7 ->
            [ 0, 1, 0, 0 ]

        E7 ->
            [ 1, 2, 0, 2 ]

        Blank ->
            [ 0, 0, 0, 0 ]


chordToString : Chord -> String
chordToString chord =
    case chord of
        C ->
            "C"

        D ->
            "D"

        E ->
            "E"

        F ->
            "F"

        G ->
            "G"

        A ->
            "A"

        B ->
            "B"

        G7 ->
            "G7"

        D7 ->
            "D7"

        A7 ->
            "A7"

        E7 ->
            "E7"

        Blank ->
            "None"


stringToChord : String -> Chord
stringToChord string =
    case string of
        "C" ->
            C

        "D" ->
            D

        "E" ->
            E

        "F" ->
            F

        "G" ->
            G

        "A" ->
            A

        "B" ->
            B

        "G7" ->
            G7

        "D7" ->
            D7

        "A7" ->
            A7

        "E7" ->
            E7

        _ ->
            Blank


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Blank, Cmd.none )



-- UPDATE


type Msg
    = ChangeChord String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeChord newChord ->
            ( { model | chord = stringToChord newChord }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view model =
    let
        optionHtml = \x -> option [ value (chordToString x) ] [ text (chordToString x)]
    in
    div
        [ SSA.class "uke-chord-container" ]
        [ div [] [ ukeChord model.chord ]
        , select
            [ onInput ChangeChord ]
            (List.map
                optionHtml
                chordList
            )
        , p [] [ model.chord |> chordToList |> Debug.toString |> text ]
        ]



-- SVG UKE CHORD


ukeChord : Chord -> Html msg
ukeChord chord =
    ukeSvg (chordToString chord) (chordToList chord)


ukeString : Int -> Html msg
ukeString string =
    rect [ height "100", width "2", x (String.fromInt string), fill "#333" ] []


ukeFret : Int -> Int -> Html msg
ukeFret index fret =
    case index of
        -- first fret is thicker
        0 ->
            rect [ height "4", width "62", y (String.fromInt (fret - 2)), fill "#333" ] []

        _ ->
            rect [ height "2", width "62", y (String.fromInt fret), fill "#333" ] []


ukeSvg : String -> List Int -> Html msg
ukeSvg name fretList =
    svg
        -- scale the SVG
        [ floor (84 * 1.7) |> String.fromInt |> width
        , floor (130 * 1.7) |> String.fromInt |> height
        , viewBox "0 0 84 130"
        , SSA.class "uke-chord-svg"
        ]
        [ text_
            [ id "chordName"
            , x "42"
            , y "12"
            , textAnchor "middle"
            , SSA.class "uke-chord-name"
            , fill "#333"
            ]
            [ SS.text name ]
        , g
            [ id "svgChord", transform "translate(9,24)" ]
            [ g
                [ id "strings", transform "translate(0,2)" ]
                (List.map ukeString [ 0, 20, 40, 60 ])
            , g
                [ id "frets", transform "translate(0,2)" ]
                (List.indexedMap ukeFret [ 0, 20, 40, 60, 80, 100 ])
            , g
                [ id "closedStrings", transform "translate(1,12)" ]
                (List.indexedMap closedCircle fretList)
            , g
                [ id "openStrings", transform "translate(1,-5)" ]
                (List.indexedMap openCircle fretList)
            ]
        ]


closedCircle : Int -> Int -> Html msg
closedCircle string fret =
    case fret of
        0 ->
            circle [] []

        _ ->
            circle
                [ r "6"
                , fill "#333"
                , transform ("translate(" ++ String.fromInt (string * 20) ++ "," ++ String.fromInt (20 * (fret - 1)) ++ ")")
                ]
                []


openCircle : Int -> Int -> Html msg
openCircle string fret =
    case fret of
        0 ->
            circle
                [ cx (String.fromInt (20 * string))
                , r "4"
                , fill "none"
                , stroke "#333"
                , strokeWidth "1"
                ]
                []

        _ ->
            circle [] []
