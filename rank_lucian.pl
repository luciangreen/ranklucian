:- module(rank_lucian,
    [ rank_lucian/2,
      extract_thoughts/2,
      applicable_thoughts/2,
      solve_intuitively/2,
      rank_strategies/3,
      find_performance_formula/2,
      best_variable_arrangement/3,
      optimise/2,
      debug/2,
      explain_strategy/2,
      verify_transformation/3,
      benchmark_strategies/3
    ]).

:- use_module(src/analyser).
:- use_module(src/thought_extract).
:- use_module(src/strategy).
:- use_module(src/chatbot).
:- use_module(src/strategy_rank).
:- use_module(src/formula_finder).
:- use_module(src/variable_arrangement).
:- use_module(src/explanation).
:- use_module(src/verifier).
:- use_module(src/benchmark).
:- use_module(src/debugger).

rank_lucian(Problem, Advice) :-
    analyser:rank_lucian(Problem, Advice).

extract_thoughts(Program, Thoughts) :-
    thought_extract:extract_thoughts(Program, Thoughts).

applicable_thoughts(Problem, Thoughts) :-
    strategy:applicable_thoughts(Problem, Thoughts).

solve_intuitively(Problem, Solutions) :-
    chatbot:solve_intuitively(Problem, Solutions).

rank_strategies(Problem, Profile, Strategies) :-
    strategy_rank:rank_strategies(Problem, Profile, Strategies).

find_performance_formula(Predicate, Formula) :-
    formula_finder:find_performance_formula(Predicate, Formula).

best_variable_arrangement(Predicate, Mode, Arrangement) :-
    variable_arrangement:best_variable_arrangement(Predicate, Mode, Arrangement).

optimise(Predicate, Optimised) :-
    strategy:optimise(Predicate, Optimised).

debug(Predicate, Diagnosis) :-
    debugger:debug(Predicate, Diagnosis).

explain_strategy(Strategy, Explanation) :-
    explanation:explain_strategy(Strategy, Explanation).

verify_transformation(Original, Candidate, Result) :-
    verifier:verify_transformation(Original, Candidate, default_domain, Result).

benchmark_strategies(Problem, Strategies, Results) :-
    benchmark:benchmark_strategies(Problem, Strategies, Results).
