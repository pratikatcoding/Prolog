/* Practical 10: Simulated annealing versus hill climbing.
   Uses the same discrete objective as Practical 9 (shared by module import).
   Maximize score: accept an improvement; otherwise accept with exp(Delta/T).
   Geometric cooling: next T = T * Cooling. Return best state ever visited.
   Example: set_random(seed(42)), anneal(0, 5.0, 0.995, 2000, X, Score).
*/
:- module(simulated_annealing, [anneal/6, compare_algorithms/3, demo/0]).
:- use_module(library(random)).
:- use_module('09_hill_climbing.pl', [score/2, neighbour/2, hill_climb/4]).

% anneal(+Start, +Temperature, +Cooling, +Steps, -Best, -BestScore).
anneal(Start, Temperature, Cooling, Steps, Best, BestScore) :-
    integer(Start), score(Start, Value),
    number(Temperature), Temperature > 0,
    number(Cooling), Cooling > 0, Cooling < 1,
    integer(Steps), Steps >= 0,
    anneal_loop(Steps, Temperature, Cooling, Start, Value, Start, Value, Best, BestScore).

anneal_loop(Steps, T, Cooling, Current, Value, Best0, Score0, Best, BestScore) :-
    ( (Steps =:= 0 ; T < 1.0e-12) -> Best = Best0, BestScore = Score0
    ; findall(N, neighbour(Current, N), Neighbours),
      random_member(Candidate, Neighbours), score(Candidate, CandidateScore),
      Delta is CandidateScore - Value,
      ( accept_move(Delta, T) -> Next = Candidate, NextScore = CandidateScore
      ; Next = Current, NextScore = Value
      ),
      ( NextScore > Score0 -> Best1 = Next, Score1 = NextScore
      ; Best1 = Best0, Score1 = Score0
      ),
      Remaining is Steps - 1, NextT is T * Cooling,
      anneal_loop(Remaining, NextT, Cooling, Next, NextScore, Best1, Score1, Best, BestScore)
    ).

accept_move(Delta, _) :- Delta >= 0, !.
accept_move(Delta, T) :- Probability is exp(Delta / T), random(R), R < Probability.

% Fixed seeds make the comparison repeatable on the same runtime.
% A successful trial reaches the known global score (13) of this example.
compare_algorithms(Trials, HillScore, Successes) :-
    integer(Trials), Trials > 0,
    hill_climb(0, _, HillScore, _),
    findall(1, (between(1, Trials, Seed), set_random(seed(Seed)),
                anneal(0, 5.0, 0.995, 2000, _, Value), Value =:= 13), Hits),
    length(Hits, Successes).

demo :-
    set_random(seed(42)), anneal(0, 5.0, 0.995, 2000, Best, Value),
    format('Annealing best state: x=~w, score=~w~n', [Best, Value]),
    compare_algorithms(20, HillScore, Successes),
    format('Hill climbing from x=0: score=~w~n', [HillScore]),
    format('Annealing reached global maximum in ~w/20 seeded trials.~n', [Successes]),
    writeln('Annealing is stochastic; finding the global optimum is not guaranteed.').
