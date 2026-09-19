:- module(swi,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(exploit_first_argument_indexing, category(performance), problem(predicate_selection), idea(place_discriminating_argument_first), conditions([performance_issue]), effects([faster_clause_selection]))).
knowledge_thought(thought(consume_input_incrementally, category(performance), problem(run_length_encoding), idea(outer_loop_handles_runs_inner_loop_consumes_run), conditions([adjacent_runs]), effects([single_pass]))).
knowledge_thought(thought(use_accumulator_for_local_state, category(performance), problem(local_counting), idea(track_local_state_in_tail_recursive_helper), conditions([adjacent_runs, recursive_list]), effects([tail_recursive_inner_loop]))).

provenance(exploit_first_argument_indexing, source(swi_prolog_jan_wielemaker), location('engineering patterns'), inferred).
provenance(consume_input_incrementally, source(swi_prolog_library_clumped), location('clumped/2 + ccount/5'), abstracted).
provenance(use_accumulator_for_local_state, source(swi_prolog_library_clumped), location('clumped/2 + ccount/5'), abstracted).
