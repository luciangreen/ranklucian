:- module(strategy_rank,
    [ strategy_score/3,
      rank_strategies/3
    ]).

:- use_module(strategy).

% A strategy's score comes from the thought it is named after: the measures
% its category and effects improve are raised above a common base, so
% strategies with different aims get different scores.
strategy_score(strategy(retain_original, _), _Problem,
    score(correctness(0.95), determinism(0.6), termination(0.65), asymptotic_cost(0.4), measured_speed(0.4), memory(0.5), simplicity(0.9), generality(0.5), purity(0.6), maintainability(0.7))) :- !.
strategy_score(strategy(Name, Thoughts), _Problem, Score) :-
    (   member(thought(Name, category(Category), _, _, _, effects(Effects)), Thoughts)
    ->  true
    ;   Category = none, Effects = []
    ),
    Measures = [correctness, determinism, termination, asymptotic_cost, measured_speed,
                memory, simplicity, generality, purity, maintainability],
    maplist(measure_value(Category, Effects), Measures, Values),
    Score =.. [score|Values].

measure_value(Category, Effects, Measure, Term) :-
    Base = 0.6,
    ( category_measure(Category, Measure) -> C = 0.25 ; C = 0 ),
    aggregate_all(count, (member(E, Effects), effect_measure(E, Measure)), N),
    V0 is Base + C + 0.1 * N,
    V is min(1.0, V0),
    Term =.. [Measure, V].

category_measure(performance, asymptotic_cost).
category_measure(performance, measured_speed).
category_measure(formula, asymptotic_cost).
category_measure(memory, memory).
category_measure(correctness, correctness).
category_measure(declarative, purity).
category_measure(declarative, generality).
category_measure(termination, termination).
category_measure(determinism, determinism).
category_measure(structure, simplicity).
category_measure(structure, maintainability).

effect_measure(reduced_recomputation, measured_speed).
effect_measure(reduced_traversal, asymptotic_cost).
effect_measure(deterministic_selection, determinism).
effect_measure(clean_decomposition, maintainability).
effect_measure(lower_memory, memory).
effect_measure(predictive_cost_model, asymptotic_cost).
effect_measure(fewer_choicepoints, determinism).
effect_measure(faster_clause_selection, measured_speed).
effect_measure(single_pass, asymptotic_cost).
effect_measure(tail_recursive_inner_loop, memory).
effect_measure(behavioural_equivalence, correctness).
effect_measure(better_mode_generality, generality).
effect_measure(safer_execution, termination).
effect_measure(debuggability, maintainability).

rank_strategies(Problem, Profile, Ranked) :-
    strategy:candidate_strategies(Problem, [], Strategies),
    findall(rank(Weighted, S, Score),
            ( member(S, Strategies),
              strategy_score(S, Problem, Score),
              weighted(Profile, Score, Weighted)
            ),
            Scored),
    % Highest first; equal scores keep the strategies' name order.
    sort(1, @>=, Scored, Ranked).

% One weighting per profile: the correctness fallback is only for profiles
% not named below.
weighted(Profile, Score, W) :-
    weighted_(Profile, Score, W),
    !.

weighted_(fastest, score(_,_,_,asymptotic_cost(A),measured_speed(M),_,_,_,_,_), W) :- W is A + M.
weighted_(most_declarative, score(_,_,_,_,_,_,_,_,purity(P),_), P).
weighted_(most_deterministic, score(_,determinism(D),_,_,_,_,_,_,_,_), D).
weighted_(lowest_memory, score(_,_,_,_,_,memory(Mem),_,_,_,_), Mem).
weighted_(simplest, score(_,_,_,_,_,_,simplicity(S),_,_,_), S).
weighted_(most_general, score(_,_,_,_,_,_,_,generality(G),_,_), G).
weighted_(safest, score(correctness(C),_,termination(T),_,_,_,_,_,_,maintainability(M)), W) :- W is (C+T+M)/3.
weighted_(best_for_swi_prolog, score(_,determinism(D),_,_,measured_speed(M),_,_,_,_,_), W) :- W is D+M.
weighted_(best_for_detlog, score(_,determinism(D),termination(T),_,_,_,_,_,purity(P),_), W) :- W is D+T+P.
weighted_(_, score(correctness(C),_,_,_,_,_,_,_,_,_), C).
