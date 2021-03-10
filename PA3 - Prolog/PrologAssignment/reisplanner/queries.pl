/**
 * Naam + Studentnummer: Tim van Ekert, 13635565
 * Studie: Pre master Software Engineering, Doorstroomminor HvA
 * 
 * Dit is een queries testklasse, die alle vragen voor in het verslag 
 * beantwoord doormiddel van het gebruik van deze queries.
 */

% Query 1: Welke paden zijn er van 1 naar 3, van 3 naar 5 en van 5 naar 4?
query1() :- consult(solution1),
    writeln("Query 1"),
    findall(Path1, path(1,3,Path1), List1),
    writeln("paths 1..3:"),
    writeln(List1),
    findall(Path2, path(3,5,Path2), List2),
    writeln("paths 3..5:"),
    writeln(List2),
    findall(Path3, path(5,4,Path3), List3),
    writeln("paths 5..4:"),
    writeln(List3).

% Query 2: Wat zijn de kosten van ieder pad van 5 naar 4 om deze te bewandelen
query2() :- consult(solution2),
    writeln("Query 2"),
    findall(Path, path(5, 4, Path), List),
    writeln("Costs path 5 to 4:"),
    writeln(List).

% Query 3: Wat zijn de kortste paden van 1 naar 3, van 3 naar 5 en van 5 naar 4?
query3() :- consult(solution2),
    writeln("Query 3"),
    shortestPath(1,3, Path),
    writeln("Shortest 1..3:"),
    writeln(Path2),
    shortestPath(3,5, Path1),
    writeln("Shortest 3..5:"),
    writeln(Path3),
    shortestPath(5,4, Path2),
    writeln("Shortest 5..4:"),
    writeln(Path4).

% Query 4: Hoeveel minuten kost het om van Amsterdam Amstel naar Sittard te reizen?
query4() :- consult(solution3),
    writeln("Query 4"),
    shortestPath("Amsterdam Amstel" at _, "Sittard" at _, Path),
    cost(Path, Cost),
    writeln(Cost).

% Query 5: ussen ’s-Hertogenbosch en Eindhoven zijn er werkzaamheden.
% Er worden bussen ingezet tussen deze twee stations.De busvertrekt vijf minuten na de aankomsttijd,
% en de rit duurt zo’ndertig minuten. Hoeveel minuten kost hetom van AmsterdamCentraal naar Maastricht te gaan?
query5() :- consult(solution3),
    writeln("Query 5"),
    path("Amsterdam Centraal" at _, "'s-Hertogenbosch" at _, Path1),
    path("Eindhoven" at _, "Maastricht" at _,  Path2),
    cost(Path1, Cost1),
    cost(Path2, Cost2),
    TotalCost is Cost1 + Cost2 + 35,
    write(TotalCost).

:- query1.
:- query2.
:- query3. 
:- query4. 
:- query5. 