:- begin_tests(thoughts).
:- use_module('../rank_lucian').

test(extract_clumped_thoughts) :-
    Program = "clump([H|T0],[H-C|T]):-ccount(T0,H,T1,1,C),clump(T1,T).",
    rank_lucian:extract_thoughts(Program, Thoughts),
    member(thought(run_decomposition, _, _, _, _, _), Thoughts).

test(applicable_thoughts_nonempty) :-
    rank_lucian:applicable_thoughts("adjacent run grouping with accumulator", Thoughts),
    Thoughts \= [].

:- end_tests(thoughts).
