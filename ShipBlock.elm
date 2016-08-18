module ShipBlock exposing (..)

import Color exposing (Color)
import Collage exposing (..)
import Cell as Cell

type alias Model =
  { color: Color
  , borderColor : Color
  }

init : Model
init =
  Model Color.black Color.white

toForm : Model -> Form
toForm model =
  let
    shape = square Cell.size
    border = outlined (solid model.borderColor) shape
  in
    group
      [ filled model.color shape
      , border
      ]
