a(newcastle, carlisle, 58).
a(carlisle, penrith, 23).
a(smallville, metropolis, 15).
a(penrith, darlington, 52).
a(smallville, ambridge, 10).
a(workington, carlisle, 33).
a(workington, ambridge, 5).
a(workington, penrith, 39).
a(darlington, metropolis, 25).


% go(darlington, workington, Route, Dist).

go(Start, Dest, Route, Dist) :-
    go3([r(0, [Start])], Dest, R, Dist),
    rev(R, Route).

go3(Routes, Dest, Route, Dist) :-
    shortest(Routes, Shortest, RestRoutes),
    proceed(Shortest, Dest, RestRoutes, Route, Dist).

proceed(r(Dist, Route), Dest, _, Route, Dist) :-
    Route = [Dest|_].
proceed(r(Dist, [Last|Trail]), Dest, Routes, Route, DistReturn) :-
    findall(
        r(D1, [Z,Last|Trail]),
        legalnode(Last, Trail, Z, Dist, D1),
        List),
    append(List, Routes, NewRoutes),
    go3(NewRoutes, Dest, Route, DistReturn).

shortest([Route|Routes], Shortest, [Route|Rest]) :-
    shortest(Routes, Shortest, Rest),
    shorter(Shortest, Route),
    !.

shortest([Route|Rest], Route, Rest).
shorter(r(M1,_), r(M2,_)) :- M1 < M2.

legalnode(X, Trail, Y, Dist, NewDist) :-
    (a(X, Y, Z) ; a(Y, X, Z)),
    legal(Y, Trail),
    NewDist is Dist + Z.

legal(_, []).
legal(X, [H|T]) :- \+ X = H, legal(X, T).

rev(L1, L2) :- revzap(L1, [], L2).
revzap([X|L], L2, L3) :- revzap(L, [X|L2], L3).
revzap([], L, L).