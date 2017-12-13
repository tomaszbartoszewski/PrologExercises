a(newcastle, carlisle, 58).
a(carlisle, penrith, 23).
a(darlington, newcastle, 40).
a(penrith, darlington, 52).
a(workington, carlisle, 33).
a(workington, penrith, 39).

a(X, Y) :- a(X, Y, _).

rev(L1, L2) :- revzap(L1, [], L2).
revzap([X|L], L2, L3) :- revzap(L, [X|L2], L3).
revzap([], L, L).


go(Start, Dest, Route) :-
    go0(Start, Dest, [], R),
    rev(R, Route).

go0(X, X, T, [X|T]).
go0(Place, Y, T, R) :-
    legalnode(Place, T, Next),
    go0(Next, Y, [Place|T], R).

legalnode(X, Trail, Y) :-
    (a(X, Y) ; a(Y, X)), legal(Y, Trail).

legal(_, []).
legal(X, [H|T]) :- \+ X = H, legal(X, T).


%go(Start, Dest, Route) :-
%    go1([[Start]], Dest, R),
%    rev(R, Route).
%
%go1([First|Rest], Dest, First) :- First = [Dest|_].
%go1([[Last|Trail]|Others], Dest, Route) :-
%    findall([Z, Last|Trail], legalnode(Last, Trail, Z), List),
%    append(List, Others, NewRoutes),
%    go1(NewRoutes, Dest, Route).