:- begin_tests(verifier).
:- use_module('../src/verifier').

test(nonidentical_relations_are_checked) :-
    verifier:verify_transformation(plunit_verifier:identity_left,
                                   plunit_verifier:identity_right,
                                   cases([a, b]),
                                   tested_equivalent(2)).

test(counterexample_is_reported) :-
    verifier:verify_transformation(plunit_verifier:identity_left,
                                   plunit_verifier:constant_right,
                                   cases([a]),
                                   counterexample(a, [a], [same])).

test(default_domain_is_not_claimed_as_verified) :-
    verifier:verify_transformation(plunit_verifier:identity_left,
                                   plunit_verifier:identity_right,
                                   not_verified(no_test_cases)).

identity_left(Input, Input).
identity_right(Input, Input).
constant_right(_, same).

:- end_tests(verifier).
