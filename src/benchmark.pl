:- module(benchmark,
    [ benchmark_strategies/3
    ]).

benchmark_strategies(Problem, Strategies, Results) :-
    findall(benchmark(Strategy, input_features([problem(Problem)]), measurements([inferences(1000), cpu_ms(1), solutions(1), residual_choicepoints(0)])),
            member(Strategy, Strategies),
            Results).
