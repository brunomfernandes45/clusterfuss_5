
% initial_state(+Size, -GameState)
% Returns a initial_state of a given size
initial_state(4, [ player1 |
    [red, blue, red, blue],
    [blue, red, blue, red],
    [red, blue, red, blue],
    [blue, red, blue, red]
]).

initial_state(6, [ player1 |
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red]
]).

initial_state(8, [ player1 |
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

