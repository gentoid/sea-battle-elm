import Html exposing (..)
-- import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Cell as Cell
import Field as Field
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Http
-- import Task
-- import Json.Decode as Json

-- main : Program Never
-- main =
--   App.program
--     { init = init
--     , view = view
--     , update = update
--     , subscriptions = subscriptions
--     }

main : Html Msg
main =
  [Cell.init]
    |> List.map Cell.toForm
    |> collage 400 400
    |> toHtml

type alias Model =
  { myField : Field.Model
  , otherField : Field.Model
  }

init : (Model, Cmd Msg)
init =
  ( { myField = Field.init
    , otherField = Field.init
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

view : Model -> Html Msg
view model =
  div [] []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
