import Html exposing (..)
import Html.App as App
import Html.Events exposing (onClick)
import Element exposing (toHtml)
import Keyboard

import Common exposing (Direction(..))
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
  | AddNextShip
  | KeyMsg Keyboard.KeyCode
  | RotateShip
  | MoveShip Direction

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    None ->
      (model, Cmd.none)

    AddNextShip ->
      ( { model
          | board = Board.addNextShip model.board
        }
      , Cmd.none
      )

    KeyMsg keyCode ->
      case keyCode of
        32 -> -- spacebar
          update RotateShip model

        37 -> -- left arrow
          update (MoveShip Left) model

        38 -> -- up arrow
          update (MoveShip Up) model

        39 -> -- right arrow
          update (MoveShip Right) model

        40 -> -- down arrow
          update (MoveShip Down) model

        _ ->
          (model, Cmd.none)

    RotateShip ->
      ( { model
        | board = Board.rotateCurrentShip model.board
        }
      , Cmd.none
      )

    MoveShip direction ->
      ( { model | board = Board.moveCurrentShip model.board direction }
      , Cmd.none
      )

view : Model -> Html Msg
view model =
  div []
    [ Board.toElement model.board
      |> toHtml
    , button [ onClick AddNextShip ] [ text "Next ship" ]
    , div []
      [ text "Ships:"
      , model |> toString |> text
      ]
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [
    Keyboard.downs KeyMsg
  ]
