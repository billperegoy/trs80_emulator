module Main exposing (..)

import Browser
import Html exposing (Html, text, button, div, h1, img)
import Html.Attributes exposing (src)
import Http


---- MODEL ----


type alias Model =
    {pc: String}


init : ( Model, Cmd Msg )
init =
    ( {pc = "Unknown"}
     , Http.get
          { url = "http://localhost:4000/api/state"
               , expect = Http.expectString GotState
                    } )



---- UPDATE ----


type Msg
    = NoOp
      | GotState (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    GotState (Ok value) ->
      ({model | pc = value}, Cmd.none)
    GotState (Err (Http.BadUrl _)) ->
      ({model | pc = "badurl"} , Cmd.none)
    GotState (Err Http.Timeout) ->
      ({model | pc = "timeout"} , Cmd.none)
    GotState (Err Http.NetworkError) ->
      ({model | pc = "network error"} , Cmd.none)
    GotState (Err (Http.BadStatus _)) ->
      ({model | pc = "bad status"} , Cmd.none)
    GotState (Err (Http.BadBody _)) ->
      ({model | pc = "bad body"} , Cmd.none)



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [
         h1 [] [ text "Z80 Emulator" ]
         , div [] [
           div [] [text "PC"]
           , div [] [ text model.pc]
           , button [] [text "Fetch"]
           ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
