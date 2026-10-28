/* Practical 4: College timetable knowledge base.
   All faculty names, rooms and schedules are fictional examples.
   lecture(Day, StartHour, EndHour, Subject, Faculty, Room).
   Times use 24-hour clock; intervals include start and exclude end.
*/
:- module(college_timetable,
          [lecture/6, faculty_schedule/2, subject_schedule/2,
           classroom_schedule/2, room_free/4, demo/0]).

lecture(monday,    9, 10, ai_ml,       dr_sharma, room_101).
lecture(monday,   10, 11, mathematics, dr_verma,  room_102).
lecture(monday,   11, 13, programming, ms_singh,  lab_1).
lecture(tuesday,   9, 10, mathematics, dr_verma,  room_101).
lecture(tuesday,  10, 12, ai_ml,       dr_sharma, lab_1).
lecture(wednesday,9, 11, programming, ms_singh,  lab_1).
lecture(wednesday,11,12, ai_ml,       dr_sharma, room_102).

room(room_101).
room(room_102).
room(lab_1).
day(monday).
day(tuesday).
day(wednesday).
day(thursday).
day(friday).

faculty_schedule(Faculty, Schedule) :-
    findall(slot(Day, Start, End, Subject, Room),
            lecture(Day, Start, End, Subject, Faculty, Room), Schedule).
subject_schedule(Subject, Schedule) :-
    findall(slot(Day, Start, End, Faculty, Room),
            lecture(Day, Start, End, Subject, Faculty, Room), Schedule).
classroom_schedule(Room, Schedule) :-
    findall(slot(Day, Start, End, Subject, Faculty),
            lecture(Day, Start, End, Subject, Faculty, Room), Schedule).

% Supply a specific day/room or enumerate them. Start and End are inputs.
room_free(Day, Room, Start, End) :-
    day(Day), room(Room), number(Start), number(End),
    Start >= 0, End =< 24, Start < End,
    \+ (lecture(Day, OtherStart, OtherEnd, _, _, Room),
        Start < OtherEnd, OtherStart < End).

demo :-
    faculty_schedule(dr_sharma, Faculty), format('Dr Sharma: ~w~n', [Faculty]),
    subject_schedule(ai_ml, Subject), format('AI-ML: ~w~n', [Subject]),
    classroom_schedule(lab_1, Lab), format('Lab 1: ~w~n', [Lab]),
    findall(Room, room_free(monday, Room, 9, 10), Rooms),
    format('Free rooms on Monday, 09:00-10:00: ~w~n', [Rooms]).
