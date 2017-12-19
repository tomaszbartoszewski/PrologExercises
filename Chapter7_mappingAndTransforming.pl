% alter([1, 2, 3, 4, 5, 6], X).

alter([], []).
alter([A|B], [C|D]) :- change(A, C), alter(B, D).

change(1, a).
change(2, b).
change(3, c).
change(4, d).
change(5, e).
change(6, f).


% maplist(change_words, [you, are, a, computer], Z).

maplist(_, [], []).
maplist(P, [X|L], [Y|M]) :-
    Q =.. [P, X, Y], call(Q), maplist(P, L, M).

change_words(you, i).
change_words(are, [am,not]).
change_words(do, no).
change_words(french, german).
change_words(H, H).


% phh([a,b,c,d]).

phh(List) :- applist(write_space, List).

applist(_, []).
applist(P, [X|L]) :-
    Q =.. [P, X], call(Q), applist(P, L).

write_space(X) :- write(X), spaces(1).
spaces(0) :- !.
spaces(N) :- write(' '), N1 is N - 1, spaces(N1).


% simp(1+1*2+x+3*4+7, X).

simp(E, E) :- atomic(E), !.
simp(E, F) :-
    E =.. [Op, La, Ra],
    simp(La, X),
    simp(Ra, Y),
    % write(La), write(' '), write(Op), write(' '), write(Ra), nl,
    s(Op, X, Y, F).

s(+, X, 0, X) :- \+ number(X), !.
s(+, 0, X, X) :- \+ number(X), !.
s(+, X, Y, Z) :- number(X), number(Y), !, Z is X + Y.
s(+, X + Y, W, X + Z) :- number(Y), number(W), !, Z is Y + W.
s(+, X + Y, W, Y + Z) :- number(X), number(W), !, Z is X + W.
s(+, X, Y, X + Y).
s(*, _, 0, 0).
s(*, 0, _, 0).
s(*, 1, X, X) :- \+ number(X), !.
s(*, X, 1, X) :- \+ number(X), !.
s(*, X, Y, Z) :- number(X), number(Y), !, Z is X * Y.
s(*, X * Y, W, X * Z) :- number(Y), number(W), !, Z is Y * W.
s(*, X * Y, W, Y * Z) :- number(X), number(W), !, Z is X * W.
s(*, X, Y, X * Y).