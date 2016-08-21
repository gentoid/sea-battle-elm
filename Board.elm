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
  { myField = Field.initialModel Field.My
  , otherField = Field.initialModel Field.Opponent
  }

fieldToForm : Field.Model -> Form
fieldToForm field =
  case field.side of
    Field.My ->
      Field.toForm field |> moveX (-(field.width + freeSpace) / 2)

    Field.Opponent ->
      Field.toForm field |> moveX ((field.width + freeSpace) / 2)

toElement : Model -> Element
toElement model =
  [ model.myField, model.otherField ]
    |> List.map fieldToForm
    |> collage (round (freeSpace * 3 + model.myField.width + model.otherField.width)) (round (freeSpace * 2 + model.myField.width))

addNextShip : Model -> Model
addNextShip model =
  { model | myField = Field.addNextShip model.myField }
