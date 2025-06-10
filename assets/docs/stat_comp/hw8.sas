libname hw "I:\documents";

proc print data=hw.faculty;
run;


proc means data = hw.faculty median q1 q3; 
 
 var SAVG;
run;
/*Q1 475,Q3 352*/
data hw8;
set hw.faculty(keep =  Name STATE SAVG CAVG NPRO NAOP NAIP);
SAVG = SAVG*100;
CAVG = CAVG*100;
IF SAVG >=475 THEN SCLASS = 'HIGHEST';
	ELSE IF SAVG >= 407 THEN SCLASS = 'HIGH';
		ELSE IF SAVG >= 352 THEN SCLASS = 'LOW';
			ELSE IF SAVG >= 0 THEN SCLASS = 'LOWEST';
				ELSE SCLASS = 'MISSING';
 
run;

proc sort data = hw8;
by STATE;
run;

proc print data = hw8;
run;



ods rtf file = "I:\documents\hw8\FAC_SAL.rtf";
title "ALL salary and compensation figures";
proc report data = hw8 NOWINDOWS MISSING SPLIT="@" style(header)={bordercolor=gray};
COLUMN STATE SCLASS NAME SAVG CAVG NPRO NAOP NAIP;
DEFINE STATE / GROUP WIDTH = 5 "State";
DEFINE SCLASS / GROUP WIDTH = 12 "Salary@distribution@'quartile'";
DEFINE NAME / WIDTH = 27 "School";
DEFINE SAVG / WIDTH = 8 "Average@salary";
DEFINE CAVG / WIDTH = 7 "Average@compen-@sation";
DEFINE NPRO / WIDTH = 10 "Number@of@full@professors";
DEFINE NAOP / WIDTH = 10 "Number@of@associate@professors";
DEFINE NAIP / WIDTH = 10 "Number@of@assistant@professors";
run;
quit;
ods rtf close;

