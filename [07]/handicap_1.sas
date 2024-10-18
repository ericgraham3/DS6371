proc import datafile="/home/u63869883/6371.07/Unit 7 Handicap Data.csv" 
		out=handicap_data dbms=csv replace;
	getnames=yes;
run;

proc glm data=handicap_data;
	class Handicap;
	model Score=Handicap;
	means Handicap / hovtest=bf bon cldiff;
	contrast "amputee - crutches" Handicap 1 -1 0 0 0;
	contrast "amputee - wheelchair" Handicap 1 0 0 0 -1;
	contrast "crutches - wheelchair" Handicap 0 1 0 0 -1;
	run;
