:- begin_tests(variable_arrangement).
:- use_module('../rank_lucian').

test(best_variable_arrangement) :-
    rank_lucian:best_variable_arrangement(clumped, [+, -], arrangement(_, _, _)).

:- end_tests(variable_arrangement).
