:- consult(game).
:- consult(utils).

% display_column_positions(+Size)
% displays the column positions of the board
display_column_positions(0) :- nl.
display_column_positions(Size) :- nl, write('    '), display_column_positions_aux(Size, 0).
display_column_positions_aux(Size, Size) :- nl.
display_column_positions_aux(Size, Acc) :- Code is 0x41 + Acc, put_code(Code), write('   '), Acc1 is Acc + 1, display_column_positions_aux(Size, Acc1).

% display_header(+N)
% displays the header of the board
display_header(N) :- write('  '), put_code(0x250C), display_header_aux(N).
display_header_aux(0) :- put_code(0x2510), nl.
display_header_aux(N) :- N mod 4 =:= 0, put_code(0x252C), N1 is N-1, display_header_aux(N1).
display_header_aux(N) :- put_code(0x2500), N1 is N-1, display_header_aux(N1).

% display_footer(+N)
% displays the footer of the board
display_footer(N) :- write('  '), put_code(0x2514), display_footer_aux(N).
display_footer_aux(0) :- put_code(0x2518), nl.
display_footer_aux(N) :- N mod 4 =:= 0, put_code(0x2534), N1 is N-1, display_footer_aux(N1).
display_footer_aux(N) :- put_code(0x2500), N1 is N-1, display_footer_aux(N1).

% display_middle_lines(+N)
% displays the middle lines of the board
display_middle_lines(N) :- write('  '), put_code(0x251C), display_middle_lines_aux(N).
display_middle_lines_aux(0) :- put_code(0x2524), nl.
display_middle_lines_aux(N) :- N mod 4 =:= 0, put_code(0x253C), N1 is N - 1, display_middle_lines_aux(N1).
display_middle_lines_aux(N) :- put_code(0x2500), N1 is N - 1, display_middle_lines_aux(N1).

% display_cells(+Size, +Row, +P)
% displays the cells of a row, the index of the row and the row itself
display_cells(Size, Row, P) :- write(P), write(' '), put_code(0x2502), display_cells_aux(Size, Row).
display_cells_aux(0, []) :- nl.
display_cells_aux(Size, [CurrCell | Rest]) :- write(' '), symbol(CurrCell, S), write(S), write(' '), put_code(0x2502), Size1 is Size - 1, display_cells_aux(Size1, Rest).

% display_rows(+Size, +N, +Board, +Acc)
% displays all the rows of the board
display_rows(Size, _, [CurrRow | _], 1) :- P is Size, display_cells(Size, CurrRow, P). 
display_rows(Size, N, [CurrRow | Rest], Acc) :- Acc1 is Acc - 1,
                                P is Size - Acc1,
                                display_cells(Size, CurrRow, P),
                                display_middle_lines(N),
                                display_rows(Size, N, Rest, Acc1).

% display_board(+Size, +Board)
% displays the board
display_board(Size, Board) :- N is Size * 4 - 1,
                        display_column_positions(Size),
                        display_header(N), 
                        display_rows(Size, N, Board, Size),
                        display_footer(N).

% display_turn(+Player)
% displays whose turn it is
display_turn(Player) :- write('Player '), write(Player), write('\'s turn.'), nl.

% display_game(+GameState)
% displays the game
display_game([Player | Board]) :- length(Board, Size),
                        display_board(Size, Board),
                        display_turn(Player).


:- initial_state(8, _X), display_game(['Joe' | _X]).



