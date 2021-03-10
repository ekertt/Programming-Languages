/**
 * Naam + Studentnummer: Tim van Ekert, 13635565
 * Studie: Pre master Software Engineering, Doorstroomminor HvA
 * 
 * Dit bestand bestaat uit predikaten die een pad tussen twee knopen kunnen berekenen
 */

:- consult('graph.pl').

% Deze functie is al een tussenstap, hier roept hij de travel functie aan die
% dezelfde argumenten meegeeft + een lege array. Deze lege lijst wordt gevuld met alle
% bezochtte paden.
path(From, To, Path) :-
    travel(From, To, [], Path).

% Deze functie is al een tussenstap, hier roept hij de travel functie aan die
% dezelfde argumenten meegeeft + een lege array. Deze lege lijst wordt gevuld met alle
% bezochtte paden.
travel(From, To, Visited, Path) :-
    edge(From, X, Cost),
    \+ (member(edge(X, _, _), Visited)),
    \+ (member(edge(_, X, _), Visited)),
    VisitedValue = [edge(From, X, Cost)|Visited],
    ( X = To -> reverse(VisitedValue, Path) ; travel(X, To, VisitedValue, Path) ).