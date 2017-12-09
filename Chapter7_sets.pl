% member(2, [1,3,4,5]).
% member(2, [1,2,3,4,5]).
member(X, [X|_]).
member(X, [_|Y]) :- member(X, Y).

% subset([1,3,5], [1,2,3,4,5]).
% subset([1,5], [1,2,3,X]).
subset([], _).
subset([A|X], Y) :- member(A, Y), subset(X, Y).

% intersection([1,2,3,4,5], [5,6,7,8,2], X).
% intersection([1,2,3,4,5], X, [1,2,3,4,5]).
% intersection([1,2,3,4,5,A], X, [1,2,3,4,5,6]).
intersection([], _, []).
intersection([X|R], Y, [X|Z]) :-
    member(X, Y),
    !,
    intersection(R, Y, Z).
intersection([_|R], Y, Z) :- intersection(R, Y, Z).

% union([1,2,3], [4,5,6], X).
% union([1,2,3], [1,2,4,5,6], X).
union([], X, X).
union([X|R], Y, Z) :- member(X, Y), !, union(R, Y, Z).
union([X|R], Y, [X|Z]) :- union(R, Y, Z).