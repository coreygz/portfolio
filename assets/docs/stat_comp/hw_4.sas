/*Corey Zhang
 ASSISGMENT 4
 STA 511
 WCUPA
*/

data origin;
input NAME $ 1-31 BIRTHPLACE $ 33-58 RES_CITY $ 60-71 RES_STATE $ 73-84;
datalines;
Randall Rieger 					Willimantic, Connecticut   West Chester Pennsylvania
Rocky Balboa 					Philadelphia, WCUPAPEnnsylvania Hollywood    California
Bill Clinton 					Little Rock, Arkansas      Brooklyn     New York
Donald Trump 					New York, New York         Washington   D.C.
Homer Simpson					Spring, Unknown            Spring       ?????
[Fill in your information here]
;
proc print data = origin;

data new;
set origin(firstobs=1 obs=5);
keep Name2 Name_len Name1st3 Birthstate Resinfo;
Name2 = Scan(Name,2, ' ');
Name_len = length(Name2);
Name1st3 = UPCASE(substr(Name2,1,3));
Birthstate = Scan(BIRTHPLACE,2,',');
Resinfo = COMPRESS(RES_CITY||","||RES_STATE);
run;

proc print data = new;
run;

LIBNAME class 'I:\Documents';
data TEMP;
set class.auction;
ADD_live = cattle+calves+hogs+sheep;
SUM_live = sum(cattle, calves, hogs, sheep);
ROUNDALL = round(SUM_live,1);
DIFF_ALL = ADD_LIVE - ROUNDALL;
MEAN_ALL = mean(cattle, calves, hogs, sheep);
NEWCOST =  cost*1.15;
if NEWCOST>=50 then COST_CAT = 'HIGH';
ELSE COST_CAT = 'LOW';

proc print data = TEMP;
run;
proc contents data = TEMP;
run;

proc print data = TEMP(firstobs = 1 obs = 5);
var mkt ADD_LIVE SUM_LIVE ROUNDALL DIFF_ALL;
run;

proc means data = TEMP;
var hogs;
run;

proc print data = temp;
run;
/*10 mean_all is the average of four types which is row, mean of data is the mean average of hogs which is column*/

/*13*/
proc print data = TEMP noobs;
var mkt cost;
run; 

DATA onlyhigh;
set temp;
if COST_CAT = 'HIGH' ;
run;

proc print data = onlyhigh;
run; 
