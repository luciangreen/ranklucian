:- module(debugger,
    [ debug/2
    ]).

:- use_module(queen_bug).

debug(Predicate, diagnosis(Predicate, queen_bug_analysis(Analysis))) :-
    queen_bug:analyse_queen_bug(Predicate, Analysis).
