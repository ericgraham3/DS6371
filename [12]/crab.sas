proc import datafile="/home/u63869883/6371.12/Crab17.csv"
    out=crabs
    dbms=csv
    replace;
    getnames=yes;
run;

data crabs;
    set crabs;

    if Species = 'Hemigrapsus nudus' then number = 1;
    else if Species = 'Lophopanopeus bellus' then number = 2;
    else if Species = 'Cancer productus' then number = 3;

    if Species = 'Hemigrapsus nudus' then name = 'H';
    else if Species = 'Lophopanopeus bellus' then name = 'L';
    else if Species = 'Cancer productus' then name = 'C';
run;

/* Symbols for each species group */
symbol1 v='H' c=black i=none;
symbol2 v='L' c=red i=none;
symbol3 v='C' c=blue i=none;

title 'Crab Species Force by Height';
proc gplot data=crabs;
    plot Force*Height=name;
run;

proc reg data = crabs;
model Force = Height number;
run;

data crabs2;
set crabs;
	if Species = 'Hemigrapsus nudus' then d1 = 1; else d1 = 0;
	if Species = 'Cancer productus' then d2 = 1; else d2 = 0;
	int1 = d1*Height; int2 = d2*Height;
	run;
	
	
title 'Regression of Force with Interaction Terms';
proc reg data=crabs2;
	model Force = Height d1 d2 int1 int2 /VIF CLB;
	run;