:- begin_tests(ranking).
:- use_module('../rank_lucian').

test(rank_strategies_returns_ranked) :-
    rank_lucian:rank_strategies("nth1 nested term optimization", fastest, Ranked),
    Ranked = [rank(_, _, _)|_].

:- end_tests(ranking).
