:- module(strategy_rank,
    [ strategy_score/3,
      rank_strategies/3
    ]).

:- use_module(strategy).

strategy_score(Strategy, _Problem,
    score(
        correctness(0.9),
        determinism(0.8),
        termination(0.85),
        asymptotic_cost(0.75),
        measured_speed(0.7),
        memory(0.7),
        simplicity(0.8),
        generality(0.75),
        purity(0.8),
        maintainability(0.8)
    )) :-
    Strategy \= strategy(retain_original, _).
strategy_score(strategy(retain_original, _), _Problem,
    score(correctness(0.95), determinism(0.6), termination(0.65), asymptotic_cost(0.4), measured_speed(0.4), memory(0.5), simplicity(0.9), generality(0.5), purity(0.6), maintainability(0.7))).

rank_strategies(Problem, Profile, Ranked) :-
    strategy:candidate_strategies(Problem, [], Strategies),
    findall(rank(Weighted, S, Score),
            ( member(S, Strategies),
              strategy_score(S, Problem, Score),
              weighted(Profile, Score, Weighted)
            ),
            Scored),
    sort(1, @>=, Scored, Ranked).

weighted(fastest, score(_,_,_,asymptotic_cost(A),measured_speed(M),_,_,_,_,_), W) :- W is A + M.
weighted(most_declarative, score(_,_,_,_,_,_,_,_,purity(P),_), P).
weighted(most_deterministic, score(_,determinism(D),_,_,_,_,_,_,_,_), D).
weighted(lowest_memory, score(_,_,_,_,_,memory(Mem),_,_,_,_), Mem).
weighted(simplest, score(_,_,_,_,_,_,simplicity(S),_,_,_), S).
weighted(most_general, score(_,_,_,_,_,_,_,generality(G),_,_), G).
weighted(safest, score(correctness(C),_,termination(T),_,_,_,_,_,_,maintainability(M)), W) :- W is (C+T+M)/3.
weighted(best_for_swi_prolog, score(_,determinism(D),_,_,measured_speed(M),_,_,_,_,_), W) :- W is D+M.
weighted(best_for_detlog, score(_,determinism(D),termination(T),_,_,_,_,_,purity(P),_), W) :- W is D+T+P.
weighted(_, score(correctness(C),_,_,_,_,_,_,_,_,_), C).
