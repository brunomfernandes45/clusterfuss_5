:- dynamic board_size/1.
:- dynamic game_mode/1.
:- dynamic player_name/2.
:- dynamic level/2.

% choose_board(-Size)
% Asks the user for the board size
choose_board(Size):-
    nl, write('Board size: 4x4, 6x6 or 8x8? (Write only one number, for example, 4 corresponds to the 4x4 option)'), nl,
    repeat,
    read_number(Size),
    (   member(Size, [4, 6, 8])
    ->  asserta(board_size(Size))
    ;   nl, write('Invalid board size. Please choose 4, 6, or 8.'), nl,
        fail
    ).

% menu/0
% Displays the menu and reads the user's option
menu :- 
        nl,
        write('***Welcome to Clusterfuss!***'), nl,
        write('Choose a gamemode:'), nl,
        write('1. Player vs Player'), nl,
        write('2. Player vs Computer'), nl,
        write('3. Computer vs Player'), nl,
        write('4. Computer vs Computer'), nl,
        write('5. Instructions'), nl,
        write('6. Exit'), nl,
        repeat,
        read_number(Option),
        (
                (
                        Option = 1, 
                        !, choose_board(Size),
                        asserta(game_mode(Option)),
                        read_names(_Player1, _Player2, Option)
                );
                (
                        Option = 2, 
                        !, choose_board(Size), 
                        asserta(player_name(player2, 'Bot')),
                        get_level(player2, Level), 
                        asserta(level(player2, Level)),
                        asserta(game_mode(Option)),
                        read_names(_Player1, _Player2, Option)
                );
                (
                        Option = 3, 
                        !, choose_board(Size),
                        asserta(player_name(player1, 'Bot')),
                        get_level(player1, Level), 
                        asserta(level(player1, Level)),
                        asserta(game_mode(Option)),
                        read_names(_Player1, _Player2, Option)
                );
                (       
                        Option = 4, 
                        !, choose_board(Size),
                        asserta(player_name(player1, 'Bot1')),
                        get_level(player1, Level1),
                        asserta(level(player1, Level1)),
                        asserta(player_name(player2, 'Bot2')),
                        get_level(player2, Level2), 
                        asserta(level(player2, Level2)),
                        asserta(game_mode(Option)),
                        read_names(_Player1, _Player2, Option)
                );
                (
                        Option = 5, 
                        nl, instructions,
                        menu
                );
                (
                        Option = 6, 
                        !, halt
                );
                (
                        nl, write('Invalid option. Please choose an option between 1 and 6.'), nl,
                        fail
                )
        ), !.

% config(-GameState)
% Configures the game according to the user's option
config(GameState) :- 
        menu,
        board_size(_Size),
        initial_state(_Size, GameState).

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
        write('(Press enter to return to the menu)'), nl,
        read_line( _ ).

% get_level(+Player, -Level)
% Asks the user for the level of the bot
get_level(Player, Level) :-
    player_name(Player, PlayerName),
    nl, write('Choose a level for '), write(PlayerName), write(':'), nl,
    write('1. Random Move'), nl,
    write('2. Best Move (Greedy)'), nl,
    repeat,
    read_number(Level),
    (   member(Level, [1, 2])
    ->  true
    ;   nl, write('Invalid level. Please choose 1 or 2.'), nl,
        fail
    ).
