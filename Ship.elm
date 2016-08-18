module Ship exposing (..)

import Collage exposing (..)
import ShipBlock
import Cell
import List

type alias Location = (Int, Int)

type alias Model =
  { shape : List Location
  , block : ShipBlock.Model
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
    Model (createShape length) ShipBlock.init

toForm : Model -> Form
toForm {shape, block} =
  let
    form =
      ShipBlock.toForm block

    toCoordinate dim =
      (toFloat dim) * Cell.size

    translate (row, column) =
      move ((toCoordinate column), (toCoordinate row)) form

    forms =
      List.map translate shape

  in
    group forms
