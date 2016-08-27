module Board exposing (..)

import Collage exposing (..)
import Element exposing (Element)
import Color exposing (Color)
import Set exposing (empty, fromList, toList, union)

import Common exposing (boardFreeSpace, fieldWidth, fieldHeight, Direction, toDimension, cellSize, shiftShip)
import Ship

type alias Model =
  { myField : Field
  , otherField : Field
  }

type Side
  = My
  | Opponent

type alias Field =
  { ships : Ships
  , side : Side
  , shiftAt : (Float, Float)
  }

type alias Ships =
  List Ship.Model

initialModel : Model
initialModel =
  let
    shiftX field =
      (fieldWidth + boardFreeSpace) / 2

    shiftField field =
      case field.side of
        My ->
          { field | shiftAt = (-(shiftX field), 0) }

        Opponent ->
          { field | shiftAt = (shiftX field, 0) }
  in
    { myField = initialField My |> shiftField
    , otherField = initialField Opponent |> shiftField
    }

initialField : Side -> Field
initialField side =
  let
    model =
      { ships = []
      , side = side
      , shiftAt = (0, 0)
      }

  in
    case side of
      My ->
        model

      Opponent ->
        model

fieldColor : Color
fieldColor = Color.lightBlue

shipLengths : List Int
shipLengths =
  List.map (\n -> List.repeat n (5 - n)) [1..4]
  |> List.foldr (++) []

toElement : Model -> Element
toElement model =
  [ model.myField, model.otherField ]
    |> List.map fieldToForm
    |> collage (round (boardFreeSpace * 3 + fieldWidth * 2)) (round (boardFreeSpace * 2 + fieldHeight))

fieldToForm : Field -> Form
fieldToForm field =
  let
    fieldRect = rect fieldWidth fieldHeight
    border = outlined (solid Color.black) fieldRect
    ships = List.map Ship.toForm field.ships
  in
    group
      [ filled fieldColor fieldRect
      , occupiedForm field.ships
      , border
      , group ships
      ]
    |> move field.shiftAt

addNextShip : Model -> Model
addNextShip model =
  { model | myField = addNextShipToField model.myField }

rotateCurrentShip : Model -> Model
rotateCurrentShip model =
  { model | myField = rotateCurrentShipInAField model.myField }

moveCurrentShip : Model -> Direction -> Model
moveCurrentShip model direction =
  { model | myField = moveCurrentShipInAField model.myField direction }

addNextShipToField : Field -> Field
addNextShipToField field =
  let
    nextShipLength =
      List.drop (List.length field.ships) shipLengths
      |> List.head
      |> Maybe.withDefault 0
  in
    case nextShipLength of
      0 ->
        field

      _ ->
        { field
          | ships = (Ship.init 0 nextShipLength) :: field.ships
        }

rotateCurrentShipInAField : Field -> Field
rotateCurrentShipInAField field =
  { field | ships = rotateFirstShip field.ships }

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

moveCurrentShipInAField : Field -> Direction -> Field
moveCurrentShipInAField field direction =
  let
    firstShip = List.head field.ships

  in
    case firstShip of
      Nothing ->
        field

      Just ship ->
        let
          moved = Ship.moveTo ship direction
          otherShips = List.tail field.ships |> Maybe.withDefault []
        in
          { field | ships = moved :: otherShips }

occupiedForm : Ships -> Form
occupiedForm ships =
  let
    pointToOccupied (row, col) =
      let
        rangeForRow row =
          Set.fromList [(row, col - 1), (row, col), (row, col + 1)]
      in
        rangeForRow (row + 1)
          |> Set.union (rangeForRow row)
          |> Set.union (rangeForRow (row - 1))

    occupied ship =
      ship.shape
        |> List.map pointToOccupied
        |> List.foldl Set.union Set.empty

    allOccupied ships =
      ships
        |> List.map occupied
        |> List.foldl Set.union Set.empty

    translate (row, column) =
      move (toDimension column, toDimension -row) form

    form =
      square cellSize
        |> filled Color.gray

    forms =
      List.tail ships
        |> Maybe.withDefault []
        |> allOccupied
        |> Set.toList
        |> List.map translate

  in
    group forms
      |> move shiftShip
