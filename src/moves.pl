% get_move(-Move)
% Gets the move from the player
get_move(Move) :-
        repeat,
        write('Position of the piece you want to move: '),
        read(Start), nl,
        write('Position to where you want to move it: '),
        read(Dest), nl,
        Move = Start-Dest,
        write(Move), nl.

% get_piece(+Board, +Row-Col, -Piece)
% Gets the piece at the given position
get_piece(Board, Row-Col, Piece) :-
        nth0(Row, Board, RowList),
        nth0(Col, RowList, Piece).

set_piece(Board, Row-Col, NewPiece, NewBoard) :-
        nth0(Row, Board, RowList),
        replace(RowList, Col, NewPiece, NewRowList),
        replace(Board, Row, NewRowList, NewBoard).

% move_piece(+Board, +MoveIndexes, -NewBoard)
% Moves a piece from one position to another, if possible
move_piece(Board, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewBoard) :-
        get_piece(Board, RowIndex-ColIndex, Piece),
        set_piece(Board, NewRowIndex-NewColIndex, Piece, TempBoard1),
        set_piece(TempBoard1, RowIndex-ColIndex, empty, TempBoard2),
        write(TempBoard2), nl,
        remove_separate_pieces(TempBoard2, NewRowIndex-NewColIndex, NewBoard).

% move(+GameState, +Move, -NewGameState)
% Moves a piece from one position to another, if possible
move(GameState, Move, [NewPlayer | NewBoard]) :-
        GameState = [Player | Board],
        get_move_indexes(Move, MoveIndexes),
        valid_move(GameState, MoveIndexes),
        move_piece(Board, MoveIndexes, NewBoard),
        switch_turn(Player, NewPlayer).

valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex]) :-
        GameState = [Player | Board],
        valid_piece(Player, Piece),
        switch_turn(Player, Opponent),
        valid_piece(Opponent, OpponentPiece),
        get_piece(Board, RowIndex-ColIndex, Piece),
        (
            get_piece(Board, NewRowIndex-NewColIndex, OpponentPiece);
            get_piece(Board, NewRowIndex-NewColIndex, Piece)
        ),
        is_orthogonal(RowIndex, ColIndex, NewRowIndex, NewColIndex),
        piece_count(Board, Player, Count1),
        move_piece(Board, [RowIndex, ColIndex, NewRowIndex, NewColIndex], TempBoard),
        piece_count(TempBoard, Player, Count2),
        Count1 =:= Count2.

% valid_moves(+GameState, +Player, -ListOfMoves)
% Gets the list of valid moves for the given player
valid_moves(GameState, Player, ListOfMoves) :-
        findall([RowSI, ColSI, RowDI, ColDI], 
        get_valid_move(GameState, Player, [RowSI, ColSI, RowDI, ColDI]), ListOfMoves).

% get_valid_move(+GameState, +Player, -Move)
% Checks if a move is valid
get_valid_move([Player | Board], Player, [RowSI, ColSI, RowDI, ColDI]) :-
        valid_piece(Player, Piece),
        switch_turn(Player, Opponent),
        valid_piece(Opponent, OpponentPiece),
        get_piece(Board, RowSI-ColSI, Piece),
        (
            get_piece(Board, RowDI-ColDI, OpponentPiece);
            get_piece(Board, RowDI-ColDI, Piece)
        ),
        is_orthogonal(RowSI, ColSI, RowDI, ColDI),
        piece_count(Board, Player, Count1),
        get_piece(Board, RowSI-ColSI, NPiece),
        set_piece(Board, RowDI-ColDI, NPiece, TempBoard1),
        set_piece(TempBoard1, RowSI-ColSI, empty, TempBoard2),
        remove_separate_pieces(TempBoard2, RowDI-ColDI, TempBoard),
        piece_count(TempBoard, Player, Count2),
        Count1 =:= Count2.



    

