% partsof(bike, X).
% partsof(wheel, X).

basicpart(rim).
basicpart(spoke).
basicpart(rearframe).
basicpart(handles).
basicpart(gears).
basicpart(bolt).
basicpart(nut).
basicpart(fork).

assembly(bike, [wheel, wheel, frame]).
assembly(wheel, [spoke, rim, hub]).
assembly(frame, [rearframe, frontframe]).
assembly(frontframe, [fork, handles]).
assembly(hub, [gears, axle]).
assembly(axle, [bolt, nut]).

partsof(X, [X]) :- basicpart(X).
partsof(X, P) :-
    assembly(X, Subparts),
    partsoflist(Subparts, P).

partsoflist([], []).
partsoflist([P|Tail], Total) :-
    partsof(P, Headparts),
    partsoflist(Tail, Tailparts),
    append(Headparts, Tailparts, Total).


% language example
% lang_partsof(sentence, X).

lang_assembly(sentence, [noun_phrase, verb_phrase]).
lang_assembly(noun_phrase, [determiner, noun]).
lang_assembly(verb_phrase, [verb, determiner, noun]).

lang_assembly(verb, [is]).
lang_assembly(determiner, [the]).
lang_assembly(determiner, [a]).
lang_assembly(noun, [apple]).
lang_assembly(noun, [fruit]).

lang_basicpart(apple).
lang_basicpart(fruit).
lang_basicpart(the).
lang_basicpart(a).
lang_basicpart(is).


lang_partsof(X, [X]) :- lang_basicpart(X).
lang_partsof(X, P) :-
    lang_assembly(X, Subparts),
    lang_partsoflist(Subparts, P).

lang_partsoflist([], []).
lang_partsoflist([P|Tail], Total) :-
    lang_partsof(P, Headparts),
    lang_partsoflist(Tail, Tailparts),
    append(Headparts, Tailparts, Total).

% two ways of counting list length

listlen([], 0).
listlen([_|T], N) :- listlen(T, N1), N is N1+1.

listlen_acc(L, N) :- lenacc(L, 0, N).
lenacc([], A, A).
lenacc([_|T], A, N) :- A1 is A+1, lenacc(T, A1, N).

% bike without append - difference lists
% compare time(d_partsof(bike, X)). with time(partsof(bike, X)).

d_partsof(X, P) :- d_partsacc(X, P, []).
d_partsacc(X, [X|Hole], Hole) :- basicpart(X).
d_partsacc(X, P, Hole) :-
    assembly(X, Subparts),
    d_partsacclist(Subparts, P, Hole).

d_partsacclist([], Hole, Hole).
d_partsacclist([P|T], Total, Hole) :-
    d_partsacc(P, Total, Hole1),
    d_partsacclist(T, Hole1, Hole).