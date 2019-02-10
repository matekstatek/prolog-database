assert(student(18342, mateusz, sobolewski, 4.8, informatyka)).
assert(student(18433, katarzyna, garus, 4.0, nawigacja)).
assert(student(18556, katarzyna, losicka, 4.1, mechatronika)).
assert(student(18432, pawel, kubacki, 3.8, informatyka)).
assert(student(17654, maksymilian, wrzesien, 4.5, mechanika)).
assert(student(24562, arkadiusz, kot, 3.5, informatyka)).
assert(student(16647, paulina, skwarzec, 4.0, nawigacja)).
assert(student(25385, eryk, perzewski, 4.1, mechatronika)).
assert(student(12387, dawid, pianka, 4.2, mechanika)).
assert(student(65839, szymon, pianka, 4.3, mechatronika)).
assert(student(12754, przemek, pianka, 3.1, nawigacja)).
assert(student(26458, marcin, przybysz, 4.3, informatyka)).
assert(student(11111,arkadiusz,kopec,4.1,mechatronika)).
assert(student(18943,damian,peza,3.9,mechanika)).
retract(student(11111,arkadiusz,kopec,4.1,mechatronika)).
assert(student(11111,mateusz,stateusz,3.4,informatyka)).
assert(student(12345,matek,stateczny,4.6,mechatronika)).
retract(student(12345,matek,stateczny,4.6,mechatronika)).
assert(student(12345,matek,stateczny,4.5,informatyka)).
retract(student(12345,matek,stateczny,4.5,informatyka)).
retract(student(11111,mateusz,stateusz,3.4,informatyka)).
assert(student(18888,matek,statek,4.5,info)).
