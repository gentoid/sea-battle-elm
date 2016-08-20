import Html exposing (..)
import Html.App as App
-- import Collage exposing (toForm, Form, rect, square)
import Collage exposing (..)
import Element exposing (..)
import Board
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
  { myBoard : Board.Model
  , otherBoard : Board.Model
  }

init : (Model, Cmd Msg)
init =
  ( { myBoard = Board.initialModel Board.My
    , otherBoard = Board.initialModel Board.Opponent
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
  [ Board.toForm model.myBoard ]
    |> collage 400 400
    |> toHtml

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
