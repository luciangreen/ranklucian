:- begin_tests(formula).
:- use_module('../rank_lucian').

test(find_formula) :-
    rank_lucian:find_performance_formula(clumped, Formula),
    Formula = formula(_, _).

:- end_tests(formula).
