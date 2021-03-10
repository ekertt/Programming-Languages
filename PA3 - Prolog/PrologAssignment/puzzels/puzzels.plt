:- begin_tests(puzzels).

% Shows different ways of testing in prolog.

test(myappend) :-
    puzzels:append([a, b], [c], X),
    assertion(X == [a, b, c]),
    puzzels:append([2, 3], [1, 4], X2),
    assertion(X2 == [2, 3, 1, 4]),
    puzzels:append(["Hello "], ["World"], X3), 
    assertion(X3 == ["Hello ", "World"]).
	

test(palindroom) :-
    individueel:palindroom([1, 2, 1]).


test(palindroom_false, fail) :-
    individueel:palindroom([1, 2, 2]).


test(palindroom_false_assert) :-
    assertion(not(individueel:palindroom([a, b, c]))),
    assertion(not(individueel:palindroom([100, 200]))),
    assertion(not(individueel:palindroom([1, 2, 3]))),
    assertion(not(individueel:palindroom([1, 2, 3, 4, 5, 6, 7, 8]))),
    assertion(not(individueel:palindroom(['a', 'b']))),
    assertion(not(individueel:palindroom([individueel:palindroom/1,
                                          individueel:append/3]))).


test(palindroom_assert) :-
    assertion(individueel:palindroom([])),
    assertion(individueel:palindroom([1])),
    assertion(individueel:palindroom([a, a, a])),
    assertion(individueel:palindroom([1, 2, 2, 1])),
    assertion(individueel:palindroom([5, 5, 5, 5, 5, 5, 5])),
    assertion(individueel:palindroom(['a', 'a'])),
    assertion(individueel:palindroom([individueel:palindroom/1,
                                      individueel:palindroom/1])).

test(sudoku4) :-
    puzzels:sudoku4([
	[3,_,4,_],
	[_,1,_,3],
	[2,3,_,_],
	[1,_,_,2]
    ], Solution),
    assertion(Solution == [[3, 2, 4, 1], [4, 1, 2, 3], [2, 3, 1, 4], [1, 4, 3, 2]]).
   

:- end_tests(puzzels).
