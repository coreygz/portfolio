
/********************************/
/*Corey Zhang                   */
/*Homework 2                    */
/********************************/


/*Question 1*/

data basketball;

infile '\\I:\basketball.txt';
input Year 1-4 WinningSchool $ 6-23 WinningScore 25-27 LosingSchool $29-47 LosingScore 49-51;
run;

proc print data = basketball;
run;


/*Question 2*/

Libname hw2 'I:\Documents';

data hw2.MYDATA;
input first $ last $ colorofshirt $ moneyinpocket dollar6.2 +1 dateofquestion date7.;
datalines;
Corey Zhang Red $12.34 15JAN21
Lilian Ly Blue $23.45 16JAN21
Ted Cruz Red $56.11 09Sep21
Tom Blues Black $99.34 05Aug20
Kai Lee Pink $33.55 04May18
;
run;

proc print data = hw2.MYDATA;
run;
