import Html exposing (..)
import Html.App as App
import Element exposing (toHtml)

import Board

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { board : Board.Model
  }

init : (Model, Cmd Msg)
init =
  ( { board = Board.initialModel
    }
  , Cmd.none
  )

type Msg
  = None

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    None ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  Board.toElement model.board
    |> toHtml

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
