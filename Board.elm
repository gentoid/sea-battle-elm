module Board exposing (..)

import Collage exposing (..)
import Element exposing (Element)

import Common exposing (boardFreeSpace, fieldWidth, fieldHeight, Direction)
import Field

type alias Model =
  { myField : Field.Model
  , otherField : Field.Model
  }

initialModel : Model
initialModel =
  let
    shiftX field =
      (fieldWidth + boardFreeSpace) / 2

    shiftField field =
      case field.side of
        Field.My ->
          { field | shiftAt = (-(shiftX field), 0) }

        Field.Opponent ->
          { field | shiftAt = (shiftX field, 0) }
  in
    { myField = Field.initialModel Field.My |> shiftField
    , otherField = Field.initialModel Field.Opponent |> shiftField
    }

toElement : Model -> Element
toElement model =
  [ model.myField, model.otherField ]
    |> List.map Field.toForm
    |> collage (round (boardFreeSpace * 3 + fieldWidth * 2)) (round (boardFreeSpace * 2 + fieldHeight))

addNextShip : Model -> Model
addNextShip model =
  { model | myField = Field.addNextShip model.myField }

rotateCurrentShip : Model -> Model
rotateCurrentShip model =
  { model | myField = Field.rotateCurrentShip model.myField }

moveCurrentShip : Model -> Direction -> Model
moveCurrentShip model direction =
  { model | myField = Field.moveCurrentShip model.myField direction }
