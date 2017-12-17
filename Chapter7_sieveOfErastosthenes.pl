% primes(100, Ps).

primes(Limit, Ps) :-
    integers(2, Limit, Is),
    sift(Is, Ps).

integers(Low, High, [Low|Rest]) :-
    Low =< High,
    !,
    M is Low + 1,
    integers(M, High, Rest).
integers(_, _, []).

sift([], []).
sift([I|Is], [I|Ps]) :-
    remove(I, Is, New),
    sift(New, Ps).

remove(_, [], []).
remove(P, [I|Is], [I|Nis]) :-
    \+ 0 is I mod P,
    !,
    remove(P, Is, Nis).
remove(P, [I|Is], Nis) :-
    0 is I mod P,
    !,
    remove(P, Is, Nis).


% primes2(100, Ps).

primes2(Limit, Ps) :-
    integers(2, Limit, Is),
    primes_imp(Is, [], Ps).

primes_imp([], P, P).
primes_imp([H|T], P, Z) :-
    legal(H, P),
    !,
    primes_imp(T, [H|P], Z).
primes_imp([_|T], P, Z) :- primes_imp(T, P, Z).

legal(_, []).
legal(X, [H|_]) :-
    0 is X mod H,
    !,
    fail.
legal(X, [_|T]) :- legal(X, T).


% gcd(65, 15, K).
gcd(I, 0, I) :- !.
gcd(I, J, K) :- R is I mod J, gcd(J, R, K).

% lcm(65, 15, K).
lcm(I, J, K) :- gcd(I, J, R), K is (I * J) // R.