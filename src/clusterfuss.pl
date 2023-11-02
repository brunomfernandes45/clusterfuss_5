:- use_module(library(lists)).
:- use_module(library(between)).
:- consult(config).
:- consult(game).
:- consult(moves).
:- consult(display).
:- consult(utils).

% play/0
% Starts the game
play :- 
        config(GameState),
        game_mode(Mode),
        game(GameState, Mode).

test :- 
        asserta(board_size(4)),
        Board = [[empty, red, red, red],
                 [red, red, red, blue],
                 [red, red, empty, empty],
                 [red, blue, blue, red]],
        piece_count(Board, player1, Count),
        write(Count), nl.
