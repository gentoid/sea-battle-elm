import Html exposing (..)
import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Board
-- import Ship
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Http
-- import Task
-- import Json.Decode as Json

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { myBoard : Board.Model
  , otherBoard : Board.Model
  }

freeSpace : Float
freeSpace  = 20

init : (Model, Cmd Msg)
init =
  ( { myBoard = Board.initialModel Board.My
    , otherBoard = Board.initialModel Board.Opponent
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

boardToForm : Board.Model -> Form
boardToForm board =
  case board.side of
    Board.My ->
      Board.toForm board |> moveX (-(board.width + freeSpace) / 2)

    Board.Opponent ->
      Board.toForm board |> moveX ((board.width + freeSpace) / 2)

view : Model -> Html Msg
view model =
  [ model.myBoard, model.otherBoard ]
    |> List.map boardToForm
    |> collage (round (freeSpace * 3 + model.myBoard.width + model.otherBoard.width)) (round (freeSpace * 2 + model.myBoard.width))
    |> toHtml

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
