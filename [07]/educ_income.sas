proc import datafile="/home/u63869883/6371.06/ex0525.csv" 
    out=educ
    dbms=csv
    replace;
    getnames=yes;
run;

data educ;
set educ;
if Educ eq '<12' then EO = 1;
if Educ eq '12' then EO = 2;
if Educ eq '13-15' then EO = 3;
if Educ eq '16' then EO = 4;
if Educ eq '>16' then EO = 5;
run;

proc sort data=educ;
by EO;
run;

proc univariate data=educ;
    var Income2005;
    by EO;
    histogram Income2005 / normal;
    qqplot Income2005 / normal(mu=est sigma=est);
run;

data log_educ;
set educ;
log_income = log(Income2005);
run;

proc sort data=log_educ;
by EO;
run;

proc univariate data=log_educ;
    var log_income;
    by EO;
    histogram log_income / normal;
    qqplot log_income / normal(mu=est sigma=est);
run;

proc glm data = log_educ;
	class Educ;
	model log_income = Educ;
	means Educ / Dunnett;
    means Educ / tukey;
run;

proc means data=educ nway;
   class Educ;
   var Income2005;
   output out=income_summary median=median_income mean=mean_income;
run;

proc print data=income_summary;
   var Educ median_income mean_income;
run;

