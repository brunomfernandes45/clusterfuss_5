% get_move(-Move)
% Gets the move from the player
get_move(Move) :-
        repeat,
        write('Position of the piece you want to move: '),
        read(Start), nl,
        write('Position to where you want to move it: '),
        read(Dest), nl,
        Move = Start-Dest.

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
        remove_separate_pieces(TempBoard2, NewRowIndex-NewColIndex, NewBoard).

% move(+GameState, +Move, -NewGameState)
% Moves a piece from one position to another, if possible
move(GameState, Move, NewGameState) :-
        GameState = [Player | Board],
        game_mode(GameMode),
        (
                (GameMode = 1);
                (GameMode = 2, Player = player1);
                (GameMode = 3, Player = player2)
        ),
        get_move_indexes(Move, [RowIndex, ColIndex, NewRowIndex, NewColIndex]),
        valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewGameState).

move(GameState, Move, [NewPlayer | NewBoard]) :-
        GameState = [Player | Board],
        game_mode(GameMode),
        (
                (GameMode = 2, Player = player2);
                (GameMode = 3, Player = player1);
                (GameMode = 4)
        ),
        level(Player, Level),
        choose_move(GameState, Player, Level, [RowIndex, ColIndex, NewRowIndex, NewColIndex, NewBoard]),
        switch_turn(Player, NewPlayer),
        player_name(Player, PlayerName),
        row(Row, RowIndex),
        col(Col, ColIndex),
        row(NewRow, NewRowIndex),
        col(NewCol, NewColIndex),
        format("~n~w chose the move ~w~w-~w~w.~n",[PlayerName, Row, Col, NewRow, NewCol]).



% valid_move(+GameState, +MoveIndexes, -NewGameState)
% Checks if a move is valid, and if it is, returns the new game state
valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewGameState) :-
        GameState = [Player | Board],
        valid_piece(Player, Piece),
        switch_turn(Player, Opponent),
        get_piece(Board, RowIndex-ColIndex, Piece),
        is_connected(RowIndex, ColIndex, NewRowIndex, NewColIndex),
        get_piece(Board, NewRowIndex-NewColIndex, P),
        member(P, [red, blue]),
        piece_count(Board, Piece, Count1),
        move_piece(Board, [RowIndex, ColIndex, NewRowIndex, NewColIndex], TempBoard),
        piece_count(TempBoard, Piece, Count2),
        Count1 == Count2,
        NewGameState = [Opponent | TempBoard].

% valid_moves(+GameState, +Player, -ListOfMoves)
% Gets the list of valid moves for the given player
valid_moves(GameState, Player, ListOfMoves) :-
        GameState = [ _ | Board],
        findall([RowIndex, ColIndex, NewRowIndex, NewColIndex, NewBoard], 
        get_valid_move(Board, Player, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewBoard), ListOfMoves).

% get_valid_move(+GameState, +Player, -Move)
% Checks if a move is valid
get_valid_move(Board, Player, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewBoard) :-
        is_connected(RowIndex, ColIndex, NewRowIndex, NewColIndex),
        get_piece(Board, NewRowIndex-NewColIndex, P),
        member(P, [red, blue]),
        valid_piece(Player, Piece),
        piece_count(Board, Piece, Count1),
        get_piece(Board, RowIndex-ColIndex, Piece),
        set_piece(Board, NewRowIndex-NewColIndex, Piece, TempBoard1),
        set_piece(TempBoard1, RowIndex-ColIndex, empty, TempBoard2),
        remove_separate_pieces(TempBoard2, NewRowIndex-NewColIndex, NewBoard),
        piece_count(NewBoard, Piece, Count2),
        Count1 == Count2.

% choose_move(+GameState, +Player, +Level, -Move)
% Chooses a move for the given player
choose_move(GameState, Player, 1, Move) :-
        valid_moves(GameState, Player, ListOfMoves),
        random_member(Move, ListOfMoves).


    

