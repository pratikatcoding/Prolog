/* Practical 1: Student-course knowledge base.
   Run: swipl -q -s Unit_1/01_student_course_database.pl -g demo -t halt
   Example: enrolled_in(rajeev, Course).
   Names and enrolments below are illustrative sample data.
*/
:- module(student_course_database,
          [student/2, course/2, enrolled/2, enrolled_in/2,
           classmates/2, students_in_course/2, demo/0]).

% Facts: student(Id, Name), course(Code, Title), enrolled(Id, Code).
student(s1, rajeev).
student(s2, ananya).
student(s3, arjun).
student(s4, priya).

course(ai_ml, 'Introduction to Artificial Intelligence and Machine Learning').
course(mathematics, 'Mathematics').
course(programming, 'Programming Fundamentals').

enrolled(s1, ai_ml).
enrolled(s1, programming).
enrolled(s2, ai_ml).
enrolled(s2, mathematics).
enrolled(s3, programming).
enrolled(s4, mathematics).

% Rules: derive new relationships from facts.
enrolled_in(Name, Title) :-
    student(Id, Name), enrolled(Id, Code), course(Code, Title).

classmates(Name1, Name2) :-
    student(Id1, Name1), student(Id2, Name2),
    dif(Id1, Id2),
    once((enrolled(Id1, Code), enrolled(Id2, Code))).

students_in_course(Code, Names) :-
    course(Code, _),
    findall(Name, (enrolled(Id, Code), student(Id, Name)), Names).

demo :-
    writeln('Courses taken by Rajeev:'),
    forall(enrolled_in(rajeev, Title), format('  ~w~n', [Title])),
    students_in_course(ai_ml, Names),
    format('Students enrolled in AI-ML: ~w~n', [Names]).
