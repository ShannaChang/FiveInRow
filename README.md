# CS583 Project: Five in a Row

### Contributor
* Xu Zheng (zhengxu) 
* Tien-Lung Chang (changti)

### Description

   Our goal is to implement a board game called "Five in a Row", which is
   a two players game. The first player who make a coherently sequence of
   five stones will win the game. The sequence can be vertically, horizontally
   or diagonally. We also implement a simple A.I., so the player can determine 
   who they want to play with. 

   Currently, we have defined the data type for our board and player. We
   also have completed several functions, such as a function to generate
   an initial board, a function to customize a board, a function to update
   the current game status and a loop for run the game correctly.

### Execute

   To run our project, just load "Five.hs" then input "main". There are
   some example inputs and results as follows:

   ```
   >> ghci Five.hs
   >> *Five> main
   "Do you want to play with A.I.? (yes/no)"
   yes
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   1  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 1
   2  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 2
   3  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 3
   4  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 4
   5  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 5
   6  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 6
   7  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 7
   8  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 8
   9  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 9
   10 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 10
   11 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 11
   12 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 12
   13 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 13
   14 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 14
   15 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 15
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   BLACK's turn:
   Col: 8
   Row: 4
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   1  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 1
   2  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 2
   3  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 3
   4  *  *  *  *  *  *  *  O  *  *  *  *  *  *  * 4
   5  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 5
   6  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 6
   7  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 7
   8  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 8
   9  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 9
   10 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 10
   11 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 11
   12 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 12
   13 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 13
   14 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 14
   15 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 15
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   WHITE's turn:
   Col: 9
   Row: 5
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   1  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 1
   2  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 2
   3  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 3
   4  *  *  *  *  *  *  *  O  *  *  *  *  *  *  * 4
   5  *  *  *  *  *  *  *  *  X  *  *  *  *  *  * 5
   6  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 6
   7  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 7
   8  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 8
   9  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 9
   10 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 10
   11 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 11
   12 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 12
   13 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 13
   14 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 14
   15 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 15
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   ```

### Question need to figure out
* Q1: What kind of ability do you think a successful A.I. must have?
* Q2: How to apply monad to our project?

