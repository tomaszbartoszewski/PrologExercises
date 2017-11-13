% last(X, [talk,of,the,town]).
last(X, [X]).
last(X, [_|Y]) :- last(X, Y).

% nextto(X,Y,[1,2,3,4]).
nextto(X, Y, [X,Y|_]).
nextto(X,Y,[_|Z]) :- nextto(X,Y,Z).

% append([a,b,c],[d,e,f],X).
append([], L, L).
append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).

% last2(X, [1,2,3,4]).
last2(El, List) :- append(_, [El], List).

% next_to(X,Y,[1,2,3,4]).
next_to(El1, El2, List) :- append(_, [El1,El2|_], List).

% member(X, [1,2,3]).
member(El, List) :- append(_, [El|_], List).

% rev([1,2,3,4],X).
rev([],[]).
rev([H|T], L) :- rev(T,Z), append(Z, [H], L).

% rev2([1,2,3,4],X).
rev2(L1, L2) :- revzap(L1, [], L2).
revzap([X|L], L2, L3) :- revzap(L, [X|L2], L3).
revzap([], L, L).

% removes only first appearance of the value
% efface(2, [1,2,3,4], X).
% efface(Y, [1,2,3,4], [1,2,3]).
efface(A, [A|L], L) :- !.
efface(A, [B|L], [B|M]) :- efface(A, L, M).
% efface(_, [], []). with that one it will not fail if A is not in the list

% delete(1, [1,2,3,1,4,5,1], X).
delete(_, [], []).
delete(X, [X|L], M) :- !, delete(X, L, M).
delete(X, [Y|L1], [Y|L2]) :- delete(X, L1, L2).

% subst(1, [1,2,3,1,4,5,1], 999, X).
subst(_, [], _, []).
subst(X, [X|L], A, [A|M]) :- !, subst(X, L, A, M).
subst(X, [Y|L], A, [Y|M]) :- subst(X, L, A, M).

% sublist([of,the,club], [meetings,of,the,club,will,be,held]).
% sublist([of,X,club], [meetings,of,the,club,will,be,held]).
% sublist([of,X,club], [meetings,Y,the,club,will,be,held]).
sublist([X|L], [X|M]) :- prefix(L, M), !.
sublist(L, [_|M]) :- sublist(L, M).

prefix([], _).
prefix([X|L], [X|M]) :- prefix(L, M).

% remdup([1,2,3,4,1,5,2,6,1,7,2,8,1,9,3],X).
remdup(L,M) :- dupacc(L, [], M).
dupacc([], A, A).
dupacc([H|T], A, L) :- member(H, A), !, dupacc(T, A, L).
dupacc([H|T], A, L) :- dupacc(T, [H|A], L).