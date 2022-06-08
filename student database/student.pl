:- dynamic(student/5).
:- use_module(library(persistency)).

:- persistent(student(id, name, surname, mark, studies)).
:- initialization(db_attach('student_database.pl', [])).

add_student(ID, Name, Surname, Mark, Studies):-
    with_mutex(student_db, assert_student(ID, Name, Surname, Mark, Studies)).

remove_student(ID):-
    with_mutex(student_db, retract_student(ID, _, _, _, _)).

print_marks([], _).
print_marks([[A,B,C,D,E]|Tail], Required_Mark):-
    ((D >= Required_Mark)
    ->
    (write(A), write(","), write(B), write(","), write(C),
    write(","), write(D), write(","), write(E), nl)
    ;
    true),
    (number(D)
    ->
    print_marks(Tail, Required_Mark)).

print_elements([]).
print_elements([Head|Tail]):-
    write(Head),
    nl,
    print_elements(Tail).

option(3):-
    write('Surname: '), nl,
    read(Surname),
    by_surname(Surname).

option(2):-
    write('Name: '), nl,
    read(Name),
    by_name(Name).

option(5):-
    write('Grade: '), nl,
    read(Marks),
    by_marks(Marks).

option(4):-
    write('Field of study: '), nl,
    read(Studies),
    by_studies(Studies).

option(9):-
    write("End"),
    get0(_), nl,
    halt.

option(6):-
    write("Write ID, name, surname, grade and a field of study: "), nl,
    read(A),
    ((student(A,_,_,_,_)
    ->
    write("This student already exists!");
    read(B), read(C), read(D), read(E),
    add_student(A,B,C,D,E))).

option(8):-
    write("Students ID: "), nl,
    read(A),
    (remove_student(A);
    write("Didnt find any student.")).

option(1):-
    write("All students: "), nl,
    setof((ID, Name, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    print_elements(List);
    write("Theres no students in database!").

option(7):-
    write("Students ID: "), nl,
    read(A),
    (modify_student(A);
    write("Didnt find any student.")).

option(_):-
    start.

modify_student(ID):-
    student(ID, _, _, _, _)
    ->
    (write("Name: "), nl, read(Name),
    write("Surname: "), nl, read(Surname),
    write("Grade: "), nl, read(Mark),
    write("Field of study: "), nl, read(Studies),
    remove_student(ID),
    add_student(ID, Name, Surname, Mark, Studies));
    write("Didnt find any student."), nl.

show:-
    nl, nl,
    write("1. Print all students"), nl,
    write("2. Search a student by name"), nl,
    write("3. Search a student by surname"), nl,
    write("4. Search a student by field of study"), nl,
    write("5. Search a student by average grade"), nl,
    write("6. Add a student"), nl,
    write("7. Modify the student"), nl,
    write("8. Delete the student"), nl,
    write("9. Exit"), nl, nl,
    write("Option: "), nl.

by_surname(Surname):-
    setof((ID, Name, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("With surname \""), write(Surname),
    write("\" found"), write(Length),
    write(" student(s):"), nl,
    print_elements(List);
    !,
    write("Didnt find any student.").

by_name(Name):-
    setof((ID, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("With name \""), write(Name),
    write("\" found "), write(Length),
    write(" student(s):"), nl,
    print_elements(List);
    !,
    write("Didnt find any student.").

by_marks(Required_Mark):-
    setof([ID, Name, Surname, Mark, Studies], (student(ID, Name, Surname, Mark, Studies)), List),
    write("With grade \""), write(Required_Mark),
    write("\" found"),
    write("student(s):"), nl,
    print_marks(List, Required_Mark);
    !,
    write("Didnt find any student.").

by_studies(Studies):-
    setof((ID, Name, Surname, Mark), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("From \""), write(Studies),
    write("\" found "), write(Length),
    write(" student(s):"), nl,
    print_elements(List);
    !,
    write("Didnt find any student.").


start:-
    show,
    read(Answer),
    %clear,
    option(Answer),
    start.

clear:-
    write('\33\[2J').
    %shell(clear). % it clears shell, works only for unix systems
