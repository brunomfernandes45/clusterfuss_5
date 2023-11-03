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
        game(GameState, Mode),
        clear_data.

test :- 
        board_size(Size),
        write(Size).

test4 :- 
        asserta(board_size(4)),
        asserta(game_mode(1)),
        initial_state(4, GameState),
        Move = 'a1'-'b1',
        move(GameState, Move, NewGameState).


