:- begin_tests(formula).
:- use_module('../rank_lucian').

test(find_formula) :-
    rank_lucian:find_performance_formula(clumped, Formula),
    Formula = formula(_, _).

test(recursive_predicate_gets_linear_candidate) :-
    rank_lucian:find_performance_formula(plunit_formula:count_down(_),
                                         formula(best_guess(linear, _),
                                                 structural_variables([n]))).

count_down(0).
count_down(N) :-
    N > 0,
    Next is N - 1,
    count_down(Next).

:- end_tests(formula).
