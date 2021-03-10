-module(tests_1b).

-include_lib("eunit/include/eunit.hrl").

-export([tests_run/0]).

-import(grid, [show_vlines/2, show_hlines/2]).

tests_run() ->
    halt(case eunit:test(?MODULE) of
        ok -> 0;
        _ -> 1
    end).


% So, | first vertical wall({-1, 0}, {0, 0}), then two spaces,
% then sec vertical wall({{0, 0}, {1, 0}}).
% Newline is required.
show_vlines_test() ->
    ?assertEqual(
        "|  |~n",
        grid:show_vlines(0, {1, 1, [{{-1, 0}, {0, 0}}, {{0, 0}, {1, 0}}]})
     ),
     ?_assertEqual("    ~n", grid:show_vlines(0, {1, 1, []})). % No walls in this line.

% So, '+' is a corner of a grid and is always there. -- is a vertical wall.
% First test does not have any walls: a corner point, two spaces and a corner point.
% Second test has a wall: a corner point, a wall(--) and another corner point.
% Newlines are also required.
show_hlines_test() ->
    ?assertEqual("+  +~n", grid:show_hlines(0, {1, 1, [{{0, 0}, {0, 1}}]})),
    ?assertEqual("+--+~n", grid:show_hlines(1, {1, 1, [{{0, 0}, {0, 1}}]})).

% Combining hlines and vlines we would get the following grid:
% grid:print({1, 1, [{{-1, 0}, {0, 0}}, {{0, 0}, {1, 0}}, {{0, 0}, {0, 1}}]}).
% +  +
% |  |
% +--+
%
% You need to extrapolate this to NxM grids where N and M > 0


show_hlines_bigger_test()->
    ?assertEqual("+  +  +~n", grid:show_hlines(0, {2, 2, [{{0, 0}, {0, 1}}]})),
    ?assertEqual("+--+  +~n", grid:show_hlines(1, {2, 2, [{{0, 0}, {0, 1}}]})).


show_vlines_bigger_test() ->
    ?assertEqual(
        "|  |   ~n",
        grid:show_vlines(0, {2, 2, [{{-1, 0}, {0, 0}}, {{0, 0}, {1, 0}}]})
     ).

