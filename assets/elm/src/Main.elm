module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, int, string)



---- MODEL ----


type Model
    = LoggedOut
    | LoggedIn State


type alias State =
    { serverName : Maybe String
    , pc : Maybe Int
    }


init : ( Model, Cmd Msg )
init =
    ( LoggedOut, Cmd.none )


decoder : Decoder Int
decoder =
    field "pc" int


serverDecoder : Decoder String
serverDecoder =
    field "server_name" string



---- UPDATE ----


type Msg
    = Login
    | Logout
    | Reset
    | Tick
    | GotState (Result Http.Error Int)
    | GotServer (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Login ->
            ( LoggedIn { pc = Nothing, serverName = Nothing }
            , Http.get
                { url = "http://localhost:4000/api/login"
                , expect = Http.expectJson GotServer serverDecoder
                }
            )

        Reset ->
            ( model
            , Http.get
                { url = "http://localhost:4000/api/reset"
                , expect = Http.expectJson GotState decoder
                }
            )

        Tick ->
            ( model
            , Http.get
                { url = "http://localhost:4000/api/tick"
                , expect = Http.expectJson GotState decoder
                }
            )

        Logout ->
            ( LoggedOut, Cmd.none )

        GotState (Ok value) ->
            ( LoggedIn { pc = Just value, serverName = Nothing }, Cmd.none )

        GotState _ ->
            ( model, Cmd.none )

        GotServer (Ok value) ->
            ( LoggedIn { pc = Nothing, serverName = Just value }, Cmd.none )

        GotServer _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        LoggedOut ->
            div [] [ button [ onClick Login ] [ text "Login" ] ]

        LoggedIn _ ->
            div []
                [ h1 [] [ text "TRS80 Emulator" ]
                , div []
                    [ div [] [ text "PC" ]
                    , div [] [ text (formatPc model) ]
                    , button [ onClick Reset ] [ text "reset" ]
                    , button [ onClick Tick ] [ text "Tick" ]
                    , button [ onClick Logout ] [ text "Logout" ]
                    ]
                ]


formatPc : Model -> String
formatPc model =
    case model of
        LoggedOut ->
            "Not Logged In"

        LoggedIn { pc } ->
            case pc of
                Nothing ->
                    "Not Initialized"

                Just num ->
                    String.fromInt num



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
