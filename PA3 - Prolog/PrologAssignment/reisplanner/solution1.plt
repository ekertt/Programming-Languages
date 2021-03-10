:- begin_tests(solution1).

test(path31, set(Path ==
        [ [edge(3, 1, 9)], [edge(3, 2, 2), edge(2, 1, 3)]
        , [edge(3, 2, 2), edge(2, 5, 5), edge(5, 1, 3)]
        ]))
    :-
    solution1:path(3, 1, Path).

test(path25, set(Path == [[edge(2, 5, 5)]])) :-
    solution1:path(2, 5, Path).

test(path51, set(Path == [[edge(5, 1, 3)]])) :-
    solution1:path(5, 1, Path).

% If this test fails, you're likely stating that
% the path predicate evaluates to _Path = false.
% Instead it should evaluate to false.
test(path41, fail) :-
    solution1:path(4, 1, _Path).

:- end_tests(solution1).
