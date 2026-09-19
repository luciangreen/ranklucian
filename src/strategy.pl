:- module(strategy,
    [ applicable_thoughts/2,
      candidate_strategies/3,
      optimise/2
    ]).

:- use_module(features).
:- use_module('../knowledge/lucian').
:- use_module('../knowledge/plop').
:- use_module('../knowledge/triska').
:- use_module('../knowledge/swi').
:- use_module('../knowledge/queen_bug').
:- use_module('../knowledge/general').

applicable_thoughts(Problem, Thoughts) :-
    features:problem_features(Problem, Features),
    all_thoughts(All),
    include(matches_features(Features), All, Thoughts0),
    ( Thoughts0 = [] -> Thoughts = All ; Thoughts = Thoughts0 ).

candidate_strategies(Problem, Features, Strategies) :-
    applicable_thoughts(Problem, Thoughts),
    findall(strategy(Name, Thoughts),
            (member(thought(Name, _, _, _, _, _), Thoughts)),
            Strategies0),
    ( Strategies0 = [] -> Strategies = [strategy(retain_original, Features)] ; sort(Strategies0, Strategies) ).

optimise(Predicate, optimisation_plan(Predicate, Strategies)) :-
    features:problem_features(Predicate, Features),
    candidate_strategies(Predicate, Features, Strategies).

all_thoughts(All) :-
    findall(T, lucian:knowledge_thought(T), L1),
    findall(T, plop:knowledge_thought(T), L2),
    findall(T, triska:knowledge_thought(T), L3),
    findall(T, swi:knowledge_thought(T), L4),
    findall(T, queen_bug_knowledge:knowledge_thought(T), L5),
    findall(T, general:knowledge_thought(T), L6),
    append([L1,L2,L3,L4,L5,L6], Flat),
    sort(Flat, All).

matches_features(Features, thought(_, _, _, _, conditions(Conditions), _)) :-
    intersection(Features, Conditions, Inter),
    Inter \= [].
