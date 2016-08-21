module Ship exposing (..)

import Collage exposing (..)
import Color exposing (Color)
import List

import Cell

type alias Location = (Int, Int)

type alias Model =
  { shape : List Location
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
    Model (createShape length)

initBlock : Block
initBlock =
  Block Color.black Color.white

toForm : Model -> Form
toForm {shape} =
  let
    form =
      blockToForm initBlock

    toCoordinate dim =
      (toFloat dim) * Cell.size

    translate (row, column) =
      move ((toCoordinate column), (toCoordinate row)) form

    forms =
      List.map translate shape

  in
    group forms

blockToForm : Block -> Form
blockToForm block =
  let
    shape = square Cell.size
    border = outlined (solid block.borderColor) shape
  in
    group
      [ filled block.color shape
      , border
      ]
