:- module(general,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(return_unprocessed_suffix, category(structure), problem(streaming_decomposition), idea(return_remainder_and_recurse), conditions([recursive_list]), effects([clean_decomposition]))).
knowledge_thought(thought(avoid_unnecessary_intermediate_lists, category(memory), problem(list_processing), idea(avoid_materialising_temporary_groups), conditions([adjacent_runs, performance_issue]), effects([lower_memory]))).

provenance(return_unprocessed_suffix, source(general_pattern), location('list decomposition'), authored).
provenance(avoid_unnecessary_intermediate_lists, source(general_pattern), location('list processing'), authored).
