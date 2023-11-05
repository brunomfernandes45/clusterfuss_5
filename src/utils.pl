% read_number(-Number)
% Unifies Number with the number read from the input stream.
read_number(Number):-
        read_number_aux(Number, 0).

% read_number_aux(-Number, +Acc)
% Auxiliary predicate for read_number/1.
read_number_aux(Number, Acc):- 
        get_code(Code),
        between(48, 57, Code), !,
        Acc1 is 10 * Acc + Code - 48,
        read_number_aux(Number, Acc1).
read_number_aux(Number, Number).

print_invalid_move_message(Flag) :-
        Flag,
        write('Invalid move! Please select another move.'), nl.

% replace(+List, +Index, +Element, -NewList)
% Unifies NewList with the list resulting from replacing the element at Index with Element.
replace([_ | T], 0, X, [X | T]).
replace([H | T], N, X, [H | R]) :-
        N > 0,
        N1 is N - 1,
        replace(T, N1, X, R).


% symbol(+Color, -Symbol)
% Unifies Symbol with the symbol corresponding to Color.
symbol(red, 'R').
symbol(blue, 'B').
symbol(empty, ' ').

% col(+Column, -Index)
% Unifies Index with the index corresponding to Column.
col('1', 0).
col('2', 1).
col('3', 2).
col('4', 3).
col('5', 4).
col('6', 5).
col('7', 6).
col('8', 7).

% row(+Row, -Index)
% Unifies Index with the index corresponding to Row.
row('a', 0).
row('b', 1).
row('c', 2).
row('d', 3).
row('e', 4).
row('f', 5).
row('g', 6).
row('h', 7).
row('A', 0).
row('B', 1).
row('C', 2).
row('D', 3).
row('E', 4).
row('F', 5).
row('G', 6).
row('H', 7).

% is_connected(+Row1, +Col1, +Row2, +Col2)
% Checks if the two positions are connected.
is_connected(0, 0, 0, 1).
is_connected(0, 0, 1, 0).
is_connected(0, 1, 0, 0).
is_connected(0, 1, 0, 2).
is_connected(0, 1, 1, 1).
is_connected(0, 2, 0, 1).
is_connected(0, 2, 1, 2).
is_connected(0, 2, 0, 3).
is_connected(0, 3, 0, 2).
is_connected(0, 3, 1, 3).
is_connected(0, 3, 0, 4).
is_connected(0, 4, 0, 3).
is_connected(0, 4, 1, 4).
is_connected(0, 4, 0, 5).
is_connected(0, 5, 0, 4).
is_connected(0, 5, 1, 5).
is_connected(0, 5, 0, 6).
is_connected(0, 6, 0, 5).
is_connected(0, 6, 1, 6).
is_connected(0, 6, 0, 7).
is_connected(0, 7, 0, 6).
is_connected(0, 7, 1, 7).
is_connected(1, 0, 0, 0).
is_connected(1, 0, 1, 1).
is_connected(1, 0, 2, 0).
is_connected(1, 1, 1, 0).
is_connected(1, 1, 1, 2).
is_connected(1, 1, 2, 1).
is_connected(1, 1, 0, 1).
is_connected(1, 2, 0, 2).
is_connected(1, 2, 1, 1).
is_connected(1, 2, 1, 3).
is_connected(1, 2, 2, 2).
is_connected(1, 3, 1, 2).
is_connected(1, 3, 2, 3).
is_connected(1, 3, 0, 3).
is_connected(1, 3, 1, 4).
is_connected(1, 4, 1, 3).
is_connected(1, 4, 2, 4).
is_connected(1, 4, 0, 4).
is_connected(1, 4, 1, 5).
is_connected(1, 5, 1, 4).
is_connected(1, 5, 2, 5).
is_connected(1, 5, 0, 5).
is_connected(1, 5, 1, 6).
is_connected(1, 6, 1, 5).
is_connected(1, 6, 2, 6).
is_connected(1, 6, 0, 6).
is_connected(1, 6, 1, 7).
is_connected(1, 7, 1, 6).
is_connected(1, 7, 2, 7).
is_connected(1, 7, 0, 7).
is_connected(2, 0, 1, 0).
is_connected(2, 0, 2, 1).
is_connected(2, 0, 3, 0).
is_connected(2, 1, 2, 0).
is_connected(2, 1, 2, 2).
is_connected(2, 1, 3, 1).
is_connected(2, 1, 1, 1).
is_connected(2, 2, 1, 2).
is_connected(2, 2, 2, 1).
is_connected(2, 2, 2, 3).
is_connected(2, 2, 3, 2).
is_connected(2, 3, 2, 2).
is_connected(2, 3, 3, 3).
is_connected(2, 3, 1, 3).
is_connected(2, 3, 2, 4).
is_connected(2, 4, 2, 3).
is_connected(2, 4, 3, 4).
is_connected(2, 4, 1, 4).
is_connected(2, 4, 2, 5).
is_connected(2, 5, 2, 4).
is_connected(2, 5, 3, 5).
is_connected(2, 5, 1, 5).
is_connected(2, 5, 2, 6).
is_connected(2, 6, 2, 5).
is_connected(2, 6, 3, 6).
is_connected(2, 6, 1, 6).
is_connected(2, 6, 2, 7).
is_connected(2, 7, 2, 6).
is_connected(2, 7, 3, 7).
is_connected(2, 7, 1, 7).
is_connected(3, 0, 2, 0).
is_connected(3, 0, 3, 1).
is_connected(3, 0, 4, 0).
is_connected(3, 1, 2, 1).
is_connected(3, 1, 3, 0).
is_connected(3, 1, 3, 2).
is_connected(3, 1, 4, 1).
is_connected(3, 2, 3, 1).
is_connected(3, 2, 2, 2).
is_connected(3, 2, 3, 3).
is_connected(3, 2, 4, 2).
is_connected(3, 3, 2, 3).
is_connected(3, 3, 3, 2).
is_connected(3, 3, 3, 4).
is_connected(3, 3, 4, 3).
is_connected(3, 4, 3, 3).
is_connected(3, 4, 2, 4).
is_connected(3, 4, 3, 5).
is_connected(3, 4, 4, 4).
is_connected(3, 5, 3, 4).
is_connected(3, 5, 2, 5).
is_connected(3, 5, 3, 6).
is_connected(3, 5, 4, 5).
is_connected(3, 6, 3, 5).
is_connected(3, 6, 2, 6).
is_connected(3, 6, 3, 7).
is_connected(3, 6, 4, 6).
is_connected(3, 7, 3, 6).
is_connected(3, 7, 2, 7).
is_connected(3, 7, 4, 7).
is_connected(4, 0, 3, 0).
is_connected(4, 0, 4, 1).
is_connected(4, 0, 5, 0).
is_connected(4, 1, 3, 1).
is_connected(4, 1, 4, 0).
is_connected(4, 1, 4, 2).
is_connected(4, 1, 5, 1).
is_connected(4, 2, 4, 1).
is_connected(4, 2, 3, 2).
is_connected(4, 2, 4, 3).
is_connected(4, 2, 5, 2).
is_connected(4, 3, 3, 3).
is_connected(4, 3, 4, 2).
is_connected(4, 3, 4, 4).
is_connected(4, 3, 5, 3).
is_connected(4, 4, 4, 3).
is_connected(4, 4, 3, 4).
is_connected(4, 4, 4, 5).
is_connected(4, 4, 5, 4).
is_connected(4, 5, 4, 4).
is_connected(4, 5, 3, 5).
is_connected(4, 5, 4, 6).
is_connected(4, 5, 5, 5).
is_connected(4, 6, 4, 5).
is_connected(4, 6, 3, 6).
is_connected(4, 6, 4, 7).
is_connected(4, 6, 5, 6).
is_connected(4, 7, 4, 6).
is_connected(4, 7, 3, 7).
is_connected(4, 7, 5, 7).
is_connected(5, 0, 4, 0).
is_connected(5, 0, 5, 1).
is_connected(5, 0, 6, 0).
is_connected(5, 1, 4, 1).
is_connected(5, 1, 5, 0).
is_connected(5, 1, 5, 2).
is_connected(5, 1, 6, 1).
is_connected(5, 2, 5, 1).
is_connected(5, 2, 4, 2).
is_connected(5, 2, 5, 3).
is_connected(5, 2, 6, 2).
is_connected(5, 3, 4, 3).
is_connected(5, 3, 5, 2).
is_connected(5, 3, 5, 4).
is_connected(5, 3, 6, 3).
is_connected(5, 4, 5, 3).
is_connected(5, 4, 4, 4).
is_connected(5, 4, 5, 5).
is_connected(5, 4, 6, 4).
is_connected(5, 5, 5, 4).
is_connected(5, 5, 4, 5).
is_connected(5, 5, 5, 6).
is_connected(5, 5, 6, 5).
is_connected(5, 6, 5, 5).
is_connected(5, 6, 4, 6).
is_connected(5, 6, 5, 7).
is_connected(5, 6, 6, 6).
is_connected(5, 7, 5, 6).
is_connected(5, 7, 4, 7).
is_connected(5, 7, 6, 7).
is_connected(6, 0, 5, 0).
is_connected(6, 0, 6, 1).
is_connected(6, 0, 7, 0).
is_connected(6, 1, 5, 1).
is_connected(6, 1, 6, 0).
is_connected(6, 1, 6, 2).
is_connected(6, 1, 7, 1).
is_connected(6, 2, 6, 1).
is_connected(6, 2, 5, 2).
is_connected(6, 2, 6, 3).
is_connected(6, 2, 7, 2).
is_connected(6, 3, 5, 3).
is_connected(6, 3, 6, 2).
is_connected(6, 3, 6, 4).
is_connected(6, 3, 7, 3).
is_connected(6, 4, 6, 3).
is_connected(6, 4, 5, 4).
is_connected(6, 4, 6, 5).
is_connected(6, 4, 7, 4).
is_connected(6, 5, 6, 4).
is_connected(6, 5, 5, 5).
is_connected(6, 5, 6, 6).
is_connected(6, 5, 7, 5).
is_connected(6, 6, 6, 5).
is_connected(6, 6, 5, 6).
is_connected(6, 6, 6, 7).
is_connected(6, 6, 7, 6).
is_connected(6, 7, 6, 6).
is_connected(6, 7, 5, 7).
is_connected(6, 7, 7, 7).
is_connected(7, 0, 6, 0).
is_connected(7, 0, 7, 1).
is_connected(7, 1, 6, 1).
is_connected(7, 1, 7, 0).
is_connected(7, 1, 7, 2).
is_connected(7, 2, 7, 1).
is_connected(7, 2, 6, 2).
is_connected(7, 2, 7, 3).
is_connected(7, 3, 6, 3).
is_connected(7, 3, 7, 2).
is_connected(7, 3, 7, 4).
is_connected(7, 4, 7, 3).
is_connected(7, 4, 6, 4).
is_connected(7, 4, 7, 5).
is_connected(7, 5, 7, 4).
is_connected(7, 5, 6, 5).
is_connected(7, 5, 7, 6).
is_connected(7, 6, 7, 5).
is_connected(7, 6, 6, 6).
is_connected(7, 6, 7, 7).
is_connected(7, 7, 7, 6).
is_connected(7, 7, 6, 7).


% get_move_indexes(+Move, -IndexesList)
% Unifies IndexesList with the list of indexes corresponding to Move.
get_move_indexes(Start-Dest, [RowIndex, ColIndex, NewRowIndex, NewColIndex]):-
        sub_atom(Start, 0, 1, _, Row),
        sub_atom(Start, 1, 1, _, Col),
        row(Row, RowIndex),
        col(Col, ColIndex),
        sub_atom(Dest, 0, 1, _, NewRow),
        sub_atom(Dest, 1, 1, _, NewCol),
        row(NewRow, NewRowIndex),
        col(NewCol, NewColIndex).

% abs(+Number, -AbsNumber)
% Unifies AbsNumber with the absolute value of Number
abs(X, Y) :-
        X >= 0,
        Y is X.
abs(X, Y) :-
        Y is -X.

% valid_piece(+Player, ?Piece)
% Checks if Piece belongs to Player or unifies Piece with the piece corresponding to Player.
valid_piece(player1, 'red').
valid_piece(player2, 'blue').

% in_group_bfs(+Board, +Row, +Col, +Visited, +Group)
% Unifies Group with the list of positions that are in the same group as the piece at Row-Col.
in_group_bfs(Board, Row, Col, Visited, Group) :-
        in_group_bfs_aux(Board, [Row-Col], Visited, Group).

% in_group_bfs_aux(+Board, +Queue, +Visited, -Group)
% Auxiliary predicate for in_group_bfs/5.
in_group_bfs_aux(_, [], Group, Group).
in_group_bfs_aux(Board, Queue, Visited, Group) :-
        Queue = [Row-Col | T],
        Visited1 = [Row-Col | Visited],
        ( 
                findall(Row1-Col1, 
                        (is_connected(Row, Col, Row1, Col1), 
                        \+ member(Row1-Col1, Visited1),
                        get_piece(Board, Row1-Col1, P),
                        member(P, [red, blue]), true), 
                        Neighbors) -> 
                        true
                ; Neighbors = [] 
        ),
        ( 
                setof(X, 
                        member(X, Neighbors), 
                        Neighbors1) -> 
                        true
                ; Neighbors1 = [] ),
        append(T, Neighbors1, NewQueue),
        in_group_bfs_aux(Board, NewQueue, Visited1, Group).
    
% remove_separate_pieces_aux(+Board, +Group, +TempBoard, -NewBoard)
% Auxiliary predicate for remove_separate_pieces/3.
remove_separate_pieces_aux(_, [], NewBoard, NewBoard).
remove_separate_pieces_aux(Board, [RowIndex-ColIndex | T], TempBoard, NewBoard):-
        get_piece(Board, RowIndex-ColIndex, Piece),
        set_piece(TempBoard, RowIndex-ColIndex, Piece, NewBoard1),
        remove_separate_pieces_aux(Board, T, NewBoard1, NewBoard).

% remove_separate_pieces(+Board, +RowIndex-ColIndex, -NewBoard)
% Unifies NewBoard with the board resulting from removing all the pieces that are not in the same group as the piece at RowIndex-ColIndex.
remove_separate_pieces(Board, RowIndex-ColIndex, NewBoard):-
        board_size(Size),
        empty_board(Size, TempBoard),
        in_group_bfs(Board, RowIndex, ColIndex, [], Group),
        setof(X, member(X, Group), Group1),
        remove_separate_pieces_aux(Board, Group1, TempBoard, NewBoard).

% piece_count(+Board, +Piece, -Count)
% Unifies Count with the number of pieces of type Piece in Board.
piece_count(Board, Piece, Count) :-
        ( 
                setof(RowIndex-ColIndex, 
                        get_piece(Board, RowIndex-ColIndex, Piece), 
                        List) -> 
                        true 
                ; List = [] 
        ),
        length(List, Count).

% value(+GameState, +Player, -Value)
% Unifies Value with the value of GameState for Player.
value(GameState, _, 1000) :-
        game_over(GameState, _), !.
value([ _ | Board], Player, Value) :-
        valid_piece(Player, Piece),
        switch_turn(Player, Opponent),
        valid_piece(Opponent, OpponentPiece),
        piece_count(Board, Piece, FriendlyCount),
        piece_count(Board, OpponentPiece, EnemyCount),
        Value is FriendlyCount - EnemyCount.

clear_data :- 
        retractall(board_size(_)),
        retractall(level(_, _)),
        retractall(player_name(_, _)),
        retractall(game_mode(_)).