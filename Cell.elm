module Cell exposing (Model, init, toForm)

import Color exposing (Color)
import Collage exposing (..)

type alias Model =
  { size : Float
  , color: Color
  }

init : Model
init =
  { size = 20.0
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
