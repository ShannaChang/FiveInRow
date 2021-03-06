-- CS583 Project: Five in a Row
-- Xu Zheng (zhengxu) & Tien-Lung Chang (changti)

module Five where
import System.Random

data Cell = Black
          | White
          | Blank
  deriving (Eq,Show)

data Player = Human Cell
            | AI    Cell
  deriving (Eq,Show)

data Mode = Single
          | Duo
  deriving (Eq,Show)

data Board a = Board [[a]] deriving (Show)

-- Initialize the board
initBoard :: Int -> Board Cell
initBoard x = Board (replicate x (replicate x Blank))

-- Print the board
-- If Blank -> *
-- If Blakc -> O
-- If White -> X

-- Print the column number
colMark :: [[Cell]] -> Int -> IO ()
colMark [] idx = putStrLn ""
colMark (y:ys) idx | idx <  10 = putStr ((show idx) ++ "  ") >> colMark ys (idx+1)
                   | idx >= 10 = putStr ((show idx) ++ " " ) >> colMark ys (idx+1)

-- Print the row number
rowMark :: [[Cell]] -> Int -> IO ()
rowMark [] idx = return ()
rowMark (y:ys) idx | idx <  10 = putStr ((show idx) ++ " ") >> showCell y idx >> rowMark ys (idx+1)
                   | idx >= 10 = putStr ((show idx) ++ "" ) >> showCell y idx >> rowMark ys (idx+1)

-- Print the cells
showCell :: [Cell] -> Int -> IO ()
showCell [] idx = print idx
showCell (y:ys) idx | y == Blank = putStr " * " >> showCell ys idx
                    | y == Black = putStr " O " >> showCell ys idx
                    | y == White = putStr " X " >> showCell ys idx

showBoard :: Board Cell -> IO ()
showBoard (Board (x:xs)) = putStr "   " >> colMark (x:xs) 1 >> rowMark (x:xs) 1 >>
                           putStr "   " >> colMark (x:xs) 1

-- Update the status of the board
updateBoard :: Board Cell -> Int -> Int -> Player -> Board Cell
updateBoard (Board x) col row player = Board (take (row-1) x ++ [newRow] ++ drop row x)
    where
      newRow  = take (col-1) (x !! (row-1)) ++ [cellColor player] ++ drop col (x !! (row-1))

-- Check if the player make a coherently sequence of five stones 
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

-- Get the position of the stone
getPos :: Board Cell -> Int -> Int -> Cell
getPos (Board x) c r = x !! (r-1) !! (c-1)

-- Check the board status
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


-- Check if the input stone is valid
isGood :: Board Cell -> Int -> Int -> Bool
isGood (Board x) c r = (getPos (Board x) c r) == Blank

-- A higher order function for the currentPlayer cellColor nextPlayer function 
helper :: t -> t -> Player -> t
helper a _ ( Human Black ) = a
helper _ b ( Human White) = b
helper a _ ( AI Black ) = a
helper _ b ( AI White) = b

-- Print our the current player
currentPlayer :: Player -> IO()
currentPlayer = helper (putStrLn "BLACK's turn: ") (putStrLn "WHITE's turn: ")

-- Get the color of the stone need to input
cellColor :: Player -> Cell
cellColor = helper Black White

-- Decide next turn is which player's
nextPlayer :: Player -> Mode -> Player
nextPlayer (Human o)     Duo    = helper (Human White) (Human Black) (Human o)
nextPlayer (Human Black) Single = helper (AI White) (Human Black) (Human Black)
nextPlayer (Human White) Single = helper (Human White) (AI Black) (Human White)
nextPlayer (AI Black) _ = helper (Human White) (AI Black) (AI Black)
nextPlayer (AI White) _ = helper (AI White) (Human Black) (AI White)

-- Check if the input is valid
isNumber :: String -> Bool
isNumber str =
    case (reads str) :: [(Double, String)] of
      [(_, "")] -> True
      _         -> False

-- Get column position from input
getCol :: IO String
getCol = do
  putStr "Col: "
  c <- getLine
  if isNumber c 
    then return c
    else do 
      putStrLn "Please enter a valid position."
      getCol

-- Get row position from input
getRow :: IO String
getRow = do
  putStr "Row: "
  c <- getLine
  if isNumber c 
    then return c
    else do
      putStrLn "Please enter a valid position." 
      getRow

-- A function to manage all operations at every single turn 
loopfunc :: Board Cell -> Int -> Int -> Player -> Mode -> IO ()
loopfunc (Board x) col row player m = 
    do
      if isGood (Board x) col row
      then do
        if checkFive (checkList (Board x) col row) (cellColor player)
         then do
          showBoard (updateBoard (Board x) col row player)
          putStrLn "You Win!!!"
        else
          gameLoop (updateBoard (Board x) col row player) (nextPlayer player m) m
      else do
        print "Bad Position!!! Please input again."
        gameLoop (Board x) player m

-- A loop for generate every game 
gameLoop :: Board Cell -> Player -> Mode -> IO ()
gameLoop (Board x) (AI o) m = 
  do showBoard (Board x)
     currentPlayer (AI o)
     col <- randomRIO(1,15) >>= (\x -> return x)
     putStr "Col: "
     print col
     row <- randomRIO(1,15) >>= (\x -> return x)
     putStr "Row: "
     print row
     loopfunc (Board x) col row (AI o) m

gameLoop (Board x) (Human o) m =
  do showBoard (Board x)
     currentPlayer (Human o)
     c <- getCol
     r <- getRow
     let col = read c :: Int
     let row = read r :: Int
     loopfunc (Board x) col row (Human o) m

-- Set the game mode according to the input
whichMode :: String -> IO ()
whichMode s
    | s == "1"  = gameLoop (initBoard 15) (AI Black)    Single
    | s == "2"  = gameLoop (initBoard 15) (Human Black) Single
    | s == "3"  = gameLoop (initBoard 15) (Human Black) Duo
    | otherwise = main

-- Game begins here
-- Player choose the game mode
main :: IO ()
main = do
    putStrLn "Please choose one mode."
    putStrLn "1: Play against AI(Black)"
    putStrLn "2: Play against AI(White)"
    putStrLn "3: Play against another player"
    putStr   "Enter the mode number you choose (1/2/3): "
    s <- getLine
    whichMode s