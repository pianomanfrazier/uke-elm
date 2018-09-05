module Main exposing (main)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (Html, div, h1, h2, option, p, select, styled, text, toUnstyled)
import Html.Styled.Attributes exposing (css, value)
import Html.Styled.Events exposing (onInput)
import Svg.Styled as SS exposing (Svg, circle, fromUnstyled, g, rect, style, svg, text_)
import Svg.Styled.Attributes as SSA exposing (cx, fill, height, id, r, stroke, strokeWidth, textAnchor, transform, viewBox, width, x, y)



-- MAIN


main =
    Browser.document
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
    | F
    | G7
    | G
    | Blank


chordToList : Chord -> List Int
chordToList chord =
    case chord of
        C ->
            [ 0, 0, 0, 3 ]

        F ->
            [ 2, 0, 1, 0 ]

        G7 ->
            [ 0, 2, 1, 2 ]

        G ->
            [ 0, 2, 3, 2 ]

        _ ->
            [ 0, 0, 0, 0 ]


chordToString : Chord -> String
chordToString chord =
    case chord of
        C ->
            "C"

        F ->
            "F"

        G7 ->
            "G7"

        G ->
            "G"

        _ ->
            "None"


stringToChord : String -> Chord
stringToChord string =
    case string of
        "C" ->
            C

        "F" ->
            F

        "G7" ->
            G7

        "G" ->
            G

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


view : Model -> Browser.Document Msg
view model =
    { title = "Uke Chord Viewer"
    , body =
        List.map toUnstyled
            [ div
                [ css
                    [ padding (em 1)
                    , borderRadius (px 5)
                    , marginTop (em 5)
                    , marginLeft auto
                    , marginRight auto
                    , border3 (px 2) solid (hex "777")
                    , textAlign center
                    , maxWidth (em 30)
                    , fontFamilies [ "Roboto", "Open Sans", "sans-serif" ]
                    , color (hex "222")
                    , backgroundColor (hex "F4EEE2")
                    ]
                ]
                [ h1 [] [ Html.Styled.text "Uke Chord Viewer" ]
                , div [] [ ukeChord model.chord ]
                , select
                    [ onInput ChangeChord ]
                    [ option [ value "NONE" ] [ Html.Styled.text "No Chord" ]
                    , option [ value "C" ] [ Html.Styled.text "C chord" ]
                    , option [ value "F" ] [ Html.Styled.text "F chord" ]
                    , option [ value "G" ] [ Html.Styled.text "G chord" ]
                    , option [ value "G7" ] [ Html.Styled.text "G7 chord" ]
                    ]
                -- , p [] [ model.chord |> chordToList |> Debug.toString |> Html.Styled.text ]
                ]
            ]
    }



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
ukeSvg name chordList =
    svg
        -- scale the SVG
        [ floor (84 * 1.7) |> String.fromInt |> width
        , floor (130 * 1.7) |> String.fromInt |> height
        , viewBox "0 0 84 130"
        , SSA.css
            [ fontFamily sansSerif
            , fontSize (px 14)
            ]
        ]
        [ text_
            [ id "chordName"
            , x "42"
            , y "12"
            , textAnchor "middle"
            , SSA.css
                [ fontSize (px 16) ]
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
                (List.indexedMap closedCircle chordList)
            , g
                [ id "openStrings", transform "translate(1,-5)" ]
                (List.indexedMap openCircle chordList)
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
