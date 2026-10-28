/* Practical 3: Recursive append, reverse, membership and length.
   Prefixes avoid redefining SWI-Prolog's built-in list predicates.
   Examples: list_append([1,2], [3,4], L). list_member(X, [a,b,c]).
*/
:- module(list_operations,
          [list_append/3, list_reverse/2, list_member/2, list_length/2, demo/0]).

list_append([], List, List).
list_append([Head|Tail], List, [Head|Rest]) :-
    list_append(Tail, List, Rest).

list_reverse(List, Reversed) :- reverse_acc(List, [], Reversed).
reverse_acc([], Acc, Acc).
reverse_acc([Head|Tail], Acc, Reversed) :-
    reverse_acc(Tail, [Head|Acc], Reversed).

list_member(Element, [Element|_]).
list_member(Element, [_|Tail]) :- list_member(Element, Tail).

list_length([], 0).
list_length([_|Tail], Length) :-
    list_length(Tail, TailLength), Length is TailLength + 1.

demo :-
    list_append([1,2,3], [4,5], Joined), format('Append: ~w~n', [Joined]),
    list_reverse([1,2,3,4], Reversed), format('Reverse: ~w~n', [Reversed]),
    (list_member(3, [1,2,3,4]) -> writeln('3 is a member'); writeln('3 is absent')),
    list_length([a,b,c,d], Length), format('Length: ~w~n', [Length]).
