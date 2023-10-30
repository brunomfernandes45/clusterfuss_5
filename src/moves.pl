:- consult(display).
:- use_module(library(lists)).

% get_move(-Move)
% Gets the move from the player
get_move(Move) :-
    write('Position of the piece you want to move: '),
    read(Start), nl,
    write('Position to where you want to move it: '),
    read(Dest), nl,
    Move = Start-Dest,
    write(Move), nl.

% get_piece(+Board, +Row-Col, -Piece)
% Gets the piece at the given position
get_piece(Board, Row-Col, Piece) :-
    nth0(Row, Board, RowList),     % Get the Row-th row of the matrix
    nth0(Col, RowList, Piece).   % Get the Column-th element of the row

set_piece(Board, Row-Col, NewPiece, NewBoard) :-
    nth0(Row, Board, RowList),     % Get the Row-th row of the matrix
    replace(RowList, Col, NewPiece, NewRowList),
    replace(Board, Row, NewRowList, NewBoard).

% move_piece(+Board, +Move, -NewBoard)
move_piece(Board, Start-Dest, NewBoard) :-
    sub_atom(Start, 0, 1, _, Row),
    sub_atom(Start, 1, 1, _, Col),
    row(Row, RowIndex),
    col(Col, ColIndex),
    get_piece(Board, RowIndex-ColIndex, Piece),
    sub_atom(Dest, 0, 1, _, NewRow),
    sub_atom(Dest, 1, 1, _, NewCol),
    row(NewRow, NewRowIndex),
    col(NewCol, NewColIndex),
    set_piece(Board, NewRowIndex-NewColIndex, Piece, TempBoard),
    set_piece(TempBoard, RowIndex-ColIndex, empty, NewBoard),


% move(+GameState, +Move, -NewGameState)
% Moves a piece from one position to another, if possible
move([Player|Board], Move, [NewPlayer|NewBoard]) :-
    move_piece(Board, Move, NewBoard),
    switch_turn(Player,NewPlayer).



