:- use_module(library(between)).

% read_number(-Number)
% Unifies Number with the number read from the input stream.
read_number(Number):-
    read_number_aux(Number, 0).

% read_number_aux(-Number, +Acc)
% Auxiliary predicate for read_number/1.
read_number_aux(Number, Acc):- 
    get_code(Code),
    between(48, 57, C), !,
    Acc1 is 10 * Acc + Code - 48,
    read_number_aux(Number, Acc1).
read_number_aux(Number, Number).

% symbol(+Color, -Symbol)
% Unifies Symbol with the symbol corresponding to Color.
symbol(red, 'R').
symbol(blue, 'B').
symbol(empty, ' ').