add() :-
  write('type first value:'),
  nl,
  read(X),
  write('type second value:'),
  nl,
  read(Y),
  R is X+Y,
  write(R).