:- module(variable_arrangement,
    [ best_variable_arrangement/4,
      best_variable_arrangement/3
    ]).

best_variable_arrangement(Predicate, Mode, arrangement(first_argument_indexed, state_in_accumulator, recursive_suffix), explanation(Dependencies)) :-
    derive_dependencies(Predicate, Mode, Dependencies).

best_variable_arrangement(Predicate, Mode, Arrangement) :-
    best_variable_arrangement(Predicate, Mode, Arrangement, _).

derive_dependencies(Predicate, Mode, [known_input(Predicate), mode(Mode), computable_suffix, deterministic_selection]).
