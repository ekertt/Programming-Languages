#!/usr/bin/swipl

:- initialization(main, main).

:- consult('puzzels.pl').

main(_Argv) :-
    load_test_files(make(all)),
    run_tests,
    halt.


main(_Argv) :-
    halt(1).
