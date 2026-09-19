:- use_module(rank_lucian).

run_benchmarks(Problem, Results) :-
    rank_lucian:rank_strategies(Problem, fastest, Ranked),
    findall(S, member(rank(_, S, _), Ranked), Strategies),
    rank_lucian:benchmark_strategies(Problem, Strategies, Results).
