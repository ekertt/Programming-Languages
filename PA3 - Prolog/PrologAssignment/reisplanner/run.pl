:- initialization main.

main :-
    load_test_files(make(all)),
    run_tests,
    halt.

main :-
    halt(1).
