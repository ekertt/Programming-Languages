-module(tests_1a).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(grid, [new/2, get_wall/3, has_wall/2, add_wall/2]).

tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).


new_test_() -> 
    [?_assert(grid:new(1, 1) =:= {1, 1, []}),
     ?_assert(grid:new(1, 2) =:= {1, 2, []}),
     ?_assert(grid:new(12, 10) =:= {12, 10, []}),
     ?_assert(grid:new(0, 0) =:= {0, 0, []})
    ].


get_wall_test_() -> 
    [?_assert(grid:get_wall(1, 3, north) =:= {{1,2},{1,3}}),
     ?_assert(grid:get_wall(4, 3, east) =:= {{4,3},{5,3}}),
     ?_assert(grid:get_wall(0, 0, north) =:= {{0,-1},{0,0}}),
     ?_assert(grid:get_wall(0, 0, south) =:= {{0,0},{0,1}}),
     ?_assert(grid:get_wall(5, 5, west) =:= {{4,5},{5,5}})
    ].

has_wall_test_() ->
    [?_assert(grid:has_wall({{1,2},{1,3}}, {6, 6, [{{1,2},{1,3}}]})),
     ?_assert(grid:has_wall({{1,2},{1,3}}, {6, 6, [{{4,3},{5,4}}, {{1,2},{1,3}}]})),
     ?_assertNot(grid:has_wall({{1,2},{1,3}}, {6, 6, []}))
    ].

add_wall_test_() ->
    [?_assert(grid:add_wall({{1,2},{1,3}}, {6, 6, []}) =:= {6, 6, [{{1,2},{1,3}}]}),
     ?_assert(grid:add_wall({{1,2},{1,3}}, {12, 12, []}) =:= {12, 12, [{{1,2},{1,3}}]}),
     ?_assert(grid:add_wall({{1,2},{1,3}}, 
                            {12, 12, [{{1,2},{1,3}}]}) =:= {12, 12, [{{1,2},{1,3}}]})
    ].


integration_test_() ->
    [?_assert(grid:has_wall(grid:get_wall(2, 3, east), 
                            grid:add_wall(grid:get_wall(2, 3, east), grid:new(6, 6))))
    ].


