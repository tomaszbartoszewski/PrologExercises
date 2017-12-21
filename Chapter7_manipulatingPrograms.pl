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



% asserta(testx), asserta(testx :- testy), list1(testx).
% retractall_imp(testx), list1(testx).

retractall_imp(X) :- retract(X), fail.
retractall_imp(X) :- retract((X :- _)), fail.
retractall_imp(_).


%consult_imp(File) :-
%    retractall(done(_)),
%    current_input(Old),
%    open(File, read, Stream),
%    repeat,
%    read(Term),
%    try(Term),
%    close(Stream),
%    set_input(Old),
%    !.
%
%try(end_of_file) :- !.
%try((?- Goals)) :- call(Goals), !, fail.
%try((:- _)) :- !.
%try(Clause) :-
%    head(Clause, Head),
%    record_done(Head),
%    assertz(Clause),
%    fail.
%
%:- dynamic done/1.
%
%record_done(Head) :- done(Head), !.
%record_done(Head) :-
%    functor(Head, Func, Arity),
%    functor(Proc, Func, Arity),
%    asserta(done(Proc)),
%    retractall(Proc),
%    !.
%
%head((A :- _), A) :- !.
%head(A, A).