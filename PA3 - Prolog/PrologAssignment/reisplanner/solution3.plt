:- begin_tests(solution3).
:- op(100, xfx, at).
:- op(50, xfx, :).

test(diffTime) :-
    solution3:diffTime(10:00, 10:10, T0),
    assertion(T0 == -10),
    solution3:diffTime(11:10, 11:00, T1),
    assertion(T1 == 10),
    solution3:diffTime(12:10, 11:00, T2),
    assertion(T2 == 70),
    solution3:diffTime(17:09, 10:09, T3),
    assertion(T3 == 420).


test(cost) :-
    solution3:cost([ travel("Amsterdam Centraal"at 11:8, "Amsterdam Amstel"at 11:15, 7)
                   , travel("Amsterdam Amstel" at 11:15, "Utrecht Centraal" at 11:38, 23)], C),
    assertion(C == 30). 


test(shortestPathAE) :-
    solution3:shortestPath("Amsterdam Centraal" at 11:08, "Eindhoven" at _,
                           Path),
    assertion(Path == [ travel("Amsterdam Centraal"at 11:8, "Amsterdam Amstel"at 11:15, 7)
            , travel("Amsterdam Amstel"at 11:15, "Utrecht Centraal"at 11:38, 23)
            , travel("Utrecht Centraal"at 11:38, "'s-Hertogenbosch"at 12:8, 30)
            , travel("'s-Hertogenbosch"at 12:8, "Eindhoven"at 12:32, 24)]).

test(shortestPathWM) :-
    solution3:shortestPath("Weert" at 13:19, "Maastricht" at 14:05, Path),

    assertion(Path == [ travel("Weert"at 13:19, "Roermond"at 13:32, 13)
            , travel("Roermond"at 13:32, "Sittard"at 13:51, 19)
            , travel("Sittard"at 13:51, "Maastricht"at 14:5, 14)]).


:- end_tests(solution3).
