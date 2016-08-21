module Common exposing (..)


boardFreeSpace : Float
boardFreeSpace = 20

cellSize : Float
cellSize = 20.0

fieldRows : Int
fieldRows = 10

fieldCols : Int
fieldCols = 10

toDimension : Int -> Float
toDimension n =
  (toFloat n) * cellSize

fieldWidth : Float
fieldWidth =
  toDimension fieldCols

fieldHeight : Float
fieldHeight =
  toDimension fieldRows

shiftShip : (Float, Float)
shiftShip =
  let
    shiftX = -(fieldWidth - cellSize) / 2
    shiftY = (fieldHeight - cellSize) / 2
  in
    (shiftX, shiftY)
