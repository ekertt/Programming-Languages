-module(tests_4).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(lobby_server, []).
-import(mock_game_server, [start_link/1]).
-import(mock_client, [new/0]).


tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).


setup() ->
    {ok, Server} = lobby_server:start(),
    Server.

shutdown(Server) ->
    exit(Server, normal),
    ok.

% Checks if Pid is not in the Games
% of a lobby server.
check_games(Pid) ->
    Games = lobby_server:games(),
    case lists:member(Pid, Games) of
        true -> check_games(Pid);
        false -> true
    end.

% Tests how the lobby server reacts when a 
% game server stops running.
test_exit_handle(_Server) ->
    {ok, Pid} = lobby_server:new_game(1, 1, [mock_client:new()]),
    gen_server:stop(Pid),
    ?assert(check_games(Pid)),
    {ok, NewPid} = lobby_server:new_game(1, 1, [mock_client:new()]),
    gen_server:stop(NewPid, shutdown, infinity),
    ?assert(check_games(NewPid)).

instantiator(Fixture) ->
    % You have ten seconds(more than enough).
    % If you get a timeout you are not removing
    % the game for the list of games.
    {timeout, 10, {inorder, 
        [?_test(test_exit_handle(Fixture))
        ]
    }}.


exit_handle_test_() ->
    {setup, 
        fun setup/0,  
        fun shutdown/1,
        fun instantiator/1
    }.

