clump([], []).
clump([H|T0], [H-C|T]) :-
    ccount(T0, H, T1, 1, C),
    clump(T1, T).

ccount([H|T0], H, T, C0, C) :-
    C1 is C0+1,
    ccount(T0, H, T, C1, C).
ccount(List, _, List, C, C).
