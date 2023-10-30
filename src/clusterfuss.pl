:- consult(config).
:- consult(game).
:- consult(utils).

% play/0
% Starts the game
play :- config(GameState),
        