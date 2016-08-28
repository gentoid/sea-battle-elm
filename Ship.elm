module Ship exposing (..)

import Collage exposing (..)
import Color exposing (Color)
import List

import Common exposing (shiftShip, toDimension, cellSize, Direction(..), fieldRows, fieldCols)

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

shipForm : Block -> Model -> Form
shipForm block {shape} =
  let
    form =
      blockToForm block

    translate (row, column) =
      move (toDimension column, toDimension -row) form

    forms =
      List.map translate shape

  in
    group forms |> move shiftShip

toForm : Model -> Form
toForm ship =
  shipForm initBlock ship

toInvalidForm : Model -> Form
toInvalidForm ship =
  let
    block =
      Block (Color.rgba 169 3 3 0.5) Color.red
  in
    shipForm block ship

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
  let
    (baseRow, baseCol) = ship.base

    translate (row, col) =
      let
        newRow = baseRow - col + baseCol
        newCol = baseCol + row - baseRow
      in
        (newRow, newCol)

    newShip =
      { ship
        | shape = List.map translate ship.shape
        , rows = ship.cols
        , cols = ship.rows
      }

  in
    newShipIfInsideField ship newShip

moveTo : Model -> Direction -> Model
moveTo ship direction =
  let
    movement (row, col) =
      case direction of
        Left  -> (row,     col - 1 )
        Up    -> (row - 1, col     )
        Right -> (row,     col + 1 )
        Down  -> (row + 1, col     )

    newShip =
      { ship
        | shape = List.map movement ship.shape
        , base = movement ship.base
      }

  in
    newShipIfInsideField ship newShip

newShipIfInsideField : Model -> Model -> Model
newShipIfInsideField ship newShip =
  case isOutOfField newShip of
    True  -> ship
    False -> newShip

isOutOfField : Model -> Bool
isOutOfField ship =
  let
    pointIsOutOfField (row, col) =
      row < 0 || row >= fieldRows || col < 0 || col >= fieldCols

  in
    List.any pointIsOutOfField ship.shape
