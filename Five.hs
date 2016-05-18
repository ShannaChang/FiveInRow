-- CS583 Project: Five in a Row
-- Xu Zheng (zhengxu) & Tien-Lung Chang (changti)

module Five where
import System.Random
--import SimpleAI

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
showBoard :: Board Cell -> IO ()
showBoard (Board (x:xs)) = 
    let
        colMark [] idx = putStrLn ""
        colMark (y:ys) idx | idx < 10 = do putStr ((show idx) ++ "  ")
                                           colMark ys (idx+1)
                           | idx >= 10 = do putStr((show idx) ++ " ")
                                            colMark ys (idx+1)

        rowMark [] idx = return ()
        rowMark (y:ys) idx | idx < 10 = do putStr ((show idx) ++ " ")
                                           showCell y idx
                                           rowMark ys (idx+1)
                           | idx >= 10 = do putStr ((show idx) ++ "")
                                            showCell y idx
                                            rowMark ys (idx+1)

        showCell [] idx    = print idx
        showCell (y:ys) idx | y == Blank = do putStr " * "
                                              showCell ys idx
                            | y == Black = do putStr " O "
                                              showCell ys idx
                            | y == White = do putStr " X "
                                              showCell ys idx
    in
        do
            putStr "   "
            colMark (x:xs) 1
            rowMark (x:xs) 1
            putStr "   "
            colMark (x:xs) 1


updateBoard :: Board Cell -> Int -> Int -> Player -> Board Cell
updateBoard (Board x) col row player | player == First = Board (take (row-1) x ++ [newRow] ++ drop row x)      
                                     | player == Second = Board (take (row-1) x ++ [newRow'] ++ drop row x)
      where
        newRow  = take (col-1) (x !! (row-1)) ++ [Black] ++ drop col (x !! (row-1))
        newRow' = take (col-1) (x !! (row-1)) ++ [White] ++ drop col (x !! (row-1))


-- check five
checkFive :: [[Cell]] -> Cell -> Bool
checkFive xs x | xs == [] = False
               | otherwise =
      let
        checkLoop lst cnt | cnt >= 5         = True
                          | lst == []        = checkFive (tail xs) x
                          | head lst == x    = checkLoop (tail lst) (cnt+1)
                          | otherwise        = checkLoop (tail lst) 1
      in
        checkLoop (head xs) 1

getPos :: Board Cell -> Int -> Int -> Cell
getPos (Board board) x y = board !! (y-1) !! (x-1)

checkList :: Board Cell -> Int -> Int -> [[Cell]]
checkList (Board board) x y =
    let
        getRow = board !! (y-1)
        getCol = map (!! (x-1)) board
        width  = (length (head board))+1
        height = (length board)+1

        startUL | x < y        = (1, y-x+1)
                | otherwise    = (x-y+1, 1)
        startUR | width-x < y  = (width-1, y-(width-x))
                | otherwise    = (x+y-1, 1)

        getULtoDR x y lst | x < width && y < height = getULtoDR (x+1) (y+1) (lst ++ [(getPos (Board board) x y)])
                          | otherwise               = lst
        getURtoDL x y lst | 1 < x && y < height = getURtoDL (x-1) (y+1) (lst ++ [(getPos (Board board) x y)])
                          | otherwise            = lst
    in
        [getRow,
         getCol,
         getULtoDR (fst startUL) (snd startUL) [],
         getURtoDL (fst startUR) (snd startUR) []]


-- Check if the input stone is good
isGood :: Board Cell -> Int -> Int -> Bool
isGood (Board x) c r = x !! (r-1) !! (c-1) == Blank


currentP :: Player -> IO ()
currentP First  = putStrLn "BLACK's turn: "
currentP Second = putStrLn "WHITE's turn: "

nextP :: Player -> Player
nextP First  = Second
nextP Second = First

checkP :: Player -> Cell
checkP First = Black
checkP Second = White


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
       if checkFive (checkList (Board x) (read col :: Int) (read row :: Int)) (checkP player)
        then do 
          putStrLn "Win"
        else
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
            if checkFive (checkList (Board x) (read col :: Int) (read row :: Int)) (checkP player)
            then do 
              putStrLn "Win"
            else
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