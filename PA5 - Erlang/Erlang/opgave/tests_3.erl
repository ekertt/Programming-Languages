-module(tests_3).

%% NOTE: do not use the tests as a guidance on good code.
%% Some things are done in a 'wrong' way on purpose.
%% So, do not copy paste this(use the right abstractions).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0, process_mock/0]).

-import(lobby_server, []).
-import(game_server, [start_link/1]).


tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).


start_test() ->
    {ok, SPID} = game_server:start_link({1, 1, [self()]}),
    % Client should be informed to make a move.
    receive
        {move, Server_PID, _} -> ok
    end,
    ?debugHere,
    ?assertEqual(SPID, Server_PID),
    Walls = [{{0,-1},{0,0}},{{0,0},{0,1}},{{0,0},{1,0}}],
    gen_server:call(Server_PID, {setWalls, Walls}),
    % Last move, completes a wall so we get a point.
    {ok, 1} = gen_server:call(Server_PID, {move, {{-1,0},{0,0}}}),
    ?debugHere,
    % No moves possible, so the client should receive finished.
    receive
        finished -> ok
    end.


score_test() ->
    {ok, Server_PID} = game_server:start_link({2, 2, [self()]}),
    {ok, Score} = gen_server:call(Server_PID, {move, {{-1,0},{0,0}}}),
    ?assertEqual(Score, 0),
    Walls = [{{0,-1},{0,0}},{{0,0},{0,1}},{{0,0},{1,0}}],
    gen_server:call(Server_PID, {setWalls, Walls}),
    {ok, Score1} = gen_server:call(Server_PID, {move, {{-1,0},{0,0}}}),
    ?assertEqual(Score1, 1),
    Walls2 = [{{-1,0},{0,0}}, {{-1,1},{0,1}}, {{0,-1},{0,0}}, {{0,0},{1,0}}, {{0,1},{0,2}},
              {{0,1},{1,1}}, {{1,-1},{1,0}}, {{1,0},{1,1}}, {{1,0},{2,0}}, {{1,1},{1,2}}],
    gen_server:call(Server_PID, {setWalls, Walls2}),
    {ok, Score2} = gen_server:call(Server_PID, {move, {{0,0},{0,1}}}),
    ?assertEqual(Score2, 2).


process_mock () ->
    receive
        _ -> process_mock()
    end.

order_test() ->
    Pid = spawn(?MODULE, process_mock, []),
    {ok, Server_PID} = game_server:start_link({2, 2, [self(), Pid]}),
    {ok, _} = gen_server:call(Server_PID, {move, {{-1,0},{0,0}}}),
    % We moved, but did not score, so other player can make a move(need to be the head).
    {ok, {_, [H|_]}} = gen_server:call(Server_PID, state),
    ?assertEqual(Pid, H).




