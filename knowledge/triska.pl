:- module(triska,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(describe_relation_not_procedure, category(declarative), problem(relational_design), idea(start_from_truth_conditions), conditions([relational_design]), effects([better_mode_generality]))).
knowledge_thought(thought(reason_about_termination, category(termination), problem(recursive_relation), idea(prove_termination_in_intended_modes), conditions([recursive_list, relational_design]), effects([safer_execution]))).
knowledge_thought(thought(use_declarative_testing, category(correctness), problem(relational_design), idea(specify_relations_with_tests), conditions([relational_design]), effects([debuggability]))).

provenance(describe_relation_not_procedure, source(markus_triska_power_of_prolog), location('design guidance'), direct).
provenance(reason_about_termination, source(markus_triska_power_of_prolog), location('termination guidance'), direct).
provenance(use_declarative_testing, source(markus_triska_power_of_prolog), location('testing guidance'), direct).
