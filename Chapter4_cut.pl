% is_int(X). is in ascending order
is_int(0).
is_int(X) :- is_int(Y), X is Y+1.

% member(a, X).
member(X, [X|_]).
member(X, [_|Y]) :- member(X, Y).

% client(X), facility(X, Y).
facility(Pers, Fac) :-
    book_overdue(Pers, _),
    !,
    basic_facility(Fac).
facility(_, Fac) :- general_facility(Fac).

basic_facility(reference).
basic_facility(enquiries).

additional_facility(borrowing).
additional_facility(inter_library_loan).

general_facility(X) :- basic_facility(X).
general_facility(X) :- additional_facility(X).

client('A. Jones').
client('W. Metesk').

book_overdue('C. Watzer', book10089).
book_overdue('A. Jones', book29907).

% different sums with cut
sum_to(1,1) :- !.
sum_to(N, Res) :-
    N1 is N-1,
    sum_to(N1, Res1),
    Res is Res1+N.

sum_to2(N, 1) :- N =< 1, !.
sum_to2(N, R) :-
    N1 is N-1,
    sum_to2(N1, R1),
    R is R1+N.

sum_to3(1, 1).
sum_to3(N, R) :-
    \+(N = 1), % N \= 1,
    N1 is N-1,
    sum_to3(N1, R1),
    R is R1+N.

sum_to4(N, 1) :- N =< 1.
sum_to4(N, R) :-
    \+(N =< 1), % N > 1,
    N1 is N-1,
    sum_to4(N1, R1),
    R is R1+N.

