:- module(plop,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(gaussian_formula_discovery, category(formula), problem(polynomial_relation), idea(fit_numeric_relation_with_elimination), conditions([formula_candidate]), effects([predictive_cost_model]))).
knowledge_thought(thought(deterministic_loop_conversion, category(determinism), problem(avoidable_choicepoint), idea(convert_safe_nondet_loop_to_det), conditions([choicepoints]), effects([fewer_choicepoints]))).

provenance(gaussian_formula_discovery, source(plop), location('optimisation stages'), abstracted).
provenance(deterministic_loop_conversion, source(plop), location('optimisation stages'), abstracted).
