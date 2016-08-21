module Ship exposing (..)

import Collage exposing (..)
import Color exposing (Color)
import List

import Common exposing (shiftShip, toDimension, cellSize, Direction(..))

type alias Location = (Int, Int)

type alias Model =
  { shape : List Location
  , base : Location
  , rows : Int
  , cols : Int
  }

type alias Block =
  { color : Color
  , borderColor : Color
  }

init : Int -> Int -> Model
init column length =
  let
    createShape length =
      case length of
        0 ->
          []

        _ ->
          ((length - 1), column) :: createShape (length - 1)

  in
    Model (createShape length) (0, 0) length 1

initBlock : Block
initBlock =
  Block Color.black Color.white

toForm : Model -> Form
toForm {shape} =
  let
    form =
      blockToForm initBlock

    translate (row, column) =
      move (toDimension column, toDimension -row) form

    forms =
      List.map translate shape

  in
    group forms |> move shiftShip

blockToForm : Block -> Form
blockToForm block =
  let
    shape = square cellSize
    border = outlined (solid block.borderColor) shape
  in
    group
      [ filled block.color shape
      , border
      ]

rotate : Model -> Model
rotate ship =
  { ship
    | shape = List.map (\(row, col) -> (-col, row)) ship.shape
    , rows = ship.cols
    , cols = ship.rows
  }

moveTo : Model -> Direction -> Model
moveTo model direction =
  let
    movement (row, col) =
      case direction of
        Left  -> (row,     col - 1 )
        Up    -> (row - 1, col     )
        Right -> (row,     col + 1 )
        Down  -> (row + 1, col     )

  in
    { model | shape = List.map movement model.shape, base = movement model.base }
