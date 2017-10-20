test(Item1, Item2, '[|]'(Item1, Item2)). % '.' from ISO Prolog is '[|]'

member(X, [X|_]).
member(X, [_|T]) :- member(X,T).

% that will throw exception islist(X).
islist([_|B]) :- islist(B).
islist([]).

% that will work for weak_islist(X).
weak_islist([]).
weak_islist([_|_]).


% unit tests
:- begin_tests(member).

test(member_available) :-
        member(a, [b,a]), !.

test(member_the_only_item) :-
        member(a, [a]), !.

test(not_on_list, fail) :-
        member(a, [b,c]).

:- end_tests(member).


% alter([you, are, a, computer], X).
change(you, i).
change(are, [am,not]).
change(do, no).
change(french, german).
change(H, H).

alter([],[]).
alter([H|T], [HNew|TNew]) :- change(H, HNew), alter(T, TNew).