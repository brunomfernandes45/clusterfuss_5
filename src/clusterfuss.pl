:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).
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
        initial_state(4, GameState),
        write(GameState), nl,
        choose_move(GameState, player1, 1, Move),
        write(Move), nl.
