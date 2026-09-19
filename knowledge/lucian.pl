:- module(lucian,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(memoisation, category(performance), problem(repeated_subproblem), idea(cache_repeated_calls), conditions([memoisation_candidate]), effects([reduced_recomputation]))).
knowledge_thought(thought(indexical_optimisation, category(performance), problem(repeated_lookup), idea(rewrite_repeated_nth_accesses_to_index_formula), conditions([repeated_lookup, formula_candidate]), effects([reduced_traversal]))).
knowledge_thought(thought(recursive_index_looping, category(performance), problem(nested_term_lookup), idea(derive_recursive_index_relation), conditions([nested_term, repeated_lookup]), effects([deterministic_selection]))).

provenance(memoisation, source(lucian_green_plop), location('PLOP concepts'), abstracted).
provenance(indexical_optimisation, source(lucian_green_plop), location('PLOP concepts'), abstracted).
provenance(recursive_index_looping, source(lucian_green_plop), location('PLOP concepts'), abstracted).
