:- use_module(library(between)).

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
replace([_|T], 0, X, [X|T]).
replace([H|T], N, X, [H|R]) :-
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

