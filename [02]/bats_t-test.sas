data bats;
input weight;
datalines;
23
54
45
56
21
68
45
;

proc ttest data = bats side = u ho = 40;
var weight;
run;