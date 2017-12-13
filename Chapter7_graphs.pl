a(g,h).
a(g,d).
a(e,d).
a(h,f).
a(e,f).
a(a,e).
a(a,b).
a(b,f).
a(b,c).
a(f,c).
a(d,a).


% go(a, d).
go(X, X).
go(X, Y) :- a(X, Z), go(Z, Y).


% go(a, d, []).
go(X, X, _).
go(X, Y, T) :- a(X, Z), legal(Z, T), go(Z, Y, [Z|T]).

legal(_, []).
legal(X, [H|T]) :- \+ X = H, legal(X, T).


% goUndirected(c, d, []).
goUndirected(X, X, _).
goUndirected(X, Y, T) :-
    (a(X, Z) ; a(Z, X)),
    legal(Z, T), goUndirected(Z, Y, [Z|T]).