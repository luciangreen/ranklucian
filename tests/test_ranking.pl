:- begin_tests(ranking).
:- use_module('../rank_lucian').

test(rank_strategies_returns_ranked) :-
    rank_lucian:rank_strategies("nth1 nested term optimization", fastest, Ranked),
    Ranked = [rank(_, _, _)|_].

test(one_score_per_strategy) :-
    rank_lucian:rank_strategies(reverse_list, fastest, Ranked),
    findall(S, member(rank(_, S, _), Ranked), Ss),
    sort(Ss, Unique),
    length(Ss, N), length(Unique, N).

test(scores_depend_on_strategy) :-
    rank_lucian:rank_strategies(reverse_list, fastest, Ranked),
    findall(W, member(rank(W, _, _), Ranked), Ws),
    sort(Ws, Distinct),
    length(Distinct, D),
    assertion(D > 1).

test(performance_thought_ranks_first_for_fastest) :-
    rank_lucian:rank_strategies(reverse_list, fastest, [rank(_, strategy(Name, _), _)|_]),
    assertion(Name == use_accumulator_for_local_state).

test(retain_original_keeps_its_scores) :-
    strategy_rank:strategy_score(strategy(retain_original, []), p, score(correctness(C), _, _, _, _, _, _, _, _, _)),
    assertion(C =:= 0.95).

:- end_tests(ranking).
