# ranklucian

Rank Lucian — Prolog Thought, Strategy and Formula Adviser.

## Running tests

```bash
swipl -q -g "[tests/test_thoughts,tests/test_formula,tests/test_ranking,tests/test_analogy,tests/test_variable_arrangement,tests/test_queen_bug,tests/test_web],run_tests,halt"
```

## Primary API

- `rank_lucian(+Problem, -Advice).`
- `extract_thoughts(+Program, -Thoughts).`
- `applicable_thoughts(+Problem, -Thoughts).`
- `solve_intuitively(+Problem, -Solutions).`
- `rank_strategies(+Problem, +Profile, -Strategies).`
- `find_performance_formula(+Predicate, -Formula).`
- `best_variable_arrangement(+Predicate, +Mode, -Arrangement).`
- `optimise(+Predicate, -Optimised).`
- `debug(+Predicate, -Diagnosis).`
- `explain_strategy(+Strategy, -Explanation).`
- `verify_transformation(+Original, +Candidate, -Result).`
- `benchmark_strategies(+Problem, +Strategies, -Results).`
