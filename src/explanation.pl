:- module(explanation,
    [ explain_strategy/2,
      why_ranked/2
    ]).

explain_strategy(Strategy, explanation(Strategy, why('Matches recognised structure, preserves correctness confidence, and provides measurable trade-offs.'))).

why_ranked(Strategy, explanation(Strategy,
    [ 'Ranked using multi-dimensional score (correctness, determinism, termination, cost, speed, memory, simplicity, generality, purity, maintainability).',
      'Numerical benchmark claims are emitted only from benchmark results.'
    ])).
