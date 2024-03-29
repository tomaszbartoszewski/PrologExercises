% repeat, random(10, X), write(X), nl, X = 5.

:- dynamic seed/1.
seed(13).
random(R, N) :-
    retract(seed(S)),
    N is (S mod R) + 1,
    NewSeed is (125 * S + 1) mod 4096,
    asserta(seed(NewSeed)), !.


% gensym(student, A), gensym(teacher, B), gensym(teacher, C),
%   gensym(student, D), gensym(student, E), gensym(teacher, F).

:- dynamic current_num/2.

gensym(Root, Atom) :-
    get_num(Root, Num),
    atom_chars(Root, Name1),
    number_chars(Num, Name2),
    append(Name1, Name2, Name),
    atom_chars(Atom, Name).

get_num(Root, Num) :-
    retract(current_num(Root, Num1)), !,
    Num is Num1 + 1,
    asserta(current_num(Root, Num)).

get_num(Root, 1) :- asserta(current_num(Root, 1)).


% findallLocal(X, test(X, zzz), L).
% findallLocal(X, test(X, Y), L).

test(aaa, zzz).
test(bbb, zzz).
test(ccc, zzz).
test(ddd, zzz).
test(eee, zzz).
test(fff, yyy).

:- dynamic found/1.

findallLocal(X, G, _) :-
    asserta(found(mark)),
    call(G),
    asserta(found(result(X))),
    fail.
findallLocal(_, _, L) :- collect_found([], M), !, L = M.

collect_found(S, L) :-
    getnext(X),
    !,
    collect_found([X|S], L).

collect_found(L, L).

getnext(Y) :- retract(found(X)), !, X = result(Y).


% random_pick([1,2,3,4,5,6,7], E).

random_pick(L, E) :-
    length(L, Length),
    random(Length, Position),
    getElement(L, Position, E).

getElement([H|_], 1, H) :- !.
getElement([_|T], Position, Result) :-
    NewPosition is Position - 1,
    getElement(T, NewPosition, Result).