reigns(rhodri, 844, 878).
reigns(anarawd, 878, 916).
reigns(hywel_dda, 916, 950).
reigns(lago_ap_idwal, 950, 979).

reigns(hywel_ap_ieuaf, 979, 985).
reigns(cadwallon, 985, 986).
reigns(maredudd, 986, 999).

prince(X, Y) :-
    reigns(X, B, E),
    Y >= B,
    Y =< E.

pop(usa, 203).
pop(india, 548).
pop(china, 800).
pop(brazil, 108).

area(usa, 3).
area(india, 1).
area(china, 4).
area(brazil, 3).

density(X, Y) :-
    pop(X, P),
    area(X, A),
    Y is P/A.


sum(A, B, R) :- R is +(A, B).

book('The Three Musketeers', author(alexandre, dumas)).
book('The Count of Monte Cristo', author(alexandre, dumas)).