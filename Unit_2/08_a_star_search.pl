/* Practical 8: A* search; priority f(n) = g(n) + h(n).
   Same directed graph as Practical 7; h estimates cost to the fixed goal g.
   All weights are positive; h is admissible and h(g)=0.
   A better g-value reopens a node, supporting inconsistent admissible h.
   Example: a_star(a, g, Path, Cost). % [a,b,d,g], 9
*/
:- module(a_star_search, [edge/3, heuristic/2, a_star/4, demo/0]).

edge(a, b, 1). edge(a, c, 6).
edge(b, d, 2). edge(b, e, 7).
edge(c, e, 1).
edge(d, g, 6). edge(e, g, 3).

heuristic(a, 7). heuristic(b, 6). heuristic(c, 4).
heuristic(d, 4). heuristic(e, 2). heuristic(g, 0).

a_star(Start, g, Path, Cost) :-
    heuristic(Start, H),
    astar_queue([H-state(Start, [Start], 0)], [Start-0], Reverse, Cost),
    reverse(Reverse, Path).

astar_queue([_-state(Node, Path, G)|Rest], Best, Result, Cost) :-
    memberchk(Node-BestG, Best),
    ( G > BestG -> astar_queue(Rest, Best, Result, Cost)
    ; Node == g -> Result = Path, Cost = G
    ; findall(Next-Weight, edge(Node, Next, Weight), Edges),
      relax(Edges, Path, G, Best, UpdatedBest, Children),
      append(Rest, Children, Candidates), keysort(Candidates, Open),
      astar_queue(Open, UpdatedBest, Result, Cost)
    ).

relax([], _, _, Best, Best, []).
relax([Next-Weight|Edges], Path, G, Best0, Best, Children) :-
    NewG is G + Weight,
    ( memberchk(Next-OldG, Best0), NewG >= OldG ->
        Best1 = Best0, Children = Tail
    ; update_best(Next, NewG, Best0, Best1),
      heuristic(Next, H), F is NewG + H,
      Children = [F-state(Next, [Next|Path], NewG)|Tail]
    ),
    relax(Edges, Path, G, Best1, Best, Tail).

update_best(Node, G, [], [Node-G]).
update_best(Node, G, [Node-_|Rest], [Node-G|Rest]) :- !.
update_best(Node, G, [Pair|Rest], [Pair|Updated]) :-
    update_best(Node, G, Rest, Updated).

demo :-
    a_star(a, g, Path, Cost),
    format('A* optimal path: ~w~nCost: ~w~n', [Path, Cost]).
