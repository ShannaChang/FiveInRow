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

-- update the current status of the board
updateBoard :: Board Cell -> Int -> Int -> Player -> Board Cell
updateBoard (Board x) col row player = Board (take (row-1) x ++ [newRow] ++ drop row x)
    where
      newRow  = take (col-1) (x !! (row-1)) ++ [cellColor player] ++ drop col (x !! (row-1))

-- check whether the player make a coherently sequence of five stones 
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
getPos (Board x) c r = x !! (r-1) !! (c-1)

-- check the board status
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

currentPlayer :: Player -> IO()
currentPlayer = helper (putStrLn "BLACK's turn: ") (putStrLn "WHITE's turn: ")

cellColor :: Player -> Cell
cellColor = helper Black White

nextPlayer :: Player -> Mode -> Player
nextPlayer (Human o) Duo    = helper (Human White) (Human Black) (Human o)
nextPlayer (Human Black) Single = helper (AI White) (Human Black) (Human Black)
nextPlayer (Human White) Single = helper (Human White) (AI Black) (Human White)

nextPlayer (AI Black) _ = helper (Human White) (AI Black) (AI Black)
nextPlayer (AI White) _ = helper (AI White) (Human Black) (AI White)

-- Check input is valid input
isNumber :: String -> Bool
isNumber str =
    case (reads str) :: [(Double, String)] of
      [(_, "")] -> True
      _         -> False

-- get column position
getCol :: IO String
getCol = do
  putStr "Col: "
  c <- getLine
  if isNumber c 
    then return c
    else do 
      putStrLn "Please enter a valid position."
      getCol

-- get row position
getRow :: IO String
getRow = do
  putStr "Row: "
  c <- getLine
  if isNumber c 
    then return c
    else do
      putStrLn "Please enter a valid position." 
      getRow

-- A function for every loop 
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

-- Game begins here
-- Players choose whether they want to play with AI or real player
main :: IO ()
main = do
    print "Do you want to play with A.I.? (y/n)"
    s <- getLine
    if s == "y"
      then do
      gameLoop (initBoard 15) (AI Black) Single
      else if s == "n"
        then do
        gameLoop (initBoard 15) (Human Black) Duo
        else do
          main