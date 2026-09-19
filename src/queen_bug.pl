:- module(queen_bug,
    [ analyse_queen_bug/2
    ]).

analyse_queen_bug(Program, analysis(
    program(Program),
    findings([preserve_choice_identity, avoid_state_loss_across_optimisation, validate_control_flow_equivalence]),
    reusable_thoughts([
        thought(preserve_choice_identity, category(correctness), problem(choicepoint_sensitive_transformation), idea(preserve_choicepoint_identity_when_rewriting_control), conditions([transformation_changes_control_flow, result_depends_on_choicepoint_identity]), effects([behavioural_equivalence]))
    ])
)).
