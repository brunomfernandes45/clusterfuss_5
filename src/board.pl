:- consult(game).

draw_column_positions(0) :- nl.
draw_column_positions(Size) :- nl, write('    '), draw_column_positions_aux(Size, 0).
draw_column_positions_aux(Size, Size) :- nl.
draw_column_positions_aux(Size, Acc) :- Code is 0x41 + Acc, put_code(Code), write('   '), Acc1 is Acc + 1, draw_column_positions_aux(Size, Acc1).

% draw_top_line(+N)
% Draws the top line of the board
draw_top_line(N) :- write('  '), put_code(0x250C), draw_top_line_aux(N).
draw_top_line_aux(0) :- put_code(0x2510), nl.
draw_top_line_aux(N) :- N mod 4 =:= 0, put_code(0x252C), N1 is N-1, draw_top_line_aux(N1).
draw_top_line_aux(N) :- put_code(0x2500), N1 is N-1, draw_top_line_aux(N1).

draw_bottom_line(N) :- write('  '), put_code(0x2514), draw_bottom_line_aux(N).
draw_bottom_line_aux(0) :- put_code(0x2518), nl.
draw_bottom_line_aux(N) :- N mod 4 =:= 0, put_code(0x2534), N1 is N-1, draw_bottom_line_aux(N1).
draw_bottom_line_aux(N) :- put_code(0x2500), N1 is N-1, draw_bottom_line_aux(N1).

draw_middle_line(N) :- write('  '), put_code(0x251C), draw_middle_line_aux(N).
draw_middle_line_aux(0) :- put_code(0x2524), nl.
draw_middle_line_aux(N) :- N mod 4 =:= 0, put_code(0x253C), N1 is N - 1, draw_middle_line_aux(N1).
draw_middle_line_aux(N) :- put_code(0x2500), N1 is N - 1, draw_middle_line_aux(N1).

draw_middle_square_lines(Size, Row, P) :- write(P), write(' '), put_code(0x2502), draw_middle_square_lines_aux(Size, Row).
draw_middle_square_lines_aux(0, []) :- nl.
draw_middle_square_lines_aux(Size, [H | T]) :- write(' '), symbol(H, S), write(S), write(' '), put_code(0x2502), Size1 is Size - 1, draw_middle_square_lines_aux(Size1, T).

draw_board(Size, Board) :- N is Size * 4 - 1,
                        draw_column_positions(Size),
                        draw_top_line(N), 
                        draw_middle(Size, N, Board, Size),
                        draw_bottom_line(N).

draw_middle(Size, N, [H | T], 1) :- P is Size, draw_middle_square_lines(Size, H, P). 
draw_middle(Size, N, [H | T], Acc) :- Acc1 is Acc - 1,
                                P is Size - Acc1,
                                draw_middle_square_lines(Size, H, P),
                                draw_middle_line(N),
                                draw_middle(Size, N, T, Acc1).

:- board(8, _X), draw_board(8, _X).



