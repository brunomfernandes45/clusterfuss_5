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
        write('Welcome to Clusterfuss!'), nl,
        write('Choose a gamemode:'), nl,
        write('1. Player vs Player'), nl,
        write('2. Player vs Computer'), nl,
        write('3. Computer vs Player'), nl,
        write('4. Computer vs Computer'), nl,
        write('5. Exit'), nl,
        repeat,
        read_number(Option),
        member(Option, [1, 2, 3, 4, 5]), !,
        (
            (Option = 1, !, choose_board(Size));
            (Option = 2, !, choose_board(Size));
            (Option = 3, !, choose_board(Size));
            (Option = 4, !, choose_board(Size));
            (Option = 5, !, halt)
        ),
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

