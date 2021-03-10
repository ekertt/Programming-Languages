/**
 * Naam + Studentnummer: Tim van Ekert, 13635565
 * Studie: Pre master Software Engineering, Doorstroomminor HvA
 * 
 * Dit bestand bestaat uit predikaten die het kortste met betrekking tot de kosten van de paden kan berekenen.
 */

% Consulten van de graph data uit "graph.pl" en van de solution van de eerste opdracht
:- consult('graph.pl').
:- consult('solution1.pl').

% Deze functie checkt recursief wat de prijs is binnen the paths. Hierin word elke keer de head eraf gehaald en de tail recursief
% teruggestuurd. De head word bij de tail opgeteld en dit word aan de Cost toegevoegd.
cost([], 0).
cost([Head | Tail], Cost) :-
    Head = edge(_, _, CostHead),
    cost(Tail, CostTail),
    Cost is CostHead + CostTail.

% Deze functie berekent het kortste pad uit de lijst die is gevonden, dit gebeurt door een findall op alle paden
% en bijbehorden kosten. Vervolgens word die gesorteerd op weinig naar veel kosten en word de head van die list gepakt.
shortestPath(From, To, ShortestPath) :-
    findall( (Cost, Path), (path(From,To,Path), cost(Path, Cost)), ShortestPaths),
    sort(ShortestPaths, ResultPath),
    ResultPath = [(_, ShortestPath)|_].