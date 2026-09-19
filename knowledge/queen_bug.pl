:- module(queen_bug_knowledge,
    [ knowledge_thought/1,
      provenance/4
    ]).

knowledge_thought(thought(preserve_choice_identity, category(correctness), problem(choicepoint_sensitive_transformation), idea(keep_choicepoint_identity_when_rewriting), conditions([choicepoints]), effects([behavioural_equivalence]))).

provenance(preserve_choice_identity, source(queen_bug_case_study), location('queen bug lessons'), user_supplied).
