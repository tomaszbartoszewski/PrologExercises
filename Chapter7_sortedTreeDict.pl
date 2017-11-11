% X = w(massinga,858,w(braemar, 385, w(adela,588,_,_),_),w(panorama,158,w(nettleweed,579,_,_),_)), lookup(adela,X,R).
% lookup(abaris, X, 582), lookup(maloja, X, 356).
% lookup(massinga,X,858), lookup(braemar, X, 385), lookup(nettleweed, X, 579), lookup(panorama, X, 158).
% lookup(adela, X, 588), lookup(braemar, X, 385), lookup(nettleweed, X, 579), lookup(massinga,X,858).

lookup(H, w(H,G,_,_),G1) :- !, G=G1.
lookup(H, w(H1,_,Before,_),G) :- H @< H1, lookup(H,Before,G).
lookup(H, w(H1,_,_,After),G) :- H @> H1, lookup(H,After,G).