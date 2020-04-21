module Pong exposing (main)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import VirtualDom


type alias Model =
    { paddle1 : PaddleModel
    , paddle2 : PaddleModel
    }


type alias PaddleModel =
    { xpos : Int
    , ypos : Int
    , color : Color
    }


init : Model
init =
    { paddle1 = PaddleModel 500 10 (rgb 255 0 0)
    , paddle2 = PaddleModel 10 10 (rgb 0 255 0)
    }


pingPongTableView : List (Attribute a) -> List (Html a) -> Html a
pingPongTableView =
    styled div []


paddleView : PaddleModel -> Html msg
paddleView model =
    styled div
        [ height (px 200)
        , width (px 100)
        , backgroundColor model.color
        , left (px (toFloat model.xpos))
        , top (px (toFloat model.ypos))
        , position absolute
        ]
        []
        []


view : Model -> Html msg
view model =
    pingPongTableView []
        [ paddleView model.paddle1
        , paddleView model.paddle2
        ]

main : VirtualDom.Node msg
main =
    toUnstyled <| view init
