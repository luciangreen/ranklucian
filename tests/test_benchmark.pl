:- begin_tests(benchmark).
:- use_module('../src/benchmark').

test(abstract_strategy_is_not_reported_as_measured) :-
    benchmark:benchmark_strategies(problem, [strategy(accumulator, [])],
                                  [benchmark(_, _, not_measured(no_executable_goal))]).

test(executable_goal_is_measured) :-
    benchmark:benchmark_strategies(problem,
                                  [benchmark_goal(plunit_benchmark:sample_goal)],
                                  [benchmark(_, _, measurements(Measurements))]),
    member(inferences(Inferences), Measurements),
    Inferences > 0,
    member(solutions(2), Measurements).

sample_goal(a).
sample_goal(b).

:- end_tests(benchmark).
