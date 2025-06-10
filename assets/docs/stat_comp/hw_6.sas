/*Corey Zhang
Hwk 6
STA - 511*/


LIBNAME class 'I:\Documents';
%macro FOURPROCS(action=,libname=,dsn=,var1=,var2=);
%if &action. =PRINT %then %do;
 proc print data=&libname..&dsn.(obs=10);
 var &var1. &var2.;
run;
%end;

%else %if &action. =FREQ %then %do;
 proc freq data =&libname..&dsn.;
 tables &var1.*&var2.;
run;
%end;

%else %if &action. =PLOT %then %do;
 proc plot data =&libname..&dsn.;
 plot &var1.*&var2.;
run;
%end;

%else %if &action. =UNIVARIATE %then %do;
 PROC UNIVARIATE DATA=&libname..&dsn. all;
 var &var1. &var2.;
run;
%end;
%mend sortandprint;

/*1*/
%FOURPROCS (action=PLOT,libname=class, dsn=auction,var1=cattle,var2=hogs);

/*2
suger 
						Mean     6.922078     Std Deviation            4.44489
                        Median   7.000000     Variance                19.75701
                        Mode     3.000000
carbo
                        Mean     14.59740     Std Deviation            4.27896
                        Median   14.00000     Variance                18.30947
                        Mode     13.00000*/
%FOURPROCS (action=UNIVARIATE,libname=class, dsn=cereal,var1=carbo,var2=sugars);

/*3*/
%FOURPROCS (action=FREQ,libname=class, dsn=clot,var1=pump,var2=aprotinin);

/*4*/
%FOURPROCS (action=PRINT,libname=class, dsn=cereal,var1=calories,var2=type);

/*5*/
%FOURPROCS (action=UNIVARIATE,libname=class, dsn=auction,var1=hogs,var2=sheep);

