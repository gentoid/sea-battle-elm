import Html exposing (..)
-- import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Field
import Ship
import ShipBlock
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


ship : Ship.Model
ship =
  { shape =
    [ (1, 0)
    , (0, 0)
    , (-1, 0)
    , (-2, 0)
    ]
  , block = ShipBlock.init
  }

main : Html Msg
main =
  [Ship.toForm ship]
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
