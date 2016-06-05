# Five in a Row

### Contributor
* Xu Zheng (zhengxu) 
* Tien-Lung Chang (changti)

### Overview

   Our project is to implement board game called “Five in a Row” (which is 
   also known as “Gomoku” in Japanese). It is a two players game that is  
   suitable for all ages. The principle for this game is the first player 
   who make a coherently sequence of five stones will win the game. The 
   sequence can be vertically, horizontally or diagonally. The user can 
   choose to play against another user or the A.I.. The program will check 
   if there is a winner at the end of every turn.

### Quick links
*  [Code](https://github.com/ShannaChang/FiveInRow/blob/master/Five.hs)
*  [Download](https://github.com/ShannaChang/FiveInRow.git)
*  [Project Report](https://github.com/ShannaChang/FiveInRow/blob/master/Report_1.0.docx)

### Quick guide
*  The game start from the selection of playing with AI or not.
*  The board will update every round, so that you can get the latest board and make a decision.
*  If you input a invalid (ex: a char or a space), you need to enter a number again.
*  Once you put a stone on the board, you will no longer to change the position.
*  Whoever get a sequence of five stone will win the game. 

### Execute
1. [Download](https://github.com/ShannaChang/FiveInRow.git) the recent version of Five.hs
2. Use ghci Five.hs to run the file.
3. Type "main". 

### Result

   After run our project, there are some example inputs and results shown as below:

   ```
   >> ghci Five.hs
   >> *Five> main
   "Do you want to play with A.I.? (Y/N)"
   Y
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

   Any player get a sequesnce of five stone will win the game.

   ```
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   1  O  *  *  *  *  *  *  *  *  *  *  *  *  *  * 1
   2  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 2
   3  *  *  *  *  *  *  *  *  *  O  *  *  O  *  * 3
   4  *  *  *  X  *  *  *  *  *  *  *  *  *  *  * 4
   5  *  *  *  *  X  *  *  *  *  *  *  *  *  *  * 5
   6  *  *  *  *  *  X  *  *  *  *  *  *  *  *  * 6
   7  *  *  *  *  *  *  X  *  *  *  *  *  *  *  * 7
   8  *  *  *  *  *  *  *  X  *  *  *  *  *  *  * 8
   9  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 9
   10 *  *  *  *  *  *  *  O  *  *  *  *  *  *  * 10
   11 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 11
   12 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 12
   13 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 13
   14 *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 14
   15 *  *  *  *  *  *  *  *  *  *  *  *  O  *  * 15
      1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
   You Win!!!
   ```


