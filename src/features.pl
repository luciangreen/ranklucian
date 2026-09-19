:- module(features,
    [ problem_features/2,
      normalise_problem/2
    ]).

normalise_problem(Problem, Atom) :-
    (   string(Problem) -> string_lower(Problem, Lower), atom_string(Atom, Lower)
    ;   atom(Problem) -> downcase_atom(Problem, Atom)
    ;   term_string(Problem, S), string_lower(S, Lower), atom_string(Atom, Lower)
    ).

problem_features(Problem, Features) :-
    normalise_problem(Problem, Text),
    findall(F, feature_token(F, Tokens), Pairs),
    include(matches_token(Text), Pairs, Features0),
    sort(Features0, Features).

matches_token(Text, Feature) :-
    feature_token(Feature, Tokens),
    member(Token, Tokens),
    sub_atom(Text, _, _, _, Token), !.

feature_token(repeated_lookup, [nth1, lookup, index, indexing]).
feature_token(nested_term, [nested, term, subterm]).
feature_token(adjacent_runs, [adjacent, run, clump, grouped]).
feature_token(recursive_list, [list, head, tail]).
feature_token(choicepoints, [choicepoint, nondeterministic, backtracking]).
feature_token(matrix_traversal, [matrix, coordinate, row, column]).
feature_token(formula_candidate, [formula, algebraic, polynomial, linear]).
feature_token(memoisation_candidate, [memoise, memoization, cache]).
feature_token(relational_design, [relation, declarative, purity, mode]).
feature_token(performance_issue, [slow, faster, optimise, optimize, performance]).
