import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)

main: Html msg
main =
  svg
    [ width "84"
    , height "130"
    , viewBox "0 0 84 130"
    , Svg.Attributes.style "font-family: sans-serif; font-size: 11px;"
    ]
    [ text_
      [ id "chordName"
      , x "42"
      , y "12"
      , textAnchor "middle"
      , Svg.Attributes.style "font-size: 16px;"
      , fill "#333"
      ]
      [ text "F" ]
    , g
      [ id "svgChord", transform "translate(9,24)" ]
      [ g
        [ id "strings", transform "translate(0,2)" ]
        [ rect [ height "100", width "2", x "0", fill "#333"] []
        , rect [ height "100", width "2", x "20", fill "#333"] []
        , rect [ height "100", width "2", x "40", fill "#333"] []
        , rect [ height "100", width "2", x "60", fill "#333"] []
        ]
      , g
        [ id "frets", transform "translate(0,2)" ]
        [ rect [ height "4", width "62", y "-2", fill "#333"] []
        , rect [ height "2", width "62", y "20", fill "#333"] []
        , rect [ height "2", width "62", y "40", fill "#333"] []
        , rect [ height "2", width "62", y "60", fill "#333"] []
        , rect [ height "2", width "62", y "80", fill "#333"] []
        , rect [ height "2", width "62", y "100", fill "#333"] []
        ]
      , g
        [ id "closedStrings", transform "translate(1,12)" ]
        [ circle [ r "6", fill "#333", transform "translate(0,20)"] []
        , circle [ r "6", fill "#333", transform "translate(40,20)"] []
        , circle [ r "6", fill "#333", transform "translate(60,0)"] []
        , circle [ r "6", fill "#333", transform "translate(20,40)"] []
        ]
      , g
        [ id "openStrings", transform "translate(1,-5)" ]
        [ circle
          [ cx "40"
          , r "4"
          , fill "none"
          , stroke "#333"
          , strokeWidth "1"
          ] []
        , circle
          [ cx "60"
          , r "4"
          , fill "none"
          , stroke "#333"
          , strokeWidth "1"
          ] []
        ]
      ]
    ]
