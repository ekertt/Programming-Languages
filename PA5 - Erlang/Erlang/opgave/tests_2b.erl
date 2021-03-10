-module(tests_2b).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(client, [choose_random_wall/1, new/0]).
-import(mock_game_server, [start_link/1]).

tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).

setup() ->
    Client = client:new(),
    {ok, MockServer} = mock_game_server:start_link({1, 1, []}),
    {MockServer, Client}.


shutdown({_Server, Client}) ->
    exit(Client, normal),
    ok.

% Safety check.
test_spawn({_, Client}) ->
    ?assert(is_process_alive(Client)).


wait_for_move(Server, Last) ->
    {ok, Wall} = gen_server:call(Server, last_wall),
    if 
        Wall == Last -> wait_for_move(Server, Last);
        true -> Wall
    end.
   
% Tests if you respond well to a move request.
test_move({Server, Client}) ->
    % Grid of 1 Cell.
    Walls = [{{-1,0},{0,0}},{{0,-1},{0,0}},{{0,0},{0,1}},{{0,0},{1,0}}],
    [H|T] = Walls,
    Client ! {move, Server, {1, 1, T}},
    Wall = wait_for_move(Server, nil),
    ?assertEqual(Wall, H),
    Client ! {move, Server, {1, 1, [H]}},
    NewWall = wait_for_move(Server, Wall),
    ?assertNotEqual(H, NewWall).


instantiator(Fixture) ->
    % You have ten seconds(more than enough).
    % If you get a timeout, your client is not
    % making moves.
    {timeout, 10, {inorder, 
        [?_test(test_spawn(Fixture)),
         ?_test(test_move(Fixture))
        ]
    }}.


move_test_() ->
    {setup, 
        fun setup/0,  
        fun shutdown/1,
        fun instantiator/1
    }.
