/* Practical 9: Steepest-ascent hill climbing for numerical optimization.
   Maximize score(X) on the discrete integer domain 0..10.
   Neighbours are X-1 and X+1 within the domain.
   Local maximum: X=3, score=8. Global maximum: X=9, score=13.
   Example: hill_climb(0, Best, Score, Trace). % 3, 8, [0,1,2,3]
*/
:- module(hill_climbing, [score/2, neighbour/2, hill_climb/4, demo/0]).

score(0, 0). score(1, 2). score(2, 5). score(3, 8).
score(4, 6). score(5, 4). score(6, 5). score(7, 7).
score(8, 10). score(9, 13). score(10, 11).

neighbour(X, Next) :- Next is X - 1, score(Next, _).
neighbour(X, Next) :- Next is X + 1, score(Next, _).

hill_climb(Start, Best, BestScore, Trace) :-
    integer(Start), score(Start, _), climb(Start, Best, BestScore, Trace).

climb(Current, Best, BestScore, [Current|Rest]) :-
    score(Current, CurrentScore),
    findall(Value-Next, (neighbour(Current, Next), score(Next, Value)), Options),
    keysort(Options, Sorted), last(Sorted, NextScore-Next),
    ( NextScore > CurrentScore -> climb(Next, Best, BestScore, Rest)
    ; Best = Current, BestScore = CurrentScore, Rest = []
    ).

demo :-
    hill_climb(0, Best, Value, Trace),
    format('Visited states: ~w~nLocal optimum: x=~w, score=~w~n', [Trace, Best, Value]),
    writeln('Strict improvements cannot cross the valley to the global maximum at x=9.').
