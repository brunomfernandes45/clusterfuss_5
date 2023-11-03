# Clusterfuss_5

## Identication

#### Group
- Clusterfuss_5

#### Members
- Bruno Miguel Lopes da Rocha Fernandes ( up202108871 )
- Vasco Moutinho de Oliveira ( up202108881 )

#### Contribution
- Bruno Miguel Lopes da Rocha Fernandes ( up202108871 ) - 50%
- Vasco Moutinho de Oliveira ( up202108881 ) - 50%

#### Game

The game we chose to implement was Clusterfuss, by Mark Steere.

## Installation and Execution

To install the game, you must first extract all files from the zip file *PFL_TP1_T05_Clusterfuss5.ZIP*. 

Then, you have to open Sicstus Prolog or other Prolog interpreter. For Sicstus Prolog, if you are in Windows, you must open the Sicstus Prolog application, and then click on *File* > *Working Directory* and choose the *src* file inside the extracted folder. If you are in Linux, you must open the terminal, go to the *src* directory inside the extracted folder and run `sicstus -l clusterfuss.pl`. 

After that, you must consult the file *clusterfuss.pl* that is inside the *src* directory running `consult(clusterfuss).`, and then run the command `play.`. The game will then start.

## Game Description

Clusterfuss was designed in July 2023 by Mark Steere.

Clusterfuss is a two-player game played on a square board of any size. In our implementation of the game, the player can choose to play in boards of 4x4, 6x6, or 8x8. The game starts with the board full of Red and Blue pieces. The two players take turns moving their own pieces, one per turn, starting with Red.

#### Objective

The objective of the game is to remove all enemy checkers from the board. A player wins when the opponent has no pieces left on the board.

#### Rules

The rules of the game are the following:

- Players take turns moving their own pieces, one per turn, starting with Red.
- Every move must be a piece capture. This means that a piece must be moved to a square occupied by an enemy or friendly piece, and the piece that was there is removed from the board.
- Pieces can only move orthogonally (up, down, left, right), and one square only.
- After a piece is moved, if it has split the board in multiple groups, all groups that are not connected to the square where the piece was moved are removed from the board.
- A move is only valid if it does not result in a removal of a group that has friendly pieces.

#### Group

All groups are comprised of checkers interconnected horizontally or
vertically, or both. Diagonal adjacencies are irrelevant in Clusterfuss. Groups may contain checkers of either or both colors. At the conclusion of your turn, there should only be one group on the board.

#### Official Game Rules

The oficial game rules are in the file *Clusterfuss.pdf*.


## Game Logic

#### Internal Game State Representation

In our implementation, the internal game state is represented by The current player and the board. The board is represented with a list of lists, each list representing a row. Each element of the list is a piece, represented by red, blue, or empty. The current player is represented by player1 or player2. The GameMode, board size, and each player's difficulty are stored in separate predicates (`game_mode(Mode)`, `board_size(Size)`, `level(Player, Level)`). The game mode can be either player vs player, player vs computer, or computer vs computer, represented by 1, 2, 3, 4 respectively. The board size can be 4x4, 6x6, or 8x8, represented by 4, 6, 8 respectively. The player's difficulty can be Random Move or Best Move (Greedy) represented by 1 and 2 respectively.
All this configuration is done by the predicate `config(-GameState)`.

#### Game State Visualization

The game state is created by the predicate `initial_state(+Size, -GameState)`.

The predicate `game(+GameState, +Mode)` is the game cycle.

The game state is visualized by printing the board and the current player. This is done by the predicate `display_game(+GameState)`. This predicate calls the predicates `display_board(+Size, +Board)` and `display_turn(+Player)`.
The look of this visualization is the following:

![Image](prints/display_game.png)

Then depending on the game mode, the game either asks the Human Player for a move, validates it and executes it (`get_move(-Move)`, `move(+GameState, +Move, -NewGameState)`), or makes the Computer Player choose a move `choose_move(+GameState, +Player, +Level, -Move)`. 

#### Move Validation and Execution

The move validation and execution is realized by the predicate `move(+GameState, +Move, -NewGameState)`.
This predicate works in different ways for computer players and human players. 

For computer players, the predicate `choose_move(+GameState, +Player, +Level, -Move)`, and the move is chosen from the list of valid moves (`valid_moves(+GameState, +Player, -ListOfMoves)`).

For human players, the predicate `valid_move(+GameState, +MoveIndexes, -NewGameState)` is called to validate the move. It returns the NewGameState because to verify if the move is valid, it generates the new board, so for eficiency purposes, it returns the new state. 

#### List of Valid Moves

The list of valid moves is generated by the predicate `valid_moves(+GameState, +Player, -ListOfMoves)` which returns a list of moves. Each element in the list has the 4 move indexes and the board that that move would generate (`[RowIndex, ColumnIndex, NewRowIndex, NewColumnIndex, NewBoard]`). This predicate is used by the computer player to choose a move.

#### End of Game

The end of the game is verified by the predicate `game_over(+GameState, -Winner)` that basically checks if any of the player have no pieces left on the board. If that is the case, the Winner is the other player.

###



