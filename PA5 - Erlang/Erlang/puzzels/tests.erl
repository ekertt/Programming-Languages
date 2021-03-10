-module(tests).

-include_lib("eunit/include/eunit.hrl").

-compile({tictactoe, []}).
-export([run_tests/0]).
-import(tictactoe, []).
-import(init, [stop/1]).

run_tests() ->
    tictactoe:start_link(),
    eunit:test(tests),
    stop(0).

move_test() ->
    tictactoe:restart(),
    ?assertEqual(ok, tictactoe:move(0, 2)),
    ?assertEqual(not_open, tictactoe:move(0, 2)),
    ?assertEqual(not_valid, tictactoe:move(10, 10)),
    ?assertEqual(not_valid, tictactoe:move(-1, -1)).

get_board_test() ->
    tictactoe:restart(),
    tictactoe:move(1, 1),
    [{1, 1, 1}, _] = tictactoe:get_board().

get_board_restart_test() ->
    tictactoe:restart([{0, 1, 1}, {0, 2, 2}]),
    [{0, 1, 1}, {0, 2, 2}] = tictactoe:get_board().

restart_test() ->
    tictactoe:restart(),
    ?assertEqual([], tictactoe:get_board()).

is_finished_test() ->
    tictactoe:restart(),
    false = tictactoe:is_finished().

win_test() ->
    Board = [{0, 0, 1}, {0, 1, 1}],
    tictactoe:restart(Board),
    ?assertEqual({won, 1}, tictactoe:move(0, 2)),
    ?assertEqual(true, tictactoe:is_finished()),
    ?assertEqual([{0, 0, 1}, {0, 1, 1}, {0, 2, 1}], tictactoe:get_board()).

% Do not forget spaces and newlines here, put newlines in the ~n form.
show_board_test() ->
    ?assertEqual(" | | ~n------~n | | ~n------~n | | ~n",
        tictactoe:show_board([])),
    ?assertEqual(" | | ~n------~nO|X|O~n------~n | | ~n",
        tictactoe:show_board([{0, 1, 1}, {1, 1, 2}, {2, 1, 1}])),
    ?assertEqual("O|X| ~n------~n | | ~n------~n |X|O~n",
        tictactoe:show_board([{1, 0, 2}, {0, 0, 1}, {1, 2, 2}, {2, 2, 1}])).
