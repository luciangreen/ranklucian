# ranklucian

Rank Lucian — Prolog Thought, Strategy and Formula Adviser.

## Command showcase

### 1) Load the library

```bash
swipl
?- [rank_lucian].
```

Starts an interactive SWI-Prolog session and loads the public API module.

---

### 2) Run the complete test suite

```bash
swipl -q -g "[tests/test_thoughts,tests/test_formula,tests/test_ranking,tests/test_analogy,tests/test_variable_arrangement,tests/test_queen_bug,tests/test_web],run_tests,halt"
```

Runs all repository tests in one command and exits when finished.

---

### 3) Run an individual test file

```bash
swipl -q -g "[tests/test_formula],run_tests,halt"
```

Executes only the formula-related tests, which is useful while iterating on one area.

---

### 4) Use the main adviser entry point

```bash
swipl -q -g "[rank_lucian],rank_lucian:rank_lucian('adjacent run grouping with accumulator',Advice),writeln(Advice),halt"
```

Asks Rank Lucian to analyse a problem description and print ranked advice.

---

### 5) Showcase every public API command

```prolog
?- rank_lucian:extract_thoughts("clump([H|T0],[H-C|T]):-ccount(T0,H,T1,1,C),clump(T1,T).", Thoughts).
?- rank_lucian:applicable_thoughts("adjacent run grouping with accumulator", Thoughts).
?- rank_lucian:solve_intuitively("group consecutive equal elements", Solutions).
?- rank_lucian:rank_strategies("group consecutive equal elements", fastest, Strategies).
?- rank_lucian:find_performance_formula(clumped, Formula).
?- rank_lucian:best_variable_arrangement(clumped, default, Arrangement).
?- rank_lucian:optimise(clumped, Optimised).
?- rank_lucian:debug(clumped, Diagnosis).
?- rank_lucian:explain_strategy(accumulator, Explanation).
?- rank_lucian:verify_transformation(clumped, clumped_optimised, Result).
?- rank_lucian:benchmark_strategies("group consecutive equal elements", [recursion, accumulator], Results).
```

These are the complete public predicates exported by `rank_lucian.pl`, shown as copy/paste-ready interactive commands.

---

### 6) Run benchmark helper

```bash
swipl -q -g "[benchmarks/benchmark_suite],run_benchmarks('group consecutive equal elements',Results),writeln(Results),halt"
```

Ranks candidate strategies and benchmarks them together for one problem prompt.

---

### 7) Start and stop the web API server

```bash
swipl -q -g "[web/server],server:start_server(8080)"
```

Starts the HTTP server.

```bash
curl "http://localhost:8080/api/advice?problem=adjacent%20run%20grouping"
```

Calls the API endpoint and returns JSON advice.

```prolog
?- server:stop_server.
```

Stops the server from the Prolog session where it was started.

## Primary API reference

- `rank_lucian(+Problem, -Advice).` — Main analysis entry point.
- `extract_thoughts(+Program, -Thoughts).` — Extracts thought patterns from source text.
- `applicable_thoughts(+Problem, -Thoughts).` — Lists thought patterns relevant to a problem statement.
- `solve_intuitively(+Problem, -Solutions).` — Produces intuitive solution candidates.
- `rank_strategies(+Problem, +Profile, -Strategies).` — Ranks candidate strategies by profile.
- `find_performance_formula(+Predicate, -Formula).` — Infers a performance formula for a predicate.
- `best_variable_arrangement(+Predicate, +Mode, -Arrangement).` — Suggests variable arrangement improvements.
- `optimise(+Predicate, -Optimised).` — Produces an optimised predicate variant.
- `debug(+Predicate, -Diagnosis).` — Runs diagnostic analysis on a predicate.
- `explain_strategy(+Strategy, -Explanation).` — Explains a named strategy.
- `verify_transformation(+Original, +Candidate, -Result).` — Checks transformation correctness.
- `benchmark_strategies(+Problem, +Strategies, -Results).` — Benchmarks selected strategies.
