% not(+Goal)
% Fails if Goal succeeds.
not(Goal) :- 
        call(Goal), 
        !, fail.
not(_).

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

% is_orthogonal(+Row1, +Col1, +Row2, +Col2)
% Checks if the two positions are orthogonal.
is_orthogonal(Row1, Col1, Row2, Col2):-
        Row1 =:= Row2,
        N is Col1 - Col2,
        abs(N, 1).
is_orthogonal(Row1, Col1, Row2, Col2):-
        Col1 =:= Col2,
        N is Row1 - Row2,
        abs(N, 1).

/*
% in_group_dfs(+Board, +Row1, +Col1, +Row2, +Col2, +Visited)
% Checks if the two positions are in the same group.
in_group_dfs(Board, Row1, Col1, Row1, Col1, _).
in_group_dfs(Board, Row1, Col1, Row2, Col2, Visited):-
        (
            get_piece(Board, Row2-Col2, red);
            get_piece(Board, Row2-Col2, blue)
        ), 
        \+ member(Row2-Col2, Visited),
        is_orthogonal(Row1, Col1, Row2, Col2).
in_group_dfs(Board, Row1, Col1, Row2, Col2, Visited):-
        (
            get_piece(Board, Row3-Col3, red);
            get_piece(Board, Row3-Col3, blue)
        ),
        is_orthogonal(Row1, Col1, Row3, Col3),
        \+ member(Row3-Col3, Visited),
        Visited1 = [Row1-Col1 | Visited],
        in_group_dfs(Board, Row3, Col3, Row2, Col2, Visited1). 
*/

in_group_dfs(Board, Row, Col, Visited, Group ) :- member(Row-Col, Visited).
in_group_dfs(Board , Row, Col,  Visited , Group) :- board_size(_Size), (Row < 0; Col < 0; Row >= _Size; Col >= _Size).
in_group_dfs(Board, Row, Col, Visited , Group ) :- get_piece(Board, Row-Col, empty). 
in_group_dfs(Board, Row, Col, Visited, Group) :-
        \+ member(Row-Col, Visited),
        Visited1 = [Row-Col | Visited],
        write(Visited1), nl,
        RowT is Row - 1, in_group_dfs(Board, RowT, Col, Visited1, Group),
        RowB is Row + 1, in_group_dfs(Board, RowB, Col, Visited1, Group),
        ColL is Col - 1, in_group_dfs(Board, Row, ColL, Visited1, Group),
        ColR is Col + 1, in_group_dfs(Board, Row, ColR, Visited1, Group),
        write(Row-Col), nl,
        Visited = Visited1,
        Group = [Row-Col | Group].
    

    
    

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
    board_size(_Size),
    empty_board(_Size, TempBoard),
    write('Group: '), nl,
    % setof(RowIndex1-ColIndex1,(Visited = [], in_group_dfs(Board, RowIndex, ColIndex, RowIndex1, ColIndex1, Visited)), Group),
    in_group_dfs(Board, RowIndex, ColIndex, [], Group),
    write(Group), nl,
    remove_separate_pieces_aux(Board, Group, TempBoard, NewBoard).

% piece_count(+Board, +Piece, -Count)
% Unifies Count with the number of pieces of type Piece in Board.
piece_count(Board, Piece, Count) :-
    ( setof(RowIndex-ColIndex, get_piece(Board, RowIndex-ColIndex, Piece), List) -> 
        true 
    ; List = [] ),
    length(List, Count).
    
