
% initial_state(+Size, -GameState)
% Returns a initial_state of a given size
initial_state(4, [ player1, 
    [red, blue, red, blue],
    [blue, red, blue, red],
    [red, blue, red, blue],
    [blue, red, blue, red]
]).

initial_state(6, [ player1, 
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red]
]).

initial_state(8, [ player1, 
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red]
]).

% switch_turn(+CurrentPlayer, -NextPlayer)
% Switches the turn from one player to the other
switch_turn(player1, player2).
switch_turn(player2, player1).

% game_over(+GameState, -Winner)
% Checks if the game is over and returns the winner
%game_over(GameState, Winner):-
    

/*
game(GameState, Gamemode):-
    game_over(GameState, Winner),
    !,
    display_game(GameState),
    display_winner(Winner).
*/
game(GameState, 1):-
    display_game(GameState),
    repeat
    get_move(Move),
    %validate_move(GameState, Move), !,
    move(GameState, Move, NewGameState),
    game(NewGameState, 1).
