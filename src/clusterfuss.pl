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

test4 :- 
        asserta(board_size(4)),
        asserta(game_mode(1)),
        initial_state(4, GameState),
        game(GameState, 1),
        clear_data.

test6 :- 
        asserta(board_size(6)),
        asserta(game_mode(1)),
        initial_state(6, GameState),
        game(GameState, 1),
        clear_data.

test8 :-
        asserta(board_size(8)),
        asserta(game_mode(1)),
        initial_state(8, GameState),
        game(GameState, 1),
        clear_data.

testpc4 :-
        asserta(board_size(4)),
        asserta(game_mode(4)),
        asserta(player_name(player1, 'Bot 1')),
        asserta(player_name(player2, 'Bot 2')),
        asserta(level(player1, 2)),
        asserta(level(player2, 2)),
        initial_state(4, GameState),
        game(GameState, 4),
        clear_data.

testpc6 :-
        asserta(board_size(6)),
        asserta(game_mode(4)),
        asserta(player_name(player1, 'Bot 1')),
        asserta(player_name(player2, 'Bot 2')),
        asserta(level(player1, 2)),
        asserta(level(player2, 2)),
        initial_state(6, GameState),
        game(GameState, 4),
        clear_data.

testpc8 :-
        asserta(board_size(8)),
        asserta(game_mode(4)),
        asserta(player_name(player1, 'Bot 1')),
        asserta(player_name(player2, 'Bot 2')),
        asserta(level(player1, 2)),
        asserta(level(player2, 2)),
        initial_state(8, GameState),
        game(GameState, 4),
        clear_data.
        


