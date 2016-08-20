module Board exposing (..)

import Cell
import Ship

rows : Int
rows = 10

columns : Int
columns = 10

createShips : List Ship.Model
createShips =
  let
    ships n =
      (5 - n)
      |> Ship.init n
      |> List.repeat n

  in
    List.map ships [1..4]
    |> List.foldr (++) []

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
