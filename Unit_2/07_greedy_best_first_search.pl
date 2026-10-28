/* Practical 7: Greedy Best-First Search on a directed weighted graph.
   Priority = h(Node); accumulated cost does not affect expansion order.
   The heuristic facts estimate cost to g, the fixed goal of this example.
   Example: greedy_search(a, g, Path, Cost). % [a,c,e,g], 10
*/
:- module(greedy_best_first_search,
          [edge/3, heuristic/2, greedy_search/4, demo/0]).

edge(a, b, 1). edge(a, c, 6).
edge(b, d, 2). edge(b, e, 7).
edge(c, e, 1).
edge(d, g, 6). edge(e, g, 3).

heuristic(a, 7). heuristic(b, 6). heuristic(c, 4).
heuristic(d, 4). heuristic(e, 2). heuristic(g, 0).

greedy_search(Start, g, Path, Cost) :-
    heuristic(Start, H),
    greedy_queue([H-state(Start, [Start], 0)], [], Reverse, Cost),
    reverse(Reverse, Path).

greedy_queue([_-state(g, Path, Cost)|_], _, Path, Cost) :- !.
greedy_queue([_-state(Node, Path, G)|Rest], Closed, Result, Cost) :-
    ( memberchk(Node, Closed) ->
        greedy_queue(Rest, Closed, Result, Cost)
    ; findall(H-state(Next, [Next|Path], NewG),
              (edge(Node, Next, Weight), \+ memberchk(Next, [Node|Closed]),
               heuristic(Next, H), NewG is G + Weight), Children),
      append(Rest, Children, Candidates),
      keysort(Candidates, Open),
      greedy_queue(Open, [Node|Closed], Result, Cost)
    ).

demo :-
    greedy_search(a, g, Path, Cost),
    format('Greedy path: ~w~nCost: ~w~n', [Path, Cost]),
    writeln('Greedy uses only h(n); this graph has a cheaper path of cost 9.').
