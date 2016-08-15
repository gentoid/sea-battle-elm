import Html exposing (..)
-- import Html.App as App
import Color exposing (Color)
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
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
  [initCell]
    |> List.map cellToForm
    |> collage 400 400
    |> toHtml

type alias Model =
  { myField : Field
  , otherField : Field
  }

type alias Field =
  { hSize : Int
  , vSize : Int
  , cells : List Cell
  }

type alias Cell =
  { size : Float
  , color: Color
  }

cellToForm : Cell -> Form
cellToForm cell =
  let
    shape = square cell.size
    border = outlined (solid Color.lightBlue) shape
  in
    group
      [ filled cell.color shape
      , border
      ]

initField : Field
initField =
  let
    hSize = 10
    vSize = 10
  in
    { hSize = hSize
    , vSize = vSize
    , cells = List.map (always initCell) [0..(hSize * vSize)]
    }

initCell : Cell
initCell =
  { size = 20.0
  , color = Color.darkBlue
  }

init : (Model, Cmd Msg)
init =
  ( { myField = initField
    , otherField = initField
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
