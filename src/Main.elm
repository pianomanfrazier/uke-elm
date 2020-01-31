module Main exposing (main)

import Browser
import Html exposing (Html, div, option, select, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Svg as SS exposing (circle, g, rect, svg, text_)
import Svg.Attributes as SSA exposing (cx, fill, height, id, r, stroke, strokeWidth, textAnchor, transform, viewBox, width, x, y)



-- MAIN
-- ellie-app https://ellie-app.com/7Vg6RqPbFDna1 


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
    , quality : Quality
    }


type Quality
    = Triad
    | Minor
    | Dom7
    | Maj7
    | Min7


stringToQuality : String -> Quality
stringToQuality quality =
    case quality of
        "triad" ->
            Triad

        "minor" ->
            Minor

        "7" ->
            Dom7

        "maj7" ->
            Maj7

        "min7" ->
            Min7

        _ ->
            Triad


qualityToString : Quality -> String
qualityToString quality =
    case quality of
        Triad ->
            "triad"

        Minor ->
            "minor"

        Dom7 ->
            "7"

        Maj7 ->
            "maj7"

        Min7 ->
            "min7"


type Chord
    = C
    | D
    | E
    | F
    | G
    | A
    | B
    | Blank


chordList : List Chord
chordList =
    [ Blank, C, D, E, F, G, A, B ]


qualityList : List Quality
qualityList =
    [ Triad, Minor, Dom7, Maj7, Min7 ]


chordToList : Chord -> Quality -> List Int
chordToList chord quality =
    case chord of
        C ->
            case quality of
                Triad ->
                    [ 0, 0, 0, 3 ]

                Minor ->
                    [ 0, 3, 3, 3 ]

                Dom7 ->
                    [ 0, 0, 0, 1 ]

                Maj7 ->
                    [ 0, 2, 0, 0 ]

                Min7 ->
                    [ 3, 3, 3, 3 ]

        D ->
            case quality of
                Triad ->
                    [ 2, 2, 2, 0 ]

                Minor ->
                    [ 2, 2, 1, 0 ]

                Dom7 ->
                    [ 1, 0, 1, 0 ]

                Maj7 ->
                    [ 2, 2, 2, 4 ]

                Min7 ->
                    [ 2, 2, 1, 3 ]

        E ->
            case quality of
                Triad ->
                    [ 4, 4, 4, 2 ]

                Minor ->
                    [ 0, 4, 3, 2 ]

                Dom7 ->
                    [ 1, 2, 0, 2 ]

                Maj7 ->
                    [ 1, 3, 0, 2 ]

                Min7 ->
                    [ 0, 1, 0, 1 ]

        F ->
            case quality of
                Triad ->
                    [ 2, 0, 1, 0 ]

                Minor ->
                    [ 1, 0, 1, 3 ]

                Dom7 ->
                    [ 2, 3, 1, 0 ]

                Maj7 ->
                    [ 2, 4, 1, 3 ]

                Min7 ->
                    [ 1, 3, 1, 3 ]

        G ->
            case quality of
                Triad ->
                    [ 0, 2, 3, 2 ]

                Minor ->
                    [ 0, 2, 3, 2 ]

                Dom7 ->
                    [ 0, 2, 1, 2 ]

                Maj7 ->
                    [ 0, 2, 2, 2 ]

                Min7 ->
                    [ 0, 2, 1, 1 ]

        A ->
            case quality of
                Triad ->
                    [ 2, 1, 0, 0 ]

                Minor ->
                    [ 1, 0, 0, 0 ]

                Dom7 ->
                    [ 0, 1, 0, 0 ]

                Maj7 ->
                    [ 1, 1, 0, 0 ]

                Min7 ->
                    [ 0, 4, 3, 3 ]

        B ->
            case quality of
                Triad ->
                    [ 4, 3, 2, 2 ]

                Minor ->
                    [ 4, 2, 2, 2 ]

                Dom7 ->
                    [ 2, 3, 2, 2 ]

                Maj7 ->
                    [ 3, 3, 2, 2 ]

                Min7 ->
                    [ 2, 2, 2, 2 ]

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

        _ ->
            Blank


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Blank Triad, Cmd.none )



-- UPDATE


type Msg
    = ChangeChord String
    | ChangeQuality String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeChord newChord ->
            ( { model | chord = stringToChord newChord }, Cmd.none )

        ChangeQuality newQuality ->
            ( { model | quality = stringToQuality newQuality }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view model =
    let
        optionHtml =
            \x -> option [ value (chordToString x) ] [ text (chordToString x) ]

        qualityOptionHtml =
            \x -> option [ value (qualityToString x) ] [ text (qualityToString x) ]
    in
    div
        [ SSA.class "uke-chord-container" ]
        [ ukeChord model.chord model.quality
        , div
            [ SSA.class "uke-chord-inputs" ]
            [ select
                [ onInput ChangeChord ]
                (List.map
                    optionHtml
                    chordList
                )
            , select
                [ onInput ChangeQuality ]
                (List.map
                    qualityOptionHtml
                    qualityList
                )
            ]

        -- , p [] [ model.chord |> chordToList |> Debug.toString |> text ]
        ]



-- SVG UKE CHORD


ukeChord : Chord -> Quality -> Html msg
ukeChord chord quality =
    let
        chordLabel = if chord == Blank then "" else chordToString chord

        qualityLabel = if quality == Triad then "" else qualityToString quality
    in
    ukeSvg chordLabel qualityLabel (chordToList chord quality)


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


ukeSvg : String -> String -> List Int -> Html msg
ukeSvg name quality fretList =
    svg
        -- scale the SVG
        [ width "100%"
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
            , SSA.fontSize "12px"
            ]
            [ SS.text <| name ++ " " ++ quality ]
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
