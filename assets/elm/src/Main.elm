module Main exposing (..)

import Browser
import Html exposing (Html, text, button, div, h1, img)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (Decoder, field, int, string)


---- MODEL ----


type alias Model =
    {pc: Maybe Int}


init : ( Model, Cmd Msg )
init =
    ( {pc = Nothing}
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
      ({model | pc = Just value}, Cmd.none)
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
         h1 [] [ text "TRS80 Emulator" ]
         , div [] [
           div [] [text "PC"]
           , div [] [ text (formatPc model.pc)]
           , button [] [text "Fetch"]
           ]
        ]

formatPc : (Maybe Int) -> String
formatPc val =
  case val of
    Nothing ->
      "Not initialized"
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
