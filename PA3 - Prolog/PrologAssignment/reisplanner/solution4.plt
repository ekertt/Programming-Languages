:- begin_tests(solution4).

:- op(100, xfx, at).
:- op(50, xfx, :).

test(before) :-
    assertion(solution4:before(9:00, 10:00)),
    assertion(solution4:before(10:10, 10:11)),
    assertion(not(solution4:before(11:00, 10:00))),
    assertion(not(solution4:before(12:00, 12:00))).

test(costwait) :-
    solution4:cost([wait(_, 10)], C),
    assertion(C == 10).

test(costTravelWaitTravel) :-
    solution4:cost([travel("Amsterdam Science Park"at 11:10,
                           "Amsterdam Centraal"at 11:20, 10)
                   , wait("Amsterdam Centraal", 18)
                   , travel("Amsterdam Centraal" at 11:38, "Amsterdam Amstel" at 11:45, 7)],
                   C),
    assertion(C == 35).

test(cost) :-
    solution4:cost([travel("Amsterdam Science Park"at 11:10,
                           "Amsterdam Centraal"at 11:20, 10)
                   , wait("Amsterdam Centraal", 18)],
                   C),
    assertion(C == 28).

test(shortestPath) :-
    solution4:shortestPath("Amsterdam Science Park"at 11:10,
                           "Utrecht Centraal"at _, Schedule),
    assertion(Schedule ==
        [ travel("Amsterdam Science Park"at 11:10,
                 "Amsterdam Centraal"at 11:20, 10)
        , wait("Amsterdam Centraal", 18)
        , travel("Amsterdam Centraal"at 11:38, "Amsterdam Amstel"at 11:45, 7)
        , travel("Amsterdam Amstel"at 11:45, "Utrecht Centraal"at 12:8, 23)]).

test(shortestPathDW) :-
    solution4:shortestPath("Diemen" at 11:06, "Weert" at _, Schedule),

    assertion(Schedule ==
        [ travel("Diemen"at 11:6, "Amsterdam Science Park"at 11:10, 4)
        , travel("Amsterdam Science Park"at 11:10, "Amsterdam Centraal"at 11:20, 10)
        , wait("Amsterdam Centraal", 18)
        , travel("Amsterdam Centraal"at 11:38, "Amsterdam Amstel"at 11:45, 7)
        , travel("Amsterdam Amstel"at 11:45, "Utrecht Centraal"at 12:8, 23)
        , travel("Utrecht Centraal"at 12:8, "'s-Hertogenbosch"at 12:38, 30)
        , travel("'s-Hertogenbosch"at 12:38, "Eindhoven"at 13:2, 24)
        , travel("Eindhoven"at 13:2, "Weert"at 13:19, 17)]).

:- end_tests(solution4).
