:- module(analogy,
    [ case/3,
      analogous_cases/3
    ]).

:- dynamic case/3.

case([adjacent_runs, recursive_list], run_accumulator_strategy, improved_linear_runtime).
case([repeated_lookup, nested_term], subterm_address_strategy, reduced_repeated_traversal).
case([choicepoints], preserve_choice_identity_strategy, avoids_semantic_regression).

analogous_cases(Features, Max, Cases) :-
    findall(similarity(Score, case(Fs, Strategy, Result)),
            ( case(Fs, Strategy, Result), overlap_score(Features, Fs, Score), Score > 0 ),
            Scored),
    sort(1, @>=, Scored, Sorted),
    take(Max, Sorted, Cases).

overlap_score(A, B, Score) :-
    intersection(A, B, I),
    length(I, Score).

take(Max, List, Taken) :-
    length(Taken, Max), append(Taken, _, List), !.
take(_, List, List).
