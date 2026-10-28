/* Practical 5: Rule-based performance classification.
   Assumed lab policy: topper >= 75, average >= 40 and < 75, fail < 40.
   Marks are out of 100. These are illustrative marks, not student records.
*/
:- module(student_performance, [marks/2, classify_marks/2, performance/2, demo/0]).

marks(rajeev, 88).
marks(ananya, 95).
marks(arjun, 62).
marks(priya, 74).
marks(rohan, 35).
marks(neha, 40).

valid_marks(Marks) :- number(Marks), Marks >= 0, Marks =< 100.
classify_marks(Marks, topper) :- valid_marks(Marks), Marks >= 75.
classify_marks(Marks, average) :- valid_marks(Marks), Marks >= 40, Marks < 75.
classify_marks(Marks, fail) :- valid_marks(Marks), Marks < 40.

performance(Student, Category) :- marks(Student, Marks), classify_marks(Marks, Category).

demo :-
    forall((marks(Student, Marks), performance(Student, Category)),
           format('~w: ~w/100 -> ~w~n', [Student, Marks, Category])).
