/* Practical 6: BFS shortest path in a directed, unweighted graph.
   Example: bfs(a, f, Path). % Path = [a,b,d,f]
   A FIFO queue expands paths by increasing edge count.
*/
:- module(breadth_first_search, [node/1, edge/2, bfs/3, demo/0]).

node(a). node(b). node(c). node(d). node(e). node(f). node(isolated).
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, e).
edge(d, f).
edge(e, f).
edge(e, a). % Cycle: the visited set prevents infinite traversal.

bfs(Start, Goal, Path) :-
    node(Start), node(Goal), bfs_queue([[Start]], [Start], Goal, Reversed),
    reverse(Reversed, Path).

bfs_queue([[Goal|Rest]|_], _, Goal, [Goal|Rest]) :- !.
bfs_queue([[Current|Rest]|Queue], Visited, Goal, Path) :-
    findall(Next, (edge(Current, Next), \+ memberchk(Next, Visited)), Raw),
    sort(Raw, Neighbours),
    findall([Next,Current|Rest], member(Next, Neighbours), NewPaths),
    append(Queue, NewPaths, NewQueue),
    append(Neighbours, Visited, NewVisited),
    bfs_queue(NewQueue, NewVisited, Goal, Path).
% An empty queue has no matching clause: an unreachable goal fails.

demo :-
    bfs(a, f, Path), length(Path, Nodes), Edges is Nodes - 1,
    format('Shortest path: ~w~nNumber of edges: ~w~n', [Path, Edges]).
