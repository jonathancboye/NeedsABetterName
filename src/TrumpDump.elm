module TrumpDump exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, decodeString, string, field)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { quote : String
    }


modelInitialValue =
    ""


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model modelInitialValue, Cmd.none )


type Msg
    = GetRandomQuote (Result Http.Error String)
    | GetQuote

quoteDecoder : Decoder String
quoteDecoder =
    field "value" string


getRandomQuote : Cmd Msg
getRandomQuote =
    Http.get
        { url = "https://www.tronalddump.io/random/quote"
        , expect = Http.expectJson GetRandomQuote quoteDecoder
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetQuote ->
            ( model, getRandomQuote )

        GetRandomQuote (Ok aQuote) ->
            ( { model | quote = aQuote }, Cmd.none )

        GetRandomQuote (Err error) ->
            ( { model | quote = "error" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ div [] [ button [ onClick GetQuote ] [ text "get a quote" ] ]
        , div [] [ text model.quote ]
        ]
