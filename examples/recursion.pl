sum_list([], 0).
sum_list([H|T], S) :-
    sum_list(T, Rest),
    S is H + Rest.
