% list1(test(_)).
% list1(test2).

list1(X) :-
    clause(X, Y),
    output_clause(X, Y), write('.'), nl, fail.
list1(_).

output_clause(X, true) :- !, write(X).
output_clause(X, Y) :- write((X :- Y)).

test(a) :- test(b).
test(b).
test2.


% quine.

quine :-
    clause(quine, A),
    portray_clause((quine:-A)).


% interpret(test_int(_)).

interpret(true) :- !.
interpret((G1, G2)) :- !, interpret(G1), interpret(G2).
interpret(Goal) :-
    clause(Goal, MoreGoals), interpret(MoreGoals).

test_int(a) :- test_int(b).
test_int(b) :- test_int(c).
test_int(c).
test_int(d).