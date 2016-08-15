module Cell exposing (Cell, initCell, cellToForm)

import Color exposing (Color)
import Collage exposing (..)

type alias Cell =
  { size : Float
  , color: Color
  }

initCell : Cell
initCell =
  { size = 20.0
  , color = Color.darkBlue
  }

cellToForm : Cell -> Form
cellToForm cell =
  let
    shape = square cell.size
    border = outlined (solid Color.lightBlue) shape
  in
    group
      [ filled cell.color shape
      , border
      ]
