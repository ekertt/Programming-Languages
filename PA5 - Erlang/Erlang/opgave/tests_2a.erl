-module(tests_2a).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(grid, [get_cell_walls/2, get_all_walls/2, get_open_spots/1]).

tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).

get_cell_walls_test_() -> 
    Walls = lists:sort(grid:get_cell_walls(1, 1)),
    WallsUnev = lists:sort(grid:get_cell_walls(2, 3)),
    [?_assertEqual([{{0,1},{1,1}},{{1,0},{1,1}},{{1,1},{1,2}},{{1,1},{2,1}}], Walls),
     ?_assertEqual([{{1,3},{2,3}},{{2,2},{2,3}},{{2,3},{2,4}},{{2,3},{3,3}}], WallsUnev)].

get_all_walls_test_() ->
    Walls = lists:sort(grid:get_all_walls(2, 1)),
    Walls2 = lists:sort(grid:get_all_walls(1, 2)),

    [?_assertEqual(
        [{{-1,0},{0,0}},
         {{0,-1},{0,0}},
         {{0,0},{0,1}},
         {{0,0},{1,0}},
         {{1,-1},{1,0}},
         {{1,0},{1,1}},
         {{1,0},{2,0}}
        ],
        Walls),
     ?_assertEqual(
        [{{-1,0},{0,0}},
         {{-1,1},{0,1}},
         {{0,-1},{0,0}},
         {{0,0},{0,1}},
         {{0,0},{1,0}},
         {{0,1},{0,2}},
         {{0,1},{1,1}}
        ],
        Walls2)
    ].

get_open_spots_test_() ->
    Walls = [{{-1,0},{0,0}},
         {{0,-1},{0,0}},
         {{0,0},{0,1}},
         {{0,0},{1,0}},
         {{1,-1},{1,0}},
         {{1,0},{1,1}},
         {{1,0},{2,0}}
        ],
    [H|T] = Walls,

    [?_assert(lists:sort(grid:get_all_walls(1, 1)) 
              =:= lists:sort(grid:get_open_spots({1, 1, []}))),
     ?_assertEqual([], grid:get_open_spots({2, 1, Walls})),
     ?_assertEqual([H], grid:get_open_spots({2, 1, T}))
    ].

choose_random_wall_test_() ->
    Walls = [{{-1,0},{0,0}},
         {{0,-1},{0,0}},
         {{0,0},{0,1}},
         {{0,0},{1,0}},
         {{1,-1},{1,0}},
         {{1,0},{1,1}},
         {{1,0},{2,0}}
        ],
    [H|T] = Walls,

    [?_assertEqual(H, grid:choose_random_wall({2, 1, T})),
     ?_assertEqual([], grid:choose_random_wall({2, 1, [H|T]}))
    ].

