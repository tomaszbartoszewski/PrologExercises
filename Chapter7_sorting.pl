order(X, Y) :- X =< Y.

% naivesort([5,4,3,2,1,1,4,8], X).
naivesort(L1, L2) :- permutation_internal(L1, L2), sorted(L2), !.
permutation_internal([], []).
permutation_internal(L, [H|T]) :-
    append(V, [H|U], L),
    append(V, U, W),
    permutation_internal(W, T).
sorted([]).
sorted([_]).
sorted([X, Y|L]) :- order(X, Y), sorted([Y|L]).


% insort([5,4,3,2,1,1,4,8], X).
insort([], []).
insort([X|L], M) :- insort(L, N), insortx(X, N, M).
insortx(X, [A|L], [A|M]) :-
    order(A, X), !, insortx(X, L, M).
insortx(X, L, [X|L]).


% insort2([5,4,3,2,1,1,4,8], X, '=<').
% insort2([e,d,c,b,a,a,d,h], X, '@=<').
insort2([], [], _).
insort2([X|L], M, O) :- insort2(L, N, O), insortx2(X, N, M, O).
insortx2(X, [A|L], [A|M], O) :-
    P =.. [O, A, X],
    call(P), !,
    insortx2(X, L, M, O).
insortx2(X, L, [X|L], _).


% bubblesort([5,4,3,2,1,1,4,8], X).
order2(X, Y) :- X < Y.
bubblesort(L, S) :-
    appendWithBacktracking(X, [A,B|Y], L),
    order2(B, A), !,
    appendWithBacktracking(X, [B,A|Y], M),
    bubblesort(M, S).
bubblesort(L, L).
appendWithBacktracking([], L, L).
appendWithBacktracking([H|T], L, [H|V]) :- appendWithBacktracking(T, L, V).


% quicksort([5,4,3,2,1,1,4,8], X).
split(H, [A|X], [A|Y], Z) :- order(A,H), split(H, X, Y, Z).
split(H, [A|X], Y, [A|Z]) :- \+(order(A, H)), split(H, X, Y, Z).
split(_, [], [], []).
quicksort([], []).
quicksort([H|T], S) :-
    split(H, T, A, B),
    quicksort(A, A1),
    quicksort(B, B1),
    append(A1, [H|B1], S).

% quicksort2([5,4,3,2,1,1,4,8], X).
quicksort2(X, Y) :- quicksortx(X, Y, []).
quicksortx([], X, X).
quicksortx([H|T], S, X) :-
    split(H, T, A, B),
    quicksortx(A, S, [H|Y]),
    quicksortx(B, Y, X).

% Exercise 7.6, this version is slower than quicksort, but it does sort
% maybe append slows it down
% time(hybridsort([5,4,3,2,1,1,4,8,1,2], X)).
hybridsort(X, Y) :- length(X, Length), hybridsortx(X, Y, [], Length).
hybridsortx(L, S, X, Lenght) :-
    Lenght < 10, !,
    insort(L, Sorted),
    append(Sorted, X, S).
hybridsortx([H|T], S, X, _) :-
    splitWithCount(H, T, A, B, ALength, BLength),
    hybridsortx(A, S, [H|Y], ALength),
    hybridsortx(B, Y, X, BLength).

splitWithCount(H, [A|X], [A|Y], Z, YLength, ZLength) :- order(A,H), splitWithCount(H, X, Y, Z, YL1, ZLength), YLength is YL1 + 1.
splitWithCount(H, [A|X], Y, [A|Z], YLength, ZLength) :- \+(order(A, H)), splitWithCount(H, X, Y, Z, YLength, ZL1), ZLength is ZL1 + 1.
splitWithCount(_, [], [], [], 0, 0).