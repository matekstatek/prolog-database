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
    write('Podaj nazwisko studenta: '), nl,
    read(Surname),
    by_surname(Surname).

option(2):-
    write('Podaj imie studenta: '), nl,
    read(Name),
    by_name(Name).

option(5):-
    write('Podaj srednia studenta: '), nl,
    read(Marks),
    by_marks(Marks).

option(4):-
    write('Podaj kierunek studenta: '), nl,
    read(Studies),
    by_studies(Studies).

option(9):-
    write("Koniec"),
    get0(_), nl,
    halt.

option(6):-
    write("podaj ID, imie, nazwisko, srednia i kierunek: "), nl,
    read(A),
    ((student(A,_,_,_,_)
    ->
    write("Taki student juz istnieje!");
    read(B), read(C), read(D), read(E),
    add_student(A,B,C,D,E))).

option(8):-
    write("podaj ID studenta: "), nl,
    read(A),
    (remove_student(A);
    write("Nie znaleziono takiego studenta")).

option(1):-
    write("Wszyscy studenci: "), nl,
    setof((ID, Name, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    print_elements(List);
    write("Brak studentow w bazie!").

option(7):-
    write("podaj ID studenta: "), nl,
    read(A),
    (modify_student(A);
    write("Nie znaleziono takiego studenta")).

option(_):-
    start.

modify_student(ID):-
    student(ID, _, _, _, _)
    ->
    (write("Podaj imie tego studenta: "), nl, read(Name),
    write("Podaj nazwisko tego studenta: "), nl, read(Surname),
    write("Podaj srednia tego studenta: "), nl, read(Mark),
    write("Podaj kierunek tego studenta: "), nl, read(Studies),
    remove_student(ID),
    add_student(ID, Name, Surname, Mark, Studies));
    write("Nie ma takiego studenta!"), nl.

show:-
    nl, nl,
    write("1. Wypisz wszystkich studentow"), nl,
    write("2. Wyszukaj studenta wg imienia"), nl,
    write("3. Wyszukaj studenta wg nazwiska"), nl,
    write("4. Wyszukaj studenta wg kierunku"), nl,
    write("5. Wyszukaj studenta wg sredniej"), nl,
    write("6. Dodaj studenta"), nl,
    write("7. Modyfikuj studenta"), nl,
    write("8. Usun studenta"), nl,
    write("9. Zakoncz"), nl, nl,
    write("Wybor: "), nl.

by_surname(Surname):-
    setof((ID, Name, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("O nazwisku \""), write(Surname),
    write("\" znaleziono "), write(Length),
    write(" osob(y):"), nl,
    print_elements(List);
    !,
    write("Nie znaleziono takiego studenta").

by_name(Name):-
    setof((ID, Surname, Mark, Studies), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("O imieniu \""), write(Name),
    write("\" znaleziono "), write(Length),
    write(" osob(y):"), nl,
    print_elements(List);
    !,
    write("Nie znaleziono takiego studenta").

by_marks(Required_Mark):-
    setof([ID, Name, Surname, Mark, Studies], (student(ID, Name, Surname, Mark, Studies)), List),
    write("O sredniej \""), write(Required_Mark),
    write("\" znaleziono "),
    write("osoby:"), nl,
    print_marks(List, Required_Mark);
    !,
    write("Nie znaleziono takiego studenta").

by_studies(Studies):-
    setof((ID, Name, Surname, Mark), (student(ID, Name, Surname, Mark, Studies)), List),
    length(List, Length),
    write("Z kierunku \""), write(Studies),
    write("\" znaleziono "), write(Length),
    write(" osob(y):"), nl,
    print_elements(List);
    !,
    write("Nie znaleziono takiego studenta").


start:-
    show,
    read(Answer),
    clear,
    option(Answer),
    start.

clear:-
    shell(clear).
