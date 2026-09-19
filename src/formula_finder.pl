:- module(formula_finder,
    [ find_performance_formula/4,
      find_performance_formula/2
    ]).

find_performance_formula(Predicate, Modes, CandidateArrangements, results(Models, Best)) :-
    findall(model(Arrangement, Formula),
            (member(Arrangement, CandidateArrangements), estimate_formula(Predicate, Modes, Arrangement, Formula)),
            Models),
    best_model(Models, Best).

find_performance_formula(Predicate, formula(best_guess(linear, 'T(n)=a*n+b'), structural_variables([n]))) :-
    Predicate \= [].

estimate_formula(_Predicate, _Modes, Arrangement, formula(linear, 'T(n)=a*n+b', [arrangement(Arrangement)])).

best_model([H|T], Best) :-
    foldl(prefer_simple, T, H, Best).
best_model([], none).

prefer_simple(Candidate, Current, Best) :-
    (   Candidate = model(_, formula(linear, _, _)),
        Current \= model(_, formula(linear, _, _))
    ->  Best = Candidate
    ;   Best = Current
    ).
