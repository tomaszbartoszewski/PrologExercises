male(albert).
male(edward).
female(alice).
female(victoria).
parents(edward, victoria, albert).
parents(alice, victoria, albert).
sister_of(X,Y) :- female(X), parents(X,M,F), parents(Y,M,F), X\=Y.

sum([], 0).
sum([H|T], S) :- sum(T, Res), S is H + Res.

reverse([H|T],Acc, Result) :- reverse(T, [H|Acc], Result).
reverse([],Item,Item).