% d(x+1, x, X).
% d(x*x-2, x, X).
% d(x^3, x, X).
% d(x^3+x^2, x, X).

?- op(300, yfx, ^).

d(X, X, 1) :- !.
d(C, _, 0) :- atomic(C).
d(-U, X, -A) :- d(U, X, A).
d(U+V, X, A+B) :- d(U, X, A), d(V, X, B).
d(U-V, X, A-B) :- d(U, X, A), d(V, X, B).
d(C*U, X, C*A) :- atomic(C), \+ C = X, d(U, X, A), !.
d(U*V, X, B*U+A*V) :- d(U, X, A), d(V, X, B).
d(U/V, X, A) :- d(U*V^(-1), X, A).
d(U^C, X, C*U^(C-1)*W) :- atomic(C), \+ C = X, d(U, X, W).
d(log(U), X, A*U^(-1)) :- d(U, X, A).