module Field exposing (..)
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
  , side : Side
  , width : Float
  , height : Float
  }

type Side
  = My
  | Opponent

initialModel : Side -> Model
initialModel side =
  let
    toDimension n =
      (toFloat n) * Cell.size

    model =
      { ships = []
      , side = side
      , width = toDimension columns
      , height = toDimension rows
      }

  in
    case side of
      My ->
        { model | ships = createShips }

      Opponent ->
        model

toForm : Model -> Form
toForm model =
  -- model.ships
  --   |> List.map Ship.toForm
  --   |> collage 400 400

  let
    field = rect model.width model.height
    border = outlined (solid Color.black) field
  in
    group
      [ filled color field
      , border
      ]
