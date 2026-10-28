/* Practical 2: Arithmetic and recursion.
   Example: factorial(5, F).      % F = 120
            fibonacci_series(7, S). % S = [0,1,1,2,3,5,8]
   Numeric inputs must be instantiated. N must be a non-negative integer.
*/
:- module(arithmetic_factorial_fibonacci,
          [arithmetic/4, factorial/2, fibonacci/2, fibonacci_series/2, demo/0]).

arithmetic(add, A, B, Result) :- number(A), number(B), Result is A + B.
arithmetic(subtract, A, B, Result) :- number(A), number(B), Result is A - B.
arithmetic(multiply, A, B, Result) :- number(A), number(B), Result is A * B.
arithmetic(divide, A, B, Result) :-
    number(A), number(B), B =\= 0, Result is A / B.

factorial(N, F) :- integer(N), N >= 0, factorial_acc(N, 1, F).
factorial_acc(0, Acc, Acc).
factorial_acc(N, Acc, F) :-
    N > 0, Next is N - 1, Product is Acc * N,
    factorial_acc(Next, Product, F).

% F(0) = 0, F(1) = 1; accumulator recursion avoids repeated computation.
fibonacci(N, F) :- integer(N), N >= 0, fib_acc(N, 0, 1, F).
fib_acc(0, A, _, A).
fib_acc(N, A, B, F) :-
    N > 0, Next is N - 1, Sum is A + B,
    fib_acc(Next, B, Sum, F).

% N is the number of terms, not the final index.
fibonacci_series(N, Series) :-
    integer(N), N >= 0, fib_terms(N, 0, 1, Series).
fib_terms(0, _, _, []).
fib_terms(N, A, B, [A|Rest]) :-
    N > 0, Next is N - 1, Sum is A + B,
    fib_terms(Next, B, Sum, Rest).

demo :-
    forall(member(Op, [add, subtract, multiply, divide]),
           (arithmetic(Op, 12, 4, R), format('~w(12, 4) = ~w~n', [Op, R]))),
    factorial(5, F), format('5! = ~w~n', [F]),
    fibonacci(10, T), format('F(10) = ~w~n', [T]),
    fibonacci_series(10, S), format('First 10 Fibonacci terms: ~w~n', [S]).
