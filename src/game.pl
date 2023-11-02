% initial_state(+Size, -GameState)
% Returns a initial_state of a given size
initial_state(4, [ player1, 
    [red, blue, red, blue],
    [blue, red, blue, red],
    [red, blue, red, blue],
    [blue, red, blue, red]
]).

initial_state(6, [ player1, 
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red]
]).

initial_state(8, [ player1, 
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red],
    [red, blue, red, blue, red, blue, red, blue],
    [blue, red, blue, red, blue, red, blue, red]
]).

empty_board(4, [ 
    [empty, empty, empty, empty],
    [empty, empty, empty, empty],
    [empty, empty, empty, empty],
    [empty, empty, empty, empty]
]).
empty_board(6, [ 
    [empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty]
]).
empty_board(8, [ 
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty]
]).


% switch_turn(+CurrentPlayer, -NextPlayer)
% Switches the turn from one player to the other
switch_turn(player1, player2).
switch_turn(player2, player1).

% game_over(+GameState, -Winner)
% Checks if the game is over and returns the winner
game_over([Player | Board], Winner) :-
    valid_piece(Player, Piece),
    piece_count(Board, Piece, Count),
    Count == 0,
    switch_turn(Player, Winner).

game(GameState, _) :-
    game_over(GameState, Winner),
    !,
    board_size(_Size),
    GameState = [ _ | Board],
    display_board(_Size, Board),
    display_winner(Winner).

game(GameState, 1) :-
    display_game(GameState),
    repeat,
        get_move(Move),
        move(GameState, Move, NewGameState), !,
    game(NewGameState, 1).

game(GameState, 2) :-
    display_game(GameState),
    GameState = [Player | Board],
    (
        (   
            Player = player1,
            repeat,  
                get_move(Move),
                move(GameState, Move, NewGameState), !
        );
        (   
            Player = player2,
            level(Player,Level),
            write('Write anything to let the Bot play'),nl,
            read( _ ),
            move(GameState, Move, NewGameState)
        )
    ),
    game(NewGameState, 2).

game(GameState, 3) :-
    display_game(GameState),
    GameState = [Player | Board ],
    (
        (   
            Player = player2,
            repeat,  
                get_move(Move),
                move(GameState, Move, NewGameState), !
        );
        (   
            Player = player1,
            level(Player,Level),
            write('Write anything to let the Bot play'),nl,
            read( _ ),
            move(GameState, Move, NewGameState)               
        )
    ),
    game(NewGameState, 3).

game(GameState, 4):-
    display_game(GameState),
    GameState = [Player | Board ],
    level(Player,Level),
    write('Write anything to let the Bot play'),nl,
    read( _ ),
    move(GameState, Move, NewGameState),
    game(NewGameState, 4).