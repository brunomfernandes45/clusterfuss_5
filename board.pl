horizontal_line(0) :- nl.
horizontal_line(N) :- N > 0, put_code(9472), N1 is N - 1, horizontal_line(N1).

:- horizontal_line(20).
