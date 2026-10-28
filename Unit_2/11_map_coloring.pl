/* Practical 11: Australia map-coloring CSP using plain backtracking.
   Variables: seven regions. Domain: red, green, blue.
   Constraint: regions sharing a border must have different colors.
   Tasmania has no land border with the other regions in this model.
   Example: map_coloring(Assignment). Press ; for more solutions.
*/
:- module(map_coloring, [color/1, adjacent/2, map_coloring/1, demo/0]).

color(red). color(green). color(blue).

% Each undirected border is recorded once.
adjacent(wa, nt). adjacent(wa, sa).
adjacent(nt, sa). adjacent(nt, q).
adjacent(sa, q). adjacent(sa, nsw). adjacent(sa, v).
adjacent(q, nsw). adjacent(nsw, v).

map_coloring(Assignment) :-
    assign_regions([wa, nt, sa, q, nsw, v, t], [], Assignment).

assign_regions([], _, []).
assign_regions([Region|Regions], Assigned, [Region-Color|Rest]) :-
    color(Color), compatible(Region, Color, Assigned),
    assign_regions(Regions, [Region-Color|Assigned], Rest).

compatible(_, _, []).
compatible(Region, Color, [Other-OtherColor|Rest]) :-
    ( (adjacent(Region, Other); adjacent(Other, Region)) -> Color \= OtherColor
    ; true
    ),
    compatible(Region, Color, Rest).

demo :-
    once(map_coloring(Assignment)),
    writeln('One valid Australia map coloring:'),
    forall(member(Region-Color, Assignment), format('  ~w: ~w~n', [Region, Color])).
