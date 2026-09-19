:- begin_tests(queen_bug).
:- use_module('../src/queen_bug').

test(analysis_contains_choice_identity) :-
    queen_bug:analyse_queen_bug(sample_program, analysis(_, findings(Findings), _)),
    member(preserve_choice_identity, Findings).

:- end_tests(queen_bug).
