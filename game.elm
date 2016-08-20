import Html exposing (..)
-- import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Board
import Ship
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
  Board.createShips
    |> List.map Ship.toForm
    |> collage 400 400
    |> toHtml

type alias Model =
  { myBoard : Board.Model
  , otherBoard : Board.Model
  }

init : (Model, Cmd Msg)
init =
  ( { myBoard = Board.init
    , otherBoard = Board.init
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
