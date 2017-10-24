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

% tic tac toe
% forced_move(b(x,x,e,e,e,e,e,e,e)). % true
% forced_move(b(x,e,e,e,e,e,e,e,e)). % false
% forced_move(b(x,e,e,e,x,e,e,e,e)). % true

line(b(X,Y,Z,_,_,_,_,_,_), X, Y, Z).
line(b(_,_,_,X,Y,Z,_,_,_), X, Y, Z).
line(b(_,_,_,_,_,_,X,Y,Z), X, Y, Z).
line(b(X,_,_,Y,_,_,Z,_,_), X, Y, Z).
line(b(_,X,_,_,Y,_,_,Z,_), X, Y, Z).
line(b(_,_,X,_,_,Y,_,_,Z), X, Y, Z).
line(b(X,_,_,_,Y,_,_,_,Z), X, Y, Z).
line(b(_,_,X,_,Y,_,Z,_,_), X, Y, Z).

forced_move(Board) :-
    line(Board, X, Y, Z),
    threatening(X, Y, Z),
    !.

threatening(e,x,x).
threatening(x,e,x).
threatening(x,x,e).


% divide

divide(N1, N2, Result) :-
    is_int(Result),
    Product1 is Result * N2,
    Product2 is (Result + 1) * N2,
    Product1 =< N1, N1 < Product2,
    !.

% problems with cut

% append([a,b,c],[d,e],X). % works
% append([a,b,c],Y,X). % works
% append(Y,X,[a,b,c]). % gives only one option

append([], X, X) :- !.
append([A|B], C, [A|D]) :- append(B, C, D).

% number_of_parents(adam,X). % 0
% number_of_parents(adam,2). % true

number_of_parents(adam, 0) :- !.
number_of_parents(eve, 0) :- !.
number_of_parents(_, 2).

% to fix it
number_of_parents2(adam, N) :- !, N = 0.
number_of_parents2(eve, N) :- !, N = 0.
number_of_parents2(_, 2).

% that one will even work with number_of_parents3(X,0).
number_of_parents3(adam, 0).
number_of_parents3(eve, 0).
number_of_parents3(X, 2) :- \+(X=adam), \+(X=eve).

% all will still fail number_of_parents(X,Y). - first two only adam 0, third adam 0, eve 0 but nothing else