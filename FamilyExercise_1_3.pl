father(john, peter).
father(max, john).
father(george, alice).
father(george, anna).

mother(alice, peter).
mother(kate, anna).
mother(kate, alice).

male(john).
male(peter).
male(max).
male(george).

female(kate).
female(alice).
female(anna).

parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).

diff(X, Y) :- X\=Y.

is_mother(X) :- mother(X, _).
is_father(X) :- father(X, _).
is_son(X) :- male(X), parent(_,X),!.
sibling(X,Y) :- father(F, X), father(F, Y), mother(M, X), mother(M, Y), diff(X,Y).
sister_of(X,Y) :- female(X), sibling(X,Y).
grandpa_of(X,Y) :- father(X,Z), parent(Z,Y), !.
aunt(X,Y) :- sister_of(X,Z),parent(Z,Y).