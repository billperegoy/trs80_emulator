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
    { pc : Maybe Int }


init : ( Model, Cmd Msg )
init =
    ( LoggedOut, Cmd.none )



-- ( LoggedIn { pc = Nothing }
--, Http.get
--   { url = "http://localhost:4000/api/state"
--  , expect = Http.expectJson GotState decoder
-- }
-- )


decoder : Decoder Int
decoder =
    field "pc" int



---- UPDATE ----


type Msg
    = Login
    | Logout
    | GotState (Result Http.Error Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Login ->
            ( LoggedIn { pc = Nothing }
            , Http.get
                { url = "http://localhost:4000/api/state"
                , expect = Http.expectJson GotState decoder
                }
            )

        Logout ->
            ( LoggedOut, Cmd.none )

        GotState (Ok value) ->
            ( LoggedIn { pc = Just value }, Cmd.none )

        GotState (Err (Http.BadUrl _)) ->
            ( model, Cmd.none )

        GotState (Err Http.Timeout) ->
            ( model, Cmd.none )

        GotState (Err Http.NetworkError) ->
            ( model, Cmd.none )

        GotState (Err (Http.BadStatus _)) ->
            ( model, Cmd.none )

        GotState (Err (Http.BadBody _)) ->
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
