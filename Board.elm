module Board exposing (..)

import Collage exposing (..)
import Element exposing (..)

import Field

freeSpace : Float
freeSpace  = 20

type alias Model =
  { myField : Field.Model
  , otherField : Field.Model
  }

initialModel : Model
initialModel =
  let
    shiftX field =
      (field.width + freeSpace) / 2

    shiftField field =
      case field.side of
        Field.My ->
          { field | shiftAt = (shiftX field, 0) }

        Field.Opponent ->
          { field | shiftAt = (-(shiftX field), 0) }
  in
    { myField = Field.initialModel Field.My |> shiftField
    , otherField = Field.initialModel Field.Opponent |> shiftField
    }

toElement : Model -> Element
toElement model =
  [ model.myField, model.otherField ]
    |> List.map Field.toForm
    |> collage (round (freeSpace * 3 + model.myField.width + model.otherField.width)) (round (freeSpace * 2 + model.myField.height))

addNextShip : Model -> Model
addNextShip model =
  { model | myField = Field.addNextShip model.myField }

rotateCurrentShip : Model -> Model
rotateCurrentShip model =
  { model | myField = Field.rotateCurrentShip model.myField }
