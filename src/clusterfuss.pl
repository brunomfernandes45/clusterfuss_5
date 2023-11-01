:- consult(config).
:- consult(game).
:- consult(moves).
:- consult(display).
:- consult(utils).

% play/0
% Starts the game
play :- config(GameState),
        game_mode(Mode),
        game(GameState, Mode).

test :- config(GameState),
        game_mode(Mode),
        game(GameState, Mode).
