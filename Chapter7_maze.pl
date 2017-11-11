% doors between rooms
d(a,b).
d(b,e).
d(b,c).
%d(d,e).
d(e,d).
d(c,d).
d(e,f).
d(g,e).

hasphone(g).

go(X,X,_).
go(X,Y,T) :-
    (d(X,Z) ; d(Z,X)),
    \+ member(Z, T),
    write('entering room '), write(Z), nl,
    go(Z,Y,[Z|T]).

searchPhone(Start, RoomWithPhone) :-
    go(Start, RoomWithPhone, []),
    hasphone(RoomWithPhone),
    !,
    write('found telephone in room '), write(RoomWithPhone), nl.