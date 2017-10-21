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



fuel_consumed(waster, [3.1, 10.4, 15.9, 10.3]).
fuel_consumed(guzzler, [3.2, 9.9, 13.0, 11.6]).
fuel_consumed(prodigal, [2.8, 9.8, 13.1, 10.4]).

equal_or_better_consumption(Good, Bad) :-
        Threshold is (Good + Bad) / 40,
        Worst is Bad + Threshold,
        Good < Worst.

prefer(Car1, Car2) :-
        fuel_consumed(Car1, Con1),
        fuel_consumed(Car2, Con2),
        always_better(Con1, Con2).

always_better([], []).
always_better([H1|T1], [H2|T2]) :- equal_or_better_consumption(H1, H2), always_better(T1, T2).

prefer_sometimes(Car1, Car2) :-
        fuel_consumed(Car1, Con1),
        fuel_consumed(Car2, Con2),
        sometimes_better(Con1, Con2).

sometimes_better([H1|_], [H2|_]) :-
        significantly_better(H1, H2).
sometimes_better([_|T1], [_|T2]) :-
        sometimes_better(T1, T2).

significantly_better(Good, Bad) :-
        Threshold is (Good + Bad) / 40,
        BetterThan is Bad - Threshold,
        Good < BetterThan.