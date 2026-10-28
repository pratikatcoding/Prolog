% Run from the repository root:
% swipl -q -s tests/test_practicals.pl -g run_tests -t halt
:- use_module(library(plunit)).
:- use_module('../Unit_1/01_student_course_database.pl', []).
:- use_module('../Unit_1/02_arithmetic_factorial_fibonacci.pl', []).
:- use_module('../Unit_1/03_list_operations.pl', []).
:- use_module('../Unit_1/04_college_timetable.pl', []).
:- use_module('../Unit_1/05_student_performance.pl', []).
:- use_module('../Unit_1/06_breadth_first_search.pl', []).
:- use_module('../Unit_2/07_greedy_best_first_search.pl', []).
:- use_module('../Unit_2/08_a_star_search.pl', []).
:- use_module('../Unit_2/09_hill_climbing.pl', []).
:- use_module('../Unit_2/10_simulated_annealing.pl', []).
:- use_module('../Unit_2/11_map_coloring.pl', []).
:- use_module('../Unit_2/12_n_queens.pl', []).

:- begin_tests(practicals).

test(enrolments) :-
    student_course_database:students_in_course(ai_ml, [rajeev, ananya]).
test(classmates, [nondet]) :- student_course_database:classmates(rajeev, ananya).
test(no_self_classmate, [fail]) :- student_course_database:classmates(rajeev, rajeev).
test(arithmetic) :-
    arithmetic_factorial_fibonacci:arithmetic(add, 12, 4, 16),
    arithmetic_factorial_fibonacci:arithmetic(subtract, 12, 4, 8),
    arithmetic_factorial_fibonacci:arithmetic(multiply, 12, 4, 48),
    arithmetic_factorial_fibonacci:arithmetic(divide, 12, 4, R), R =:= 3.
test(division_zero, [fail]) :- arithmetic_factorial_fibonacci:arithmetic(divide, 1, 0, _).
test(factorial_zero, [nondet]) :- arithmetic_factorial_fibonacci:factorial(0, 1).
test(factorial_five, [nondet]) :- arithmetic_factorial_fibonacci:factorial(5, 120).
test(factorial_negative, [fail]) :- arithmetic_factorial_fibonacci:factorial(-1, _).
test(factorial_fraction, [fail]) :- arithmetic_factorial_fibonacci:factorial(2.5, _).
test(fibonacci, [nondet]) :-
    arithmetic_factorial_fibonacci:fibonacci(0, 0),
    arithmetic_factorial_fibonacci:fibonacci(1, 1),
    arithmetic_factorial_fibonacci:fibonacci(10, 55).
test(fibonacci_series, [nondet]) :-
    arithmetic_factorial_fibonacci:fibonacci_series(7, [0,1,1,2,3,5,8]),
    arithmetic_factorial_fibonacci:fibonacci_series(0, []).
test(append) :- list_operations:list_append([1,2], [3,4], [1,2,3,4]).
test(reverse) :- list_operations:list_reverse([a,b,c], [c,b,a]).
test(empty_lists) :-
    list_operations:list_append([], [], []),
    list_operations:list_reverse([], []), list_operations:list_length([], 0).
test(member_enumeration) :-
    findall(X, list_operations:list_member(X, [a,b,c]), [a,b,c]).
test(member_absent, [fail]) :- list_operations:list_member(d, [a,b,c]).
test(list_length) :- list_operations:list_length([a,b,c], 3).
test(faculty_schedule) :- college_timetable:faculty_schedule(dr_sharma, S), length(S, 3).
test(subject_schedule) :- college_timetable:subject_schedule(ai_ml, S), length(S, 3).
test(classroom_schedule) :- college_timetable:classroom_schedule(lab_1, S), length(S, 3).
test(occupied_room, [fail]) :- college_timetable:room_free(monday, room_101, 9, 10).
test(partial_overlap, [fail]) :- college_timetable:room_free(monday, room_101, 8.5, 9.5).
test(adjacent_slot, [nondet]) :- college_timetable:room_free(monday, room_101, 10, 11).
test(unknown_room, [fail]) :- college_timetable:room_free(monday, unknown, 10, 11).
test(invalid_interval, [fail]) :- college_timetable:room_free(monday, lab_1, 12, 11).
test(grade_boundaries) :-
    forall(member(M-C, [0-fail,39-fail,40-average,74-average,75-topper,100-topper]),
           student_performance:classify_marks(M, C)).
test(invalid_high_mark, [fail]) :- student_performance:classify_marks(101, _).
test(invalid_low_mark, [fail]) :- student_performance:classify_marks(-1, _).
test(bfs_path, [nondet]) :- breadth_first_search:bfs(a, f, [a,b,d,f]).
test(bfs_same_node, [nondet]) :- breadth_first_search:bfs(a, a, [a]).
test(bfs_unreachable_cycle, [fail]) :- breadth_first_search:bfs(a, isolated, _).
test(bfs_unknown, [fail]) :- breadth_first_search:bfs(unknown, unknown, _).
test(greedy_cost, [nondet]) :- greedy_best_first_search:greedy_search(a, g, [a,c,e,g], 10).
test(astar_optimum, [nondet]) :- a_star_search:a_star(a, g, [a,b,d,g], 9).
test(astar_same_node, [nondet]) :- a_star_search:a_star(g, g, [g], 0).
test(astar_unknown, [fail]) :- a_star_search:a_star(unknown, g, _, _).

% Independent exhaustive simple-path oracle checks every start in the graph.
weighted_path(Node, Node, _, [Node], 0).
weighted_path(Node, Goal, Seen, [Node|Path], Cost) :-
    a_star_search:edge(Node, Next, Weight), \+ memberchk(Next, Seen),
    weighted_path(Next, Goal, [Next|Seen], Path, Rest), Cost is Weight + Rest.
test(astar_against_exhaustive_paths) :-
    forall(a_star_search:heuristic(Start, _),
           (findall(C, weighted_path(Start, g, [Start], _, C), Costs),
            min_list(Costs, Minimum),
            once(a_star_search:a_star(Start, g, Path, Actual)),
            assertion(Actual =:= Minimum),
            once(weighted_path(Start, g, [Start], Path, Actual)))).
test(heuristics_admissible) :-
    forall(a_star_search:heuristic(Start, H),
           (findall(C, weighted_path(Start, g, [Start], _, C), Costs),
            min_list(Costs, Minimum), assertion(H =< Minimum))).
test(hill_local_maximum, [nondet]) :- hill_climbing:hill_climb(0, 3, 8, [0,1,2,3]).
test(hill_global_basin, [nondet]) :- hill_climbing:hill_climb(6, 9, 13, [6,7,8,9]).
test(hill_invalid_start, [fail]) :- hill_climbing:hill_climb(11, _, _, _).
test(annealing_no_steps, [nondet]) :- simulated_annealing:anneal(0, 5, 0.99, 0, 0, 0).
test(annealing_bad_temperature, [fail]) :- simulated_annealing:anneal(0, 0, 0.99, 10, _, _).
test(annealing_bad_cooling, [fail]) :- simulated_annealing:anneal(0, 5, 1, 10, _, _).
test(annealing_reproducible, [nondet]) :-
    set_random(seed(42)), simulated_annealing:anneal(0, 5, 0.995, 2000, X, S),
    set_random(seed(42)), simulated_annealing:anneal(0, 5, 0.995, 2000, Y, T),
    assertion(X-S == Y-T), hill_climbing:score(X, S), assertion(S >= 0), assertion(S =< 13).
test(annealing_keeps_best, [nondet]) :-
    set_random(seed(7)), simulated_annealing:anneal(9, 5, 0.995, 100, 9, 13).
test(annealing_escapes_local_maximum, [nondet]) :-
    simulated_annealing:compare_algorithms(20, 8, Successes),
    assertion(Successes > 0), assertion(Successes =< 20).
test(map_all_solutions) :-
    findall(A, map_coloring:map_coloring(A), Solutions), length(Solutions, 18),
    forall(member(A, Solutions),
           (length(A, 7),
            forall(member(_-C, A), map_coloring:color(C)),
            forall(map_coloring:adjacent(U,V),
                   (memberchk(U-CU, A), memberchk(V-CV, A), assertion(CU \== CV))))).
test(queens_four) :-
    findall(R, n_queens:n_queens(4, R), [[2,4,1,3],[3,1,4,2]]).
test(queens_eight_count_and_constraints) :-
    findall(R, n_queens:n_queens(8, R), Solutions), length(Solutions, 92),
    forall(member(Rows, Solutions),
           (sort(Rows, [1,2,3,4,5,6,7,8]),
            forall((nth1(C1, Rows, R1), nth1(C2, Rows, R2), C1 < C2),
                   assertion(abs(R1-R2) =\= C2-C1)))).
test(queens_empty) :- n_queens:n_queens(0, []).
test(queens_one, [nondet]) :- n_queens:n_queens(1, [1]).
test(queens_two_impossible, [fail]) :- n_queens:n_queens(2, _).
test(queens_three_impossible, [fail]) :- n_queens:n_queens(3, _).
test(queens_negative, [fail]) :- n_queens:n_queens(-1, _).

:- end_tests(practicals).
