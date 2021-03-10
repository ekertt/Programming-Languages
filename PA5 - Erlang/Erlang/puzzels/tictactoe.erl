-module(tictactoe).
-behaviour(gen_server).

-export([start_link/0, start_link/1, print_board/0, print_board/1, show_board/1,
     restart/0, restart/1, move/2, is_finished/0, get_board/0]).
-export([init/1, handle_call/3, handle_cast/2,
         terminate/2, code_change/3]).

% Starts with an empty board.
start_link() ->
    start_link([]).

% Starts with a preconfigured board.
start_link(Board) ->
    gen_server:start_link({local, ttt}, tictactoe, Board, []).

init(Board) -> {ok, Board}.

%%% TODO: implement these functions.
restart() ->
    ok.

restart(Board) ->
    ok.

move(X,Y) ->
    ok.

is_finished() ->
    ok.

get_board() ->
    ok.

show_board(Board) ->
    ok.

%%% TODO: Add the required calls.
handle_call(terminate, _From, State) ->
    {stop, normal, ok, State}.

handle_cast(restart, _State) ->
    {noreply, []}.

terminate(normal, _) ->
    ok.

code_change(_Old, State, _Extra) ->
    {ok, State}.

% This is just a helper for in the REPL.
print_board() ->
    print_board(get_board()).

% This allows you to test printing without the server working.
print_board(Board) ->
    io:fwrite(show_board(Board)).

