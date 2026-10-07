:- module(formula_finder,
    [ find_performance_formula/4,
      find_performance_formula/2
    ]).

find_performance_formula(Predicate, Modes, CandidateArrangements,
                         results(Models, Best)) :-
    findall(model(Arrangement, Formula),
            ( member(Arrangement, CandidateArrangements),
              estimate_formula(Predicate, Modes, Arrangement, Formula)
            ),
            Models),
    best_model(Models, Best).

find_performance_formula(Predicate,
                         formula(best_guess(Complexity, Expression),
                                 structural_variables(Variables))) :-
    infer_complexity(Predicate, Complexity),
    formula_expression(Complexity, Expression),
    ( Complexity = unknown -> Variables = [] ; Variables = [n] ).

estimate_formula(Predicate, Modes, Arrangement,
                 formula(Complexity, Expression,
                         [arrangement(Arrangement), modes(Modes)])) :-
    infer_complexity(Predicate, Complexity),
    formula_expression(Complexity, Expression).

infer_complexity(Predicate, Complexity) :-
    (   predicate_indicator(Predicate, Name, Arity)
    ->  findall(RecursiveCalls,
                ( predicate_clause(Name, Arity, Head, Body),
                  functor(Head, Name, Arity),
                  recursive_goal_count(Body, Name, Arity, RecursiveCalls)
                ),
                Counts),
        (   Counts = []
        ->  Complexity = unknown
        ;   max_list(Counts, Maximum),
            (   Maximum =:= 0 -> Complexity = constant
            ;   Maximum =:= 1 -> Complexity = linear
            ;   Complexity = exponential
            )
        )
    ;   Complexity = unknown
    ).

predicate_indicator(Predicate, Name, Arity) :-
    strip_module(Predicate, _, Plain),
    (   atom(Plain)
    ->  current_module(Module),
        current_predicate(Module:Name/Arity),
        predicate_clause(Name, Arity, _, _),
        !
    ;   callable(Plain)
    ->  functor(Plain, Name, Arity)
    ).

predicate_clause(Name, Arity, Head, Body) :-
    current_module(Module),
    functor(Head, Name, Arity),
    catch(clause(Module:Head, Body), _, fail).

recursive_goal_count(Goal, Name, Arity, Count) :-
    (   var(Goal)
    ->  Count = 0
    ;   Goal = (Left, Right)
    ->  recursive_goal_count(Left, Name, Arity, LeftCount),
        recursive_goal_count(Right, Name, Arity, RightCount),
        Count is LeftCount + RightCount
    ;   Goal = (Left ; Right)
    ->  recursive_goal_count(Left, Name, Arity, LeftCount),
        recursive_goal_count(Right, Name, Arity, RightCount),
        Count is max(LeftCount, RightCount)
    ;   Goal = (If -> Then ; Else)
    ->  recursive_goal_count(If, Name, Arity, IfCount),
        recursive_goal_count(Then, Name, Arity, ThenCount),
        recursive_goal_count(Else, Name, Arity, ElseCount),
        Count is IfCount + max(ThenCount, ElseCount)
    ;   Goal = (If -> Then)
    ->  recursive_goal_count(If, Name, Arity, IfCount),
        recursive_goal_count(Then, Name, Arity, ThenCount),
        Count is IfCount + ThenCount
    ;   Goal = Module:Inner
    ->  ( Inner =.. [Name|Arguments],
          length(Arguments, Arity)
        -> Count = 1
        ;  recursive_goal_count(Inner, Name, Arity, Count)
        )
    ;   callable(Goal),
        functor(Goal, Name, Arity)
    ->  Count = 1
    ;   Count = 0
    ).

formula_expression(linear, 'T(n)=a*n+b').
formula_expression(exponential, 'T(n)=a^n+b').
formula_expression(constant, 'T(n)=c').
formula_expression(unknown, unknown(no_loaded_definition)).

best_model([Model|Models], Best) :-
    !,
    foldl(prefer_simple, Models, Model, Best).
best_model([], none).

prefer_simple(Candidate, Current, Best) :-
    (   Candidate = model(_, formula(constant, _, _))
    ->  Best = Candidate
    ;   Current = model(_, formula(exponential, _, _))
    ->  Best = Candidate
    ;   Best = Current
    ).
