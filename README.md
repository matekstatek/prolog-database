# Prolog database

The program works like database, written in Prolog language.

## Description

The database contains students information about ID, name, surname, field of study and average grade. User can:
* list students
* search students by:
   * name
   * surname
   * field of study
   * average grade (greater or equal)
* add student
* modify the student with specific ID
* delete the studetn with specific ID

All changes are writing to the second file, student_database.pl, which contains asserts of student/5 predicates.

## Getting Started

### Executing program

To run the program, the SWI-Prolog is mandatory. You can download it from:
```
https://www.swi-prolog.org/
```

Next, you can compile it in SWI-Prolog GUI or add <swi-prolog_path>/bin to PATH and run:
```
swipl ".\student.pl" # for Windows
```

If you are using unix system, you can unhash the line:
```
write('\33\[2J').
```

and delete the line
```
%shell(clear). % it clears shell, works only for unix systems
```
in clear/0 predicate 


## Author

[@MatekStatek](https://twitter.com/matekstatek)

## Version History

* 0.1
    * Polish version
* 1.0
    * Translated
    * All done
