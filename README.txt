CS583 Project: Five in a Row
Xu Zheng (zhengxu) & Tien-Lung Chang (changti)
github link: https://github.com/ShannaChang/FiveInRow

1. Our goal is to implement a board game called "Five in a Row", which is
   a two players game. The first player who make a coherently sequence of
   five stones will win the game. The sequence can be vertically, horizontally
   or diagonally.

   Currently, we have defined the data type for our board and player. We
   also have completed several functions, such as a function to generate
   an initial board, a function to customize a board, a function to update
   the current game status and a loop for run the game correctly.

2. To run our project, just load "Five.hs" then input "main". There are
   some example inputs and results as follows:

   >> ghci Five.hs
   >> *Five> main
   >> Please input a number N to initialize a NxN board: 10
   >>    1  2  3  4  5  6  7  8  9  10
   >> 1  *  *  *  *  *  *  *  *  *  * 1
   >> 2  *  *  *  *  *  *  *  *  *  * 2
   >> 3  *  *  *  *  *  *  *  *  *  * 3
   >> 4  *  *  *  *  *  *  *  *  *  * 4
   >> 5  *  *  *  *  *  *  *  *  *  * 5
   >> 6  *  *  *  *  *  *  *  *  *  * 6
   >> 7  *  *  *  *  *  *  *  *  *  * 7
   >> 8  *  *  *  *  *  *  *  *  *  * 8
   >> 9  *  *  *  *  *  *  *  *  *  * 9
   >> 10 *  *  *  *  *  *  *  *  *  * 10
   >> BLACK's turn:
   >> Col: 3
   >> Row: 3
   >>    1  2  3  4  5  6  7  8  9  10
   >> 1  *  *  *  *  *  *  *  *  *  * 1
   >> 2  *  *  *  *  *  *  *  *  *  * 2
   >> 3  *  *  O  *  *  *  *  *  *  * 3
   >> 4  *  *  *  *  *  *  *  *  *  * 4
   >> 5  *  *  *  *  *  *  *  *  *  * 5
   >> 6  *  *  *  *  *  *  *  *  *  * 6
   >> 7  *  *  *  *  *  *  *  *  *  * 7
   >> 8  *  *  *  *  *  *  *  *  *  * 8
   >> 9  *  *  *  *  *  *  *  *  *  * 9
   >> 10 *  *  *  *  *  *  *  *  *  * 10
   >> WHITE's turn:
   >> Col: 4
   >> Row: 4
   >>    1  2  3  4  5  6  7  8  9  10
   >> 1  *  *  *  *  *  *  *  *  *  * 1
   >> 2  *  *  *  *  *  *  *  *  *  * 2
   >> 3  *  *  O  *  *  *  *  *  *  * 3
   >> 4  *  *  *  X  *  *  *  *  *  * 4
   >> 5  *  *  *  *  *  *  *  *  *  * 5
   >> 6  *  *  *  *  *  *  *  *  *  * 6
   >> 7  *  *  *  *  *  *  *  *  *  * 7
   >> 8  *  *  *  *  *  *  *  *  *  * 8
   >> 9  *  *  *  *  *  *  *  *  *  * 9
   >> 10 *  *  *  *  *  *  *  *  *  * 10
   >> BLACK's turn:
   >> Col:

3. Q1: What kind of ability do you think a successful A.I. must have?
   Q2: How to apply monad to our project?

