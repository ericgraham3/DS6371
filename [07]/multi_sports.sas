proc import datafile="/home/u63869883/6371.07/ANOVA Sports Height Example.csv"
	out=sports
	dbms=csv
	replace;
	getnames=yes;
run;

proc sort data=sports;
by Sport;
run;

proc univariate data=sports;
    var Height;
    by Sport;
    histogram Height / normal;
    qqplot Height / normal(mu=est sigma=est);
run;

proc glm data = sports order = DATA;
	class Sport;
	model Height = Sport;
	means Sport;
	contrast 'Sum Basketball vs Sum Football & Soccer & Swimming & Tennis' Sport 4 -1 -1 -1 -1;
	estimate 'Avg. Basketball vs Sum Football & Soccer & Swimming & Tennis' Sport 4 -1 -1 -1 -1 / DIVISOR = 2;
	estimate 'Sum Basketball vs Sum Football & Soccer & Swimming & Tennis' Sport 4 -1 -1 -1 -1;
run;

proc glm data = sports;
class Sport;
model Height = Sport;
means Sport / hovtest = bf;
lsmeans Sport / pdiff adjust = bon cl;
run;