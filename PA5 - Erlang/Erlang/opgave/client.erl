%%%================================================================================================
% @author Tim van Ekert (13635565)
% @study Software Engineering HvA, Pre master SE UvA
% @version 1
% @description This represents the client which is calling the moves of the game.
% @end
%%%================================================================================================

-module(client).
-export([move/0, new/0]).

% make a move by calling the game server
move() ->
    <<S1:32, S2:32, S3:32>> = crypto:strong_rand_bytes(12),
    rand:seed(exs1024,{S1, S2, S3}),
    receive
        finished ->
            io:format("~p: I am done~n", [self()]);
        {move,ServerPid,Grid} ->
            Walls = grid:get_open_spots(Grid),
            [H|_] = Walls,
            game_server:move(ServerPid, H),
            move()
    end.

% spawn a new client
new() ->
    spawn(client, move, []).    
