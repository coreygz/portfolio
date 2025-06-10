/*Corey Zhang STA511 HW5*/


/*1)*/
data exams;
input Student $ Test Score;
datalines;
Jane 1 70
Jane 2 75
Jane 3 73
Sally 1 86
Sally 2 98
Sally 3 74
Jim	1 88
Jim	2 93
Jim	3 95
Oscar 1	37
Oscar 2	65
Oscar 3	64
;
run;
proc sort data = exams;
by Student;
run;

proc means data = exams mean;
var Score;
by Student;
run;

/*2)-------------------------------------------- Student=Jane --------------------------------------------
                                                     Mean
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ
                                               72.6666667
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ


-------------------------------------------- Student=Jim ---------------------------------------------
                                                     Mean
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ
                                               92.0000000
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ


------------------------------------------- Student=Oscar --------------------------------------------
                                                     Mean
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ
                                               55.3333333
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ

------------------------------------------- Student=Sally --------------------------------------------

                                                     Mean
                                             ƒƒƒƒƒƒƒƒƒƒƒƒ
                                               86.0000000
  */
/*3)*/
data scores2(keep= Student Test1 test2 test3);
set exams;
by student;
IF test = 1 then test1 = 0;
If test = 1 then test_1 = score ;
else test_1 = 0;
test1 + test_1;
IF test = 2 then test2 = 0;
If test = 2 then test_2 = score;
else test_2 = 0;
test2 + test_2;
IF test = 3 then test3 = 0;
If test = 3 then test_3 = score;
else test_3 = 0;
test3 + test_3;
if last.Student;
run;



data scores1;
set scores2;
means = mean(test1,test2,test3);
run;

proc print data = scores1;
run;
/*   4)                    Obs    Student    test1    test2    test3     means

                          1      Jane        70       75       73     72.6667
                          2      Jim         88       93       95     92.0000
                          3      Oscar       37       65       64     55.3333
                          4      Sally       86       98       74     86.0000
*/

data Q4;
input ID $ GENDER $ BDATE DATE9. ;
AGE =(Today()-BDATE);
BDAY_DAY = weekday(BDATE); /*4567)I was born Thursday*/
datalines;
	
101	M 12jan1971
102	F 07aug1977
103	M 31oct1949	
104	M 02feb1988	
105	F 08mar1982	
106 M 04AUG1999  
;
run;

proc print data = Q4;
run;
proc contents data = Q4;
run;
