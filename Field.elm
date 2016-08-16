module Field exposing (..)

import Collage exposing (..)
import Element exposing (..)
import Cell as Cell

type alias Model =
  { hSize : Int
  , vSize : Int
  , cells : List Cell.Model
  }

init : Model
init =
  let
    hSize = 10
    vSize = 10
  in
    { hSize = hSize
    , vSize = vSize
    , cells = List.map (always Cell.init) [0..(hSize * vSize)]
    }
