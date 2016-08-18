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
