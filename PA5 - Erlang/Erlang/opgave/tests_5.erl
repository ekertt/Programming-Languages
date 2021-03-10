-module(tests_5).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(grid, [get_open_cell_walls/3, get_completable_walls/1]).


tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).


get_open_cell_walls_test_() -> 
    Walls = [{{0,0},{1,0}},{{0,0},{0,1}},{{0,-1},{0,0}},{{-1,0},{0,0}}],
    [H|T] = Walls,
    [?_assertEqual(Walls,
                    grid:get_open_cell_walls(0, 0, {1, 1, []})),
     ?_assertEqual([H],
                   grid:get_open_cell_walls(0, 0, {10, 10, T})),
     ?_assertEqual([], grid:get_open_cell_walls(0, 0, {1, 1, Walls}))
    ].


get_completable_walls_test_() -> 
    Walls = [{{0,0},{1,0}},{{0,0},{0,1}},{{0,-1},{0,0}},{{-1,0},{0,0}}],
    [H|T] = Walls,
    [?_assertEqual([],
                    grid:get_completable_walls({1, 1, []})),
     ?_assertEqual([H],
                   grid:get_completable_walls({1, 1, T})),
     ?_assertEqual([], grid:get_completable_walls({2, 2, Walls}))
    ].

