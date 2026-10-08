:- module(benchmark,
    [ benchmark_strategies/3
    ]).

:- use_module(library(time)).

benchmark_strategies(Problem, Strategies, Results) :-
    maplist(benchmark_strategy(Problem), Strategies, Results).

benchmark_strategy(Problem, Strategy,
                   benchmark(Strategy, input_features([problem(Problem)]), Result)) :-
    (   Strategy = benchmark_goal(Goal),
        callable(Goal)
    ->  measure_goal(Goal, Result)
    ;   Result = not_measured(no_executable_goal)
    ).

measure_goal(Goal, Result) :-
    catch(call_with_time_limit(
              1,
              ( statistics(inferences, Inferences0),
                statistics(cputime, Cpu0),
                findall(true, call(Goal), Solutions),
                statistics(cputime, Cpu1),
                statistics(inferences, Inferences1)
              )),
          Error,
          Result = not_measured(Error)),
    (   var(Result)
    ->  length(Solutions, SolutionCount),
        Inferences is Inferences1 - Inferences0,
        CpuMilliseconds is (Cpu1 - Cpu0) * 1000,
        Result = measurements([inferences(Inferences),
                               cpu_ms(CpuMilliseconds),
                               solutions(SolutionCount)])
    ;   true
    ).
