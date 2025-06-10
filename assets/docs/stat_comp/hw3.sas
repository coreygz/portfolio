/**************************/
/*Corey Zhang             */
/*Homework 3              */
/*Stat 511                */
/**************************/

libname hw3 'I:\\documents';
data temp;
set hw3.cereal;
run;

proc print data= temp;
run;

proc freq data = temp;
tables lowsod;
run;
/*a) There are 20 cereals are low in sodium
b) 20%   */

proc freq data = temp;
tables lowsod*lowfat lowsod*lowcal;
run;

proc print data = temp;

/*c) 16.88% proportion of cereals are low in sod and low in fat
d) 13 cereals are low in sod and low in cal
*/
proc print data = temp;
	
	where name contains 'Lucky';
run;
/*e)protein 2, fiber 0*/

proc means data = temp mean;
var fiber;
var calories;
run;

/*f) 2.15
g) 106.88*/
proc sort data = temp;
by lowfat;
run;

proc means data = temp mean;
var fiber;
by lowfat;
run;

/*h) non lowfat = 2.21,lowfat =2.13*/

proc sort data = temp;
by descending fiber;
run;


/*i) print top 3 highest in fiber All-Bran_with_Extra_Fiber,100%_Bran, all_bran
*/
proc print data = temp(firstobs=1 obs=3);

run;

proc sort data = temp;
by calories;
run;

/*j) print 3 lowest in calories All-Bran_with_Extra_Fiber, Puffed_Wheat
Puffed_Rice
*/
proc print data = temp(firstobs=1 obs=3);

run;

proc means data = temp median;
var fiber;
var calories;
run;

proc univariate data = temp plots normal;
var fiber;
var calories;
run;

/*k) it is not the same, but close. The reason is the datasets have a symmetrical distribution.
*/



/*L)*/
data hw3.FAT_CARB;
set hw3.cereal;
keep name fat carbo;

run;

data hw3.FAT_CARB;
set hw3.FAT_CARB;
ratio_fc = fat/carbo*100;
run;


proc print data = hw3.FAT_CARB;
run;
/***************************/

proc sort data = hw3.FAT_CARB;
by descending ratio_fc;
run;

proc print data = hw3.FAT_CARB(firstobs = 1 obs=3);
run;

/*m)the 3 cereal has the highest ratio_fc "100%_Natural_Bran
,Cracklin'_Oat_Bra,Great_Grains_Peca
since I have no knowledge to nutrition and cereals, I don't give personal opinion.*/
