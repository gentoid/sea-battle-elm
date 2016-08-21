module Field exposing (..)
import Color exposing (Color)
import Collage exposing (..)

import Common
import Ship

color : Color
color = Color.lightBlue

shipLengths : List Int
shipLengths =
  List.map (\n -> List.repeat n (5 - n)) [1..4]
  |> List.foldr (++) []

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
  { ships : Ships
  , side : Side
  , width : Float
  , height : Float
  , shiftAt : (Float, Float)
  }

type alias Ships =
  List Ship.Model

type Side
  = My
  | Opponent

initialModel : Side -> Model
initialModel side =
  let
    toDimension n =
      (toFloat n) * Common.cellSize

    model =
      { ships = []
      , side = side
      , width = toDimension Common.fieldCols
      , height = toDimension Common.fieldRows
      , shiftAt = (0, 0)
      }

  in
    case side of
      My ->
        model

      Opponent ->
        model

toForm : Model -> Form
toForm model =
  let
    field = rect model.width model.height
    border = outlined (solid Color.black) field
    ships = List.map Ship.toForm model.ships
  in
    group
      [ filled color field
      , border
      , group ships
      ]
    |> move model.shiftAt

addNextShip : Model -> Model
addNextShip model =
  let
    nextShipLength =
      List.drop (List.length model.ships) shipLengths
      |> List.head
      |> Maybe.withDefault 0
  in
    case nextShipLength of
      0 ->
        model

      _ ->
        { model
          | ships = (Ship.init 0 nextShipLength) :: model.ships
        }

rotateCurrentShip : Model -> Model
rotateCurrentShip model =
  { model | ships = rotateFirstShip model.ships }

rotateFirstShip : Ships -> Ships
rotateFirstShip ships =
  let
    firstShip = List.head ships

  in
    case firstShip of
      Nothing ->
        ships

      Just ship ->
        let
          rotated = Ship.rotate ship
          otherShips = List.tail ships |> Maybe.withDefault []
        in
          rotated :: otherShips
