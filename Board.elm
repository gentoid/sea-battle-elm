module Board exposing (..)
import Color exposing (Color)
import Collage exposing (..)

import Cell
import Ship

rows : Int
rows = 10

columns : Int
columns = 10

color : Color
color = Color.lightBlue

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
  { ships : List Ship.Model
  }

type Side
  = My
  | Opponent

initialModel : Side -> Model
initialModel side =
  case side of
    My ->
      { ships = createShips }

    Opponent ->
      { ships = [] }

toForm : Model -> Form
toForm model =
  -- model.ships
  --   |> List.map Ship.toForm
  --   |> collage 400 400

  let
    board = rect ((toFloat columns) * Cell.size) ((toFloat rows) * Cell.size)
    border = outlined (solid Color.lightBlue) board
  in
    group
      [ filled color board
      , border
      ]
