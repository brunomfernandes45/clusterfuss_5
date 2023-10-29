:- consult(game).

% draw_column_positions(+Size)
% Draws the column positions of the board
draw_column_positions(0) :- nl.
draw_column_positions(Size) :- nl, write('    '), draw_column_positions_aux(Size, 0).
draw_column_positions_aux(Size, Size) :- nl.
draw_column_positions_aux(Size, Acc) :- Code is 0x41 + Acc, put_code(Code), write('   '), Acc1 is Acc + 1, draw_column_positions_aux(Size, Acc1).

% draw_header(+N)
% Draws the header of the board
draw_header(N) :- write('  '), put_code(0x250C), draw_header_aux(N).
draw_header_aux(0) :- put_code(0x2510), nl.
draw_header_aux(N) :- N mod 4 =:= 0, put_code(0x252C), N1 is N-1, draw_header_aux(N1).
draw_header_aux(N) :- put_code(0x2500), N1 is N-1, draw_header_aux(N1).

% draw_footer(+N)
% Draws the footer of the board
draw_footer(N) :- write('  '), put_code(0x2514), draw_footer_aux(N).
draw_footer_aux(0) :- put_code(0x2518), nl.
draw_footer_aux(N) :- N mod 4 =:= 0, put_code(0x2534), N1 is N-1, draw_footer_aux(N1).
draw_footer_aux(N) :- put_code(0x2500), N1 is N-1, draw_footer_aux(N1).

% draw_middle_lines(+N)
% Draws the middle lines of the board
draw_middle_lines(N) :- write('  '), put_code(0x251C), draw_middle_lines_aux(N).
draw_middle_lines_aux(0) :- put_code(0x2524), nl.
draw_middle_lines_aux(N) :- N mod 4 =:= 0, put_code(0x253C), N1 is N - 1, draw_middle_lines_aux(N1).
draw_middle_lines_aux(N) :- put_code(0x2500), N1 is N - 1, draw_middle_lines_aux(N1).

% draw_cells(+Size, +Row, +P)
% Draws the cells of a row, the index of the row and the row itself
draw_cells(Size, Row, P) :- write(P), write(' '), put_code(0x2502), draw_cells_aux(Size, Row).
draw_cells_aux(0, []) :- nl.
draw_cells_aux(Size, [H | T]) :- write(' '), symbol(H, S), write(S), write(' '), put_code(0x2502), Size1 is Size - 1, draw_cells_aux(Size1, T).

% draw_rows(+Size, +N, +Board, +Acc)
% Draws all the rows of the board
draw_rows(Size, _, [H | _], 1) :- P is Size, draw_cells(Size, H, P). 
draw_rows(Size, N, [H | T], Acc) :- Acc1 is Acc - 1,
                                P is Size - Acc1,
                                draw_cells(Size, H, P),
                                draw_middle_lines(N),
                                draw_rows(Size, N, T, Acc1).

% draw_board(+Size, +Board)
% Draws the board
draw_board(Size, Board) :- N is Size * 4 - 1,
                        draw_column_positions(Size),
                        draw_header(N), 
                        draw_rows(Size, N, Board, Size),
                        draw_footer(N).

:- board(8, _X), draw_board(8, _X).



