import Html exposing (..)
import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Field
-- import Ship
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Http
-- import Task
-- import Json.Decode as Json

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { myField : Field.Model
  , otherField : Field.Model
  }

freeSpace : Float
freeSpace  = 20

init : (Model, Cmd Msg)
init =
  ( { myField = Field.initialModel Field.My
    , otherField = Field.initialModel Field.Opponent
    }
  , Cmd.none
  )

type Msg
  = None

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    None ->
      (model, Cmd.none)

fieldToForm : Field.Model -> Form
fieldToForm field =
  case field.side of
    Field.My ->
      Field.toForm field |> moveX (-(field.width + freeSpace) / 2)

    Field.Opponent ->
      Field.toForm field |> moveX ((field.width + freeSpace) / 2)

view : Model -> Html Msg
view model =
  [ model.myField, model.otherField ]
    |> List.map fieldToForm
    |> collage (round (freeSpace * 3 + model.myField.width + model.otherField.width)) (round (freeSpace * 2 + model.myField.width))
    |> toHtml

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
