:- module(analyser,
    [ rank_lucian/2
    ]).

:- use_module(features).
:- use_module(strategy).
:- use_module(strategy_rank).
:- use_module(explanation).
:- use_module(benchmark).

rank_lucian(Problem, advice(
    recognised_features(Features),
    relevant_thoughts(Thoughts),
    ranked_strategies(Ranked),
    benchmark_summary(Benchmarks),
    explanation(Explanation)
)) :-
    features:problem_features(Problem, Features),
    strategy:applicable_thoughts(Problem, Thoughts),
    strategy_rank:rank_strategies(Problem, fastest, Ranked),
    findall(S, member(rank(_, S, _), Ranked), Strategies),
    benchmark:benchmark_strategies(Problem, Strategies, Benchmarks),
    explanation:why_ranked(Strategies, Explanation).
