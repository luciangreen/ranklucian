:- module(chatbot,
    [ solve_intuitively/2,
      chatbot_menu/1
    ]).

:- use_module(features).
:- use_module(analogy).
:- use_module(strategy).

chatbot_menu([
    'Solve problem',
    'Optimise predicate',
    'Debug predicate',
    'Find formula',
    'Find best variable arrangement',
    'Explain code',
    'Find analogous thought',
    'Compare strategies',
    'Apply PLOP',
    'Declarative redesign',
    'Performance redesign',
    'Queen Bug analysis'
]).

solve_intuitively(Problem, solutions(Features, Cases, Strategies)) :-
    features:problem_features(Problem, Features),
    analogy:analogous_cases(Features, 3, Cases),
    strategy:candidate_strategies(Problem, Features, Strategies).
