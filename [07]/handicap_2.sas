proc import datafile="/home/u63869883/6371.07/Unit 7 Handicap Data.csv"
	out=handicap_data
	dbms=csv
	replace;
	getnames=yes;
run;

proc glm data = handicap_data;
    class Handicap;
    model Score = Handicap;

    means Handicap / lsd;
    means Handicap / Dunnett;
    means Handicap / tukey;
    means Handicap / bon;
    means Handicap / Scheffe;
run;
