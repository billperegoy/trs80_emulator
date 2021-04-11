module Main exposing (..)

import Browser
import Html exposing (Html, text, button, div, h1, img)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (Decoder, field, int, string)


---- MODEL ----


type alias Model =
    {pc: Int}


init : ( Model, Cmd Msg )
init =
    ( {pc = 5555}
     , Http.get
          { url = "http://localhost:4000/api/state"
               , expect = Http.expectJson GotState decoder
                    } )


decoder : Decoder Int
decoder = field "pc" int

---- UPDATE ----


type Msg
    = NoOp
      | GotState (Result Http.Error Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    GotState (Ok value) ->
      ({model | pc = value}, Cmd.none)
    GotState (Err (Http.BadUrl _)) ->
      (model , Cmd.none)
    GotState (Err Http.Timeout) ->
      (model  , Cmd.none)
    GotState (Err Http.NetworkError) ->
      (model  , Cmd.none)
    GotState (Err (Http.BadStatus _)) ->
      (model  , Cmd.none)
    GotState (Err (Http.BadBody _)) ->
      (model  , Cmd.none)



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [
         h1 [] [ text "Z80 Emulator" ]
         , div [] [
           div [] [text "PC"]
           , div [] [ text (String.fromInt model.pc)]
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
