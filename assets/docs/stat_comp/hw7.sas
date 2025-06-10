/*Homework 7
Corey Zhang
*/

libname hw7 "I:\hw7";
data chem;
set hw7.clot;
run;

proc contents data =  chem;
run;
/*Q1*/
proc format;
	value pump_fmt 0='OFF'
		      1='ON';
	value apr_fmt 1 = 'PRESENT'
				0 = 'ABSENT';
run;

/*Q2

*/

Proc tabulate data = chem format = 6.2;
class pump /missing;
var chem1;
format pump pump_fmt.;
table pump, CHEM1*(N MEAN) /
box = 'TABLE1. TABLE of pump by chem1'; 
run;
Proc tabulate data = chem format = 6.2;
class pump /missing;
var chem2;
format pump pump_fmt.;
table pump, CHEM2*(N MEAN) /
box = 'TABLE2. TABLE of pump by chem2'; 
run;
Proc tabulate data = chem format = 6.2;
class Aprotinin /missing;
var chem1;
format Aprotinin apr_fmt.;
table Aprotinin, CHEM1*(N MEAN) /
box = 'TABLE3. TABLE of Aprotini by chem1'; 
run;
Proc tabulate data = chem format = 6.2;
class Aprotinin /missing;
var chem2;
format Aprotinin apr_fmt.;
table Aprotinin, CHEM2*(N MEAN) /
box = 'TABLE4. TABLE of Aprotini by chem2'; 
run;
