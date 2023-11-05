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
        piece_count(TempBoard2, Piece, Count1),
        remove_separate_pieces(TempBoard2, NewRowIndex-NewColIndex, NewBoard),
        piece_count(NewBoard, Piece, Count2),
        Count1 == Count2.

% move(+GameState, +Move, -NewGameState)
% Moves a piece from one position to another, if possible
move(GameState, Move, NewGameState) :-
        GameState = [Player | _ ],
        game_mode(GameMode),
        (
                (GameMode = 1);
                (GameMode = 2, Player = player1);
                (GameMode = 3, Player = player2)
        ),
        get_move_indexes(Move, [RowIndex, ColIndex, NewRowIndex, NewColIndex]),
        valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewGameState).

move(GameState, _ , [NewPlayer | NewBoard]) :-
        GameState = [Player | _ ],
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
% Checks if a move is valid, and if so, returns the new game state
valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewGameState) :-
        GameState = [Player | Board],
        valid_piece(Player, Piece),
        switch_turn(Player, Opponent),
        get_piece(Board, RowIndex-ColIndex, Piece),
        is_connected(RowIndex, ColIndex, NewRowIndex, NewColIndex),
        get_piece(Board, NewRowIndex-NewColIndex, P),
        member(P, [red, blue]),
        move_piece(Board, [RowIndex, ColIndex, NewRowIndex, NewColIndex], TempBoard),
        NewGameState = [Opponent | TempBoard].

% valid_moves(+GameState, +Player, -ListOfMoves)
% Gets the list of valid moves for the given player
valid_moves(GameState, _ , ListOfMoves) :-
        findall([RowIndex, ColIndex, NewRowIndex, NewColIndex, NewBoard], 
        get_valid_move(GameState, [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewBoard), ListOfMoves).

% get_valid_move(+GameState, -Move, -NewBoard)
% Returns a valid move and the resulting board given a game state
get_valid_move([Player | Board], [RowIndex, ColIndex, NewRowIndex, NewColIndex], NewBoard) :-
        is_connected(RowIndex, ColIndex, NewRowIndex, NewColIndex),
        get_piece(Board, NewRowIndex-NewColIndex, P),
        member(P, [red, blue]),
        valid_piece(Player, Piece),
        get_piece(Board, RowIndex-ColIndex, Piece),
        set_piece(Board, NewRowIndex-NewColIndex, Piece, TempBoard1),
        set_piece(TempBoard1, RowIndex-ColIndex, empty, TempBoard2),
        piece_count(TempBoard2, Piece, Count1),
        remove_separate_pieces(TempBoard2, NewRowIndex-NewColIndex, NewBoard),
        piece_count(NewBoard, Piece, Count2),
        Count1 == Count2.

% choose_move(+GameState, +Player, +Level, -Move)
% Chooses a move for the given player
choose_move(GameState, Player, 1, Move) :-
        valid_moves(GameState, Player, ListOfMoves),
        random_member(Move, ListOfMoves).

choose_move(GameState, _ , 2, Move) :-
        minimax(GameState, Move).


% minimax(+GameState, -BestMove)
% Minimax algorithm
minimax(GameState, BestMove) :-
        GameState = [Player | _ ],
        valid_moves(GameState, Player, ListOfMoves),
        best_move_max(ListOfMoves, Player, -9999 , [] , BestMoves),
        random_member(BestMove, BestMoves).


% best_move_max(+ListOfMoves, +Player, +BestValue, +CurrentBestMoves, -BestMoves)
% Gets the best moves for the given player
best_move_max([], _ , _ , BestMoves, BestMoves).
best_move_max(ListOfMoves, Player, BestValue, CurrentBestMoves, BestMoves) :-
        ListOfMoves = [Move | Tail],
        Move = [ _ , _ , _ , _ , NewBoard],
        switch_turn(Player, Opponent),
        value([Opponent | NewBoard], Player, Value),
        (
                ( 
                        Value > BestValue,
                        best_move_max(Tail, Player, Value, [Move], BestMoves)
                );
                (
                        Value == BestValue,
                        best_move_max(Tail, Player, Value, [Move | CurrentBestMoves], BestMoves)
                );
                (
                        Value < BestValue,
                        best_move_max(Tail, Player, BestValue, CurrentBestMoves, BestMoves)
                )
        ).
        