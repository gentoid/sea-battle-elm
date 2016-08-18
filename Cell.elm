module Cell exposing (Model, init, toForm, size)

import Color exposing (Color)
import Collage exposing (..)

size : Float
size = 20.0

type alias Model =
  { size : Float
  , color: Color
  }

init : Model
init =
  { size = size
  , color = Color.darkBlue
  }

toForm : Model -> Form
toForm cell =
  let
    shape = square cell.size
    border = outlined (solid Color.lightBlue) shape
  in
    group
      [ filled cell.color shape
      , border
      ]
