


/*1) CREATE LIBREFS*/


LIBNAME hw1 'I:\Documents\hw_1';


DATA hw1.fall2021_hw1;
INPUT FirstName $ LastName $ Gender $ Occupation $ Cmp Age ;
/*2)*/
AGE_EST = 0.5+Age;
DATALINES;
Derek Carr M Athletes 30 34
Dak Prescott M Atheletes 28 42
Tom Brady M Atheletes 44 32
Kirk Cousins M Atheletes 33 36
Jared Goff M Atheletes 27 38
Patrick Mahomes M Atheletes 25 27
Justin Herbert M Atheletes 23 31
Trevor Lawrence M Atheletes 21 28
Matthew Stafford M Atheletes 33 25
Baker Mayfield M Atheletes 26 33
;
run;
/*3*/
proc print data = hw1.fall2021_hw1;
run;
/*4*/
proc datasets library = hw1;
contents data = fall2021_hw1;
run;
/*5) mean of people is 32.6*/
/*6) mean of males and females are 32.6 and 0*/


proc means data = hw1.fall2021_hw1;
VAR Age;
run;

proc means data=hw1.fall2021_hw1;
by gender;
VAR Age;
run;

/*Q8)
A)YES
B)QUIZ
C)QUESTION ANSWER DIFFFICULTY SCALE
D)Temporary dataset, because it doesn't have libname.
E)1,2,3,6
F)There is no character variables.
