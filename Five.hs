-- CS583 Project: Five in a Row
-- Xu Zheng (zhengxu) & Tien-Lung Chang (changti)

module Five where
import System.Random

data Cell = Black
          | White
          | Blank
  deriving (Eq,Show)

data Player = First
            | Second
            | Robot
  deriving (Eq,Show)

data Board a = Board [[a]] deriving (Show)

-- Initialize the board
initBoard :: Int -> Board Cell
initBoard x = Board (replicate x (replicate x Blank))

-- Print the board
-- If Blank -> *
-- If Blakc -> O
-- If White -> X
colMark :: [[Cell]] -> Int -> IO ()
colMark [] idx = putStrLn ""
colMark (y:ys) idx | idx < 10 = putStr ((show idx) ++ "  ") >> colMark ys (idx+1)
                   | idx >= 10 = putStr ((show idx) ++ " ") >> colMark ys (idx+1)

rowMark :: [[Cell]] -> Int -> IO ()
rowMark [] idx = return ()
rowMark (y:ys) idx | idx < 10 = putStr ((show idx) ++ " ") >> showCell y idx >> rowMark ys (idx+1)
                   | idx >= 10 = putStr ((show idx) ++ "") >> showCell y idx >> rowMark ys (idx+1)

showCell :: [Cell] -> Int -> IO ()
showCell [] idx = print idx
showCell (y:ys) idx | y == Blank = putStr " * " >> showCell ys idx
                    | y == Black = putStr " O " >> showCell ys idx
                    | y == White = putStr " X " >> showCell ys idx

showBoard :: Board Cell -> IO ()
showBoard (Board (x:xs)) = putStr "   " >> colMark (x:xs) 1 >> rowMark (x:xs) 1 >>
                           putStr "   " >> colMark (x:xs) 1


-- update the board
updateBoard :: Board Cell -> Int -> Int -> Player -> Board Cell
updateBoard (Board x) col row player | player == First = Board (take (row-1) x ++ [newRow] ++ drop row x)      
                                     | player == Second = Board (take (row-1) x ++ [newRow'] ++ drop row x)
    where
      newRow  = take (col-1) (x !! (row-1)) ++ [Black] ++ drop col (x !! (row-1))
      newRow' = take (col-1) (x !! (row-1)) ++ [White] ++ drop col (x !! (row-1))


-- Check if the input stone is good
isGood :: Board Cell -> Int -> Int -> Bool
isGood (Board x) c r = x !! (r-1) !! (c-1) == Blank


currentP :: Player -> IO ()
currentP First  = putStrLn "BLACK's turn: "
currentP Second = putStrLn "WHITE's turn: "

nextP :: Player -> Player
nextP First  = Second
nextP Second = First

gameLoop :: Board Cell -> Player -> IO ()
gameLoop (Board x) player = 
    do
      showBoard (Board x)
      currentP player
      putStr "Col: "
      col <- getLine
      putStr "Row: "
      row <- getLine
      if isGood (Board x) (read col :: Int) (read row :: Int)
      then do
      gameLoop (updateBoard (Board x) (read col :: Int) (read row :: Int) player) (nextP player)
      else do
      print "Bad Position!!! Please input again."
      gameLoop (Board x) player
    

-- Add A.I.
gameLoop' (Board x) player =
    do
      if player == Second then do
        showBoard (Board x)
        currentP player
        putStr "Col: "
        col <- getLine
        putStr "Row: "
        row <- getLine
        if isGood (Board x) (read col :: Int) (read row :: Int)
          then do
          gameLoop' (updateBoard (Board x) (read col :: Int) (read row :: Int) player) (nextP player)
          else do
          print "Bad Position!!! Please input again."
          gameLoop' (Board x) player
      else do
        showBoard (Board x)
        currentP player
        col <- randomRIO(1,15) >>= (\x -> return x)
        putStr "Col: "
        print col
        row <- randomRIO(1,15) >>= (\x -> return x)
        putStr "Row: "
        print row
        if isGood (Board x) col row
          then do
          gameLoop' (updateBoard (Board x) col row player) (nextP player)
          else do
          print "Bad Position!!! Please input again."
          gameLoop' (Board x) player


-- Game begins here
-- Players set the width and heigh of the board
main :: IO ()
main = do
    print "Do you want to play with A.I.? (yes/no)"
    s <- getLine
    if s == "yes"
      then do
      gameLoop' (initBoard 15) First
      else if s == "no"
        then do
        gameLoop (initBoard 15) First
        else do
          main