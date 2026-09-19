:- begin_tests(analogy).
:- use_module('../src/features').
:- use_module('../src/analogy').

test(analogous_cases) :-
    features:problem_features("nested term repeated lookup", Features),
    analogy:analogous_cases(Features, 2, Cases),
    Cases \= [].

:- end_tests(analogy).
