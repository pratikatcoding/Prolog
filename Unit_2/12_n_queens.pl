/* Practical 12: N-Queens CSP with recursive backtracking.
   The list's index is a column (1..N), and its value is the queen's row.
   Selecting unused rows prevents row clashes; diagonal checks prune search.
   Example: n_queens(4, Rows). % [2,4,1,3] ; [3,1,4,2]
*/
:- module(n_queens, [n_queens/2, print_board/1, demo/0]).

n_queens(N, Rows) :-
    integer(N), N >= 0,
    (N =:= 0 -> Available = []; numlist(1, N, Available)),
    place_queens(Available, [], Rows).

place_queens([], _, []).
place_queens(Available, Previous, [Row|Rows]) :-
    select(Row, Available, Remaining),
    safe_diagonals(Row, Previous, 1),
    place_queens(Remaining, [Row|Previous], Rows).

safe_diagonals(_, [], _).
safe_diagonals(Row, [Other|Rest], Distance) :-
    abs(Row - Other) =\= Distance,
    NextDistance is Distance + 1,
    safe_diagonals(Row, Rest, NextDistance).

print_board(Rows) :-
    length(Rows, N),
    forall(between(1, N, Row),
           (forall(member(QueenRow, Rows),
                   (QueenRow =:= Row -> write('Q '); write('. '))), nl)).

demo :-
    once(n_queens(8, Rows)),
    format('Rows for columns 1..8: ~w~n', [Rows]),
    print_board(Rows).
