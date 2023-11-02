:- dynamic board_size/1.
:- dynamic game_mode/1.
:- dynamic player_name/2.

% choose_board(-Size)
% Size is the size of the board chosen by the user
choose_board(Size):-
        write('Board size: 4x4, 6x6 or 8x8? (Write only one number, for example, 4 corresponds to the 4x4 option)'), nl,
        repeat,
        read_number(Size),
        member(Size, [4, 6, 8]), !,
        asserta(board_size(Size)).

% menu/0
% Displays the menu and reads the user's option
menu :- 
        write('***Welcome to Clusterfuss!***'), nl,
        repeat, nl,
        write('Choose a gamemode:'), nl,
        write('1. Player vs Player'), nl,
        write('2. Player vs Computer'), nl,
        write('3. Computer vs Player'), nl,
        write('4. Computer vs Computer'), nl,
        write('5. Intructions'), nl,
        write('6. Exit'), nl,
        read_number(Option),
        member(Option, [1, 2, 3, 4, 5, 6]),
        (
            (Option = 1, !, choose_board(Size));
            (Option = 2, !, choose_board(Size));
            (Option = 3, !, choose_board(Size));
            (Option = 4, !, choose_board(Size));
            (Option = 5, instructions, fail);
            (Option = 6, !, halt)
        ), !,
        asserta(game_mode(Option)),
        read_names(_Player1, _Player2, Option).
    

% config(-GameState)
% Configures the game according to the user's option
config(GameState) :- 
        menu,
        board_size(_Size),
        initial_state(_Size, GameState).  
                    
% read_names(-Player1, -Player2, +GameMode)
% Asks the user for the players' names
read_names(Player1, Player2, 1):-
        write('Player 1 name: '), nl,
        read(Player1),
        write('Player 2 name: '), nl,
        read(Player2),
        asserta(player_name(player1, Player1)),
        asserta(player_name(player2, Player2)).
read_names(Player1, Player2, 2):-
        write('Player name: '), nl,
        read(Player1),
        Player2 = 'Bot',
        asserta(player_name(player1, Player1)),
        asserta(player_name(player2, Player2)).
read_names(Player1, Player2, 3):-
        write('Player name: '), nl,
        read(Player2),
        Player1 = 'Bot',
        asserta(player_name(player1, Player1)),
        asserta(player_name(player2, Player2)).
read_names(Player1, Player2, 4):-
        Player1 = 'Bot1',
        Player2 = 'Bot2',
        asserta(player_name(player1, Player1)),
        asserta(player_name(player2, Player2)).


% instructions/0
% Displays the game's instructions
instructions :-
        write('**Instructions**'), nl, nl,
        write('Clusterfuss is a two-player game played on a square board of variable size.'), nl,
        write('The objective of the game is to remove all enemy pieces from the board.'), nl,
        write('Every turn a player can move one of his pieces orthogonaly (UP, DOWN, LEFT or RIGHT).'), nl,
        write('Every move must be a piece capture, meaning that the position where the player moves the piece to must have an enemy or a friendly piece.'), nl,
        write('A move is only valid if it doesn\'t separate any friendly piece from the group.'), nl,
        write('Any piece that is separated from the group is removed from the board.'), nl,
        write('The game ends when one of the players has no pieces left on the board.'), nl, nl,
        write('Lets have some fun with Clusterfuss!'), nl, nl,
        write('(Write anything to return to the menu)'), nl,
        read(_).