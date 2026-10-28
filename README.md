# AI & ML Practicals — Units 1 and 2

Prolog programs for the **Introduction to Artificial Intelligence and Machine Learning** practical course. This repository contains all 12 practicals from the supplied Unit 1 and Unit 2 list, with commented source code and runnable demonstrations.

## Student and Course Details

| Field | Details |
| --- | --- |
| Name | Pratik Karmakar |
| ERP | RU-25-11000 |
| Course | Bachelor of Technology Computer Science and Engineering |
| Section | 3B (IBM) |
| College / University | Rungta International Skill University |
| Subject | Introduction to Artificial Intelligence and Machine Learning |
| Subject Code | RU-200-02-00004 |

## Requirements and Prolog Dialect

- Install [SWI-Prolog](https://www.swi-prolog.org/download/stable) and make the `swipl` command available in your terminal.
- These programs use **SWI-Prolog**, including its module system and standard libraries. No additional packages are required.
- The supplied syllabus mentions **Visual Prolog** in Practicals 1 and 4. These files implement the same exercises in SWI-Prolog syntax; they are not Visual Prolog project files and do not use its `domains`, `predicates`, `clauses`, and `goal` sections. Check the required dialect with your instructor if Visual Prolog is compulsory.
- Student marks, enrolments, faculty, and timetable entries inside the programs are illustrative sample data.

## Repository Structure

```text
prolog_ct1/
├── Unit_1/
│   ├── 01_student_course_database.pl
│   ├── 02_arithmetic_factorial_fibonacci.pl
│   ├── 03_list_operations.pl
│   ├── 04_college_timetable.pl
│   ├── 05_student_performance.pl
│   └── 06_breadth_first_search.pl
├── Unit_2/
│   ├── 07_greedy_best_first_search.pl
│   ├── 08_a_star_search.pl
│   ├── 09_hill_climbing.pl
│   ├── 10_simulated_annealing.pl
│   ├── 11_map_coloring.pl
│   └── 12_n_queens.pl
├── tests/
│   └── test_practicals.pl
├── .gitignore
└── README.md
```

## Unit 1: Introduction to AI and Intelligent Agents

| Practical | Program | Topics |
| --- | --- | --- |
| 1 | [Student-Course Database](Unit_1/01_student_course_database.pl) | Facts, predicates, rules, goals, enrolments and classmates |
| 2 | [Arithmetic, Factorial and Fibonacci](Unit_1/02_arithmetic_factorial_fibonacci.pl) | Basic arithmetic and recursive calculations |
| 3 | [List Operations](Unit_1/03_list_operations.pl) | Append, reverse, member search and list length |
| 4 | [College Timetable](Unit_1/04_college_timetable.pl) | Faculty, subject and classroom queries; room availability |
| 5 | [Student Performance](Unit_1/05_student_performance.pl) | Rule-based topper, average and fail classification |
| 6 | [Breadth-First Search](Unit_1/06_breadth_first_search.pl) | Shortest path in an unweighted graph |

## Unit 2: Problem Solving and Searching

| Practical | Program | Topics |
| --- | --- | --- |
| 7 | [Greedy Best-First Search](Unit_2/07_greedy_best_first_search.pl) | Heuristic-only search using h(n) |
| 8 | [A* Search](Unit_2/08_a_star_search.pl) | Optimal path using f(n) = g(n) + h(n) |
| 9 | [Hill Climbing](Unit_2/09_hill_climbing.pl) | Numerical optimization and local maxima |
| 10 | [Simulated Annealing](Unit_2/10_simulated_annealing.pl) | Probabilistic moves, cooling and comparison with hill climbing |
| 11 | [Map Coloring](Unit_2/11_map_coloring.pl) | Constraint satisfaction and backtracking |
| 12 | [N-Queens](Unit_2/12_n_queens.pl) | Backtracking with row and diagonal constraints |

## How to Run

Open a terminal in the repository's root directory. Check the interpreter:

```sh
swipl --version
```

If PowerShell does not recognize `swipl` and you installed it in the default Windows location, use the executable's full path, for example:

```powershell
& 'C:\Program Files\swipl\bin\swipl.exe' -q -s Unit_1/01_student_course_database.pl -g demo -t halt
```

Every practical exports a `demo/0` predicate. Run one demonstration and exit:

```sh
swipl -q -s Unit_1/01_student_course_database.pl -g demo -t halt
swipl -q -s Unit_2/08_a_star_search.pl -g demo -t halt
swipl -q -s Unit_2/10_simulated_annealing.pl -g demo -t halt
```

Replace the file path with any practical listed above.

For interactive queries, load one practical:

```sh
swipl -q -s Unit_1/02_arithmetic_factorial_fibonacci.pl
```

Then enter queries at the Prolog prompt:

```prolog
?- factorial(5, F).
F = 120.

?- fibonacci_series(7, Series).
Series = [0, 1, 1, 2, 3, 5, 8].

?- halt.
```

The `?-` is the displayed Prolog prompt; do not type it. End each query with a period. Press `;` when prompted to request another solution, or Enter to accept the current solution. Use a fresh session for each practical to avoid importing multiple predicates named `demo/0` or `edge/3` into the same context.

## Sample Queries and Expected Results

Load the corresponding practical before using its query.

| No. | Query | Expected result |
| --- | --- | --- |
| 1 | `students_in_course(ai_ml, Names).` | `Names = [rajeev, ananya]` |
| 2 | `arithmetic(multiply, 12, 4, R).` | `R = 48` |
| 2 | `factorial(5, F).` | `F = 120` |
| 2 | `fibonacci(10, F).` | `F = 55` |
| 3 | `list_append([1,2], [3,4], L).` | `L = [1,2,3,4]` |
| 3 | `list_reverse([a,b,c], R).` | `R = [c,b,a]` |
| 3 | `list_member(b, [a,b,c]).` | Succeeds |
| 3 | `list_length([a,b,c], N).` | `N = 3` |
| 4 | `faculty_schedule(dr_sharma, S).` | Three scheduled slots |
| 4 | `room_free(monday, room_101, 9, 10).` | `false` (occupied) |
| 4 | `room_free(monday, room_101, 10, 11).` | Succeeds |
| 5 | `performance(rajeev, Category).` | `Category = topper` |
| 6 | `bfs(a, f, Path).` | `Path = [a,b,d,f]` |
| 7 | `greedy_search(a, g, Path, Cost).` | `Path = [a,c,e,g], Cost = 10` |
| 8 | `a_star(a, g, Path, Cost).` | `Path = [a,b,d,g], Cost = 9` |
| 9 | `hill_climb(0, X, Score, Trace).` | `X = 3, Score = 8, Trace = [0,1,2,3]` |
| 10 | `set_random(seed(42)), anneal(0, 5.0, 0.995, 2000, X, Score).` | Seeded optimization run; outputs best visited state and score |
| 10 | `compare_algorithms(20, HillScore, Successes).` | `HillScore = 8`; `Successes` counts trials reaching score 13 |
| 11 | `map_coloring(Assignment).` | Adjacent regions receive different colors |
| 12 | `n_queens(4, Rows).` | `[2,4,1,3]` or `[3,1,4,2]` |

## Algorithm Notes and Assumptions

- **Arithmetic:** numeric arguments are inputs. Factorial and Fibonacci require a non-negative integer. Fibonacci starts with F(0) = 0 and F(1) = 1; the series argument specifies the number of terms. Invalid numeric inputs and division by zero fail.
- **Lists:** supply finite lists; reverse and length are intended for computing results from an input list.
- **Timetable:** times use the 24-hour clock. Slots include their start and exclude their end, so a class ending at 10 does not conflict with one starting at 10. Availability only reflects this sample database.
- **Performance:** assumed thresholds are topper = 75–100, average = 40–below 75, and fail = 0–below 40. These are exercise rules, not an official university grading policy.
- **BFS:** edges are directed and unweighted. The answer minimizes edge count. The visited set handles cycles, and unreachable destinations fail.
- **Greedy and A*:** both use the same directed weighted graph. Heuristics are defined specifically for goal `g`, so these predicates only accept that goal. Greedy selects by h(n) and can return a more expensive path. A* selects by g(n) + h(n), tracks best known costs and permits improvements to previously reached nodes. Its optimality here relies on non-negative edge costs and admissible heuristics with h(goal) = 0.
- **Hill climbing and annealing:** both maximize the same score table over integer states 0–10. Starting at 0, hill climbing stops at local maximum 3 with score 8; the global maximum is 9 with score 13. Annealing may accept worse moves to escape a local maximum and returns the best state visited. It is stochastic and does not guarantee the global optimum. The demonstration uses fixed seeds for repeatability on the same runtime. Practical 10 imports Practical 9, so keep both files together.
- **Map coloring:** the seven Australia regions are `wa`, `nt`, `sa`, `q`, `nsw`, `v`, and `t`. The domain is red/green/blue. The Tasmania island is unconstrained by mainland borders in this model.
- **N-Queens:** each list position is a column, and each value is its queen's row. N must be a non-negative integer. N = 0 returns the empty board; N = 2 and N = 3 have no solutions. Plain backtracking becomes expensive for large N.

## Verification

Verified with **SWI-Prolog 10.0.2**: all **55 automated checks** pass.

Run the automated correctness checks from the repository root:

```sh
swipl -q -s tests/test_practicals.pl -g run_tests -t halt
```

The checks cover arithmetic boundaries, database queries, list operations, timetable overlaps, classification thresholds, graph path correctness, optimization behavior, map constraints, and known N-Queens solution counts.

## Upload to GitHub

Create a GitHub repository, then choose **Add file → Upload files** and drag in `Unit_1`, `Unit_2`, `tests`, and `README.md` while preserving the folder structure. Include `.gitignore` if it is visible in your file picker, then commit the upload.

Alternatively, use Git from this folder (replace the URL with your repository URL):

```sh
git init
git add .
git commit -m "Add AI-ML Unit 1 and Unit 2 Prolog practicals"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```

These Git commands assume a new local repository and an empty remote repository. The programs are intended for academic study and practical demonstrations.
