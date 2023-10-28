% board(+Size, -Board)
% Returns a board of a given size
board(4, [
    [red, blue, red, blue],
    [blue, red, blue, red],
    [red, blue, red, blue],
    [blue, red, blue, red]
]).

board(6, [
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red]
]).

board(8, [
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

% symbol(+Color, -Symbol)
% Returns the symbol for a given color
symbol(red, 'R').
symbol(blue, 'B').