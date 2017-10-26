% zed is_dead.
:- op(500, xf, is_dead).
 
kill(marsellus,zed).
is_dead(X) :- kill(_,X).


% A is (2 func 3) func (4 func (2+1))
:- op(500,yfx,func).
:- arithmetic_function(func/2).

func(X, Y, Z) :- 
    Z is X + Y.


% A is 12 celsiusToKelvin kelvinToCelsius.
% A is 0 kelvinToCelsius celsiusToFahrenheit.

:- op(500,yf,celsiusToKelvin).
:- arithmetic_function(celsiusToKelvin/1).

celsiusToKelvin(X, Y) :- Y is X + 273.15.

:- op(500,yf,kelvinToCelsius).
:- arithmetic_function(kelvinToCelsius/1).

kelvinToCelsius(X, Y) :- Y is X - 273.15.

:- op(500,yf,celsiusToFahrenheit).
:- arithmetic_function(celsiusToFahrenheit/1).

celsiusToFahrenheit(X, Y) :- Y is X * 1.8 + 32.