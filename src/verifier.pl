:- module(verifier,
    [ verify_transformation/4,
      verify_transformation/3
    ]).

:- use_module(library(time)).

verify_transformation(Original, Candidate, _TestDomain, proved_equivalent) :-
    Original == Candidate, !.
verify_transformation(Original, Candidate, cases(Inputs), Result) :-
    !,
    (   is_list(Inputs), Inputs \= []
    ->  verify_cases(Inputs, Original, Candidate, 0, Result)
    ;   Result = not_verified(empty_test_domain)
    ).
verify_transformation(_Original, _Candidate, _TestDomain,
                      not_verified(no_test_cases)).

verify_cases([], _Original, _Candidate, Count, tested_equivalent(Count)).
verify_cases([Input|Inputs], Original, Candidate, Count, Result) :-
    relation_answers(Original, Input, OriginalResult),
    relation_answers(Candidate, Input, CandidateResult),
    (   OriginalResult = answers(OriginalAnswers),
        CandidateResult = answers(CandidateAnswers),
        OriginalAnswers == CandidateAnswers
    ->  NextCount is Count + 1,
        verify_cases(Inputs, Original, Candidate, NextCount, Result)
    ;   OriginalResult = answers(OriginalAnswers),
        CandidateResult = answers(CandidateAnswers)
    ->  Result = counterexample(Input, OriginalAnswers, CandidateAnswers)
    ;   Result = verification_error(Input, OriginalResult, CandidateResult)
    ).

relation_answers(Goal, Input, Result) :-
    catch(call_with_time_limit(1,
                               findall(Output, call(Goal, Input, Output), Answers)),
          Error,
          Result = error(Error)),
    (   var(Result)
    ->  Result = answers(Answers)
    ;   true
    ).

verify_transformation(Original, Candidate, Result) :-
    verify_transformation(Original, Candidate, default_domain, Result).
