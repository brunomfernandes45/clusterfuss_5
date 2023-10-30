:- consult(utils).

% choose_board(-Size)
% Size is the size of the board chosen by the user
choose_board(Size):-
    write('Board size: 4x4, 6x6 or 8x8? (Write only one number, for example, 4 corresponds to the 4x4 option)'), nl,
    repeat,
    read_number(Size),
    member(Size, [4, 6, 8]), !.

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
    ).

% config(-GameState)
% Configures the game according to the user's option
config(GameState) :- menu,
                    

:- menu.
