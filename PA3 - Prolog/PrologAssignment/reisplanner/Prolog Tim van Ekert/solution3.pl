/**
 * Naam + Studentnummer: Tim van Ekert, 13635565
 * Studie: Pre master Software Engineering, Doorstroomminor HvA
 * 
 * Dit bestand bestaat uit predikaten die de reistijden integreert binnen de kortste paden naar het eindpunt.
 */

:- consult('route.pl').

path(From, To, Path) :-
    travel(From, To, [], Path).

% Deze functie is al een tussenstap, hier roept hij de travel functie aan die
% dezelfde argumenten meegeeft + een lege array. Deze lege lijst wordt gevuld met alle
% bezochtte paden.
travel(From, To, Visited, Path) :-
    edge(From, X, Cost),
    \+ (member(travel(X, _, _), Visited)),
    \+ (member(travel(_, X, _), Visited)),
    VisitedValue = [travel(From, X, Cost)|Visited],
    ( X = To -> reverse(VisitedValue, Path) ; travel(X, To, VisitedValue, Path) ).

% Deze functie checkt recursief wat de prijs is binnen the paths. Hierin word elke keer de head eraf gehaald en de tail recursief
% teruggestuurd. De head word bij de tail opgeteld en dit word aan de Cost toegevoegd.
cost([], 0).
cost([Head | Tail], Cost) :-
    Head = travel(_, _, CostHead),
    cost(Tail, CostTail),
    Cost is CostHead + CostTail.

% Deze functie berekent het kortste pad uit de lijst die is gevonden, dit gebeurt door een findall op alle paden
% en bijbehorden kosten. Vervolgens word die gesorteerd op weinig naar veel kosten en word de head van die list gepakt.
shortestPath(From, To, ShortestPath) :-
    findall( (Cost, Path), (path(From,To,Path), cost(Path, Cost)), ShortestPaths),
    sort(ShortestPaths, ResultPath),
    ResultPath = [(_, ShortestPath)|_],

    ShortestPath = [ travel(From, _ at _ , _)|_],
    reverse(ShortestPath, ReverseSPath),
    ReverseSPath = [ travel(_ at _, To, _)|_].

% Een edge bestaat als er een route is, de functie daarna wordt gecalled samen met de route
edge(From,To, Cost) :-
    route(Route),
    findCorrectEdge(From, To, Cost, Route).

% Deze functie checkt de twee naburige knopen en berekent het tijdsverschil hiertussen.
% De waarde word opgeslagen in Time en roept de abs function aan om dit nummer 
% altijd absoluut te laten zijn (had wat problemen met - waardes aan het begin).
findCorrectEdge(From at TimeStart, To at TimeEnd, Time, Route) :-
    nextto( From at TimeStart,
            To at TimeEnd,
            Route
          ),
    diffTime( TimeStart, TimeEnd, Minutes),
    Time is abs(Minutes).

% Deze functie berekent het verschil in tijd in minuten.
diffTime(H1:M1, H0:M0, Minutes):-
    Minutes is ((H1 * 60) + M1) - ((H0 * 60) + M0).