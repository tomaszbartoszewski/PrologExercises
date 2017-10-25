event(1505, ['Euclid',translated,into,'Latin']).
event(1510, ['Reuchlin-Pfefferkorn',controversy]).
event(1523, ['Christian','II',flees,from,'Denmark']).

when(X,Y) :- event(Y,Z), member(X,Z).

hello1(Event) :- read(Date), event(Date,Event).

% prettyprint([a,[b,f,g,[ert,w]],c,v],0).

spaces(0) :- !.
spaces(N) :- write(' '), N1 is N - 1, spaces(N1).

pp([H|T], I) :- !, J is I + 3, pp(H,J), prettyprint(T,J).
pp(X, I) :- spaces(I), write(X), nl.

prettyprint([],_).
prettyprint([H|T], I) :- pp(H,I), prettyprint(T,I).

% pretty history headline
% event(_,L), member('Denmark',L), phh(L).

phh([]) :- nl.
phh([H|T]) :- write(H), spaces(1), phh(T).

% write(a+b*c*c), nl, write_canonical(a+b*c*c), nl.

% full program
% hello2.

hello2 :-
    phh(['What',date,do,you,'desire?']),
    read(D),
    event(D,S),
    phh(S).

% check_line(X).
% for input containing qw or cv it will say X = no

check_line(OK) :-
    get_char(X),
    rest_line('\n', X, OK).

rest_line(_, '\n', yes) :- !.

rest_line(Last, Current, no) :-
    typing_error(Last, Current), !,
    get_char(New),
    rest_line(Current,New,_).

rest_line(_, Current, OK) :-
    get_char(New),
    rest_line(Current,New,OK).

typing_error('q','w').
typing_error('c','v').


% correct_line.
% with asdqwwwfgfccvv. will return asdqqqqfgfcccc.
% I display Last when it had correction, not like in book

correct_line :-
    get_char(X),
    correct_rest_line('\n', X).

correct_rest_line(C, '\n') :- !,
    put_char(C), nl.

correct_rest_line(Last, Current) :-
    typing_correction(Last, Current, Corr), !,
    put_char(Last),
    get_char(New),
    correct_rest_line(Corr,New).

correct_rest_line(Last, Current) :-
    put_char(Last),
    get_char(New),
    correct_rest_line(Current,New).

typing_correction('q','w','q').
typing_correction('c','v','c').