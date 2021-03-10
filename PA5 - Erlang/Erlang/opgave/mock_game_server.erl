-module(mock_game_server).

-behaviour(gen_server).

-export([start_link/1, handle_call/3, handle_cast/2]).
-export([init/1]).

% Used for testing.

start_link({W, H, _}) ->
    gen_server:start_link(mock_game_server, {W, H}, []).

init({Width, Height}) ->
    {ok, {Width, Height, []}}.

handle_call({move, Wall}, {_, _}, {W, H, Walls}) ->
    {reply, {ok, 0}, {W, H, [Wall|Walls]}};
    
handle_call(last_wall, _From, {W, H, [Wall|T]}) ->
    {reply, {ok, Wall}, {W, H, [Wall|T]}};
handle_call(last_wall, _From, {W, H, []}) ->
    {reply, {ok, nil}, {W, H, []}}.

handle_cast(_, State) ->
    {reply, not_implemented, State}.
