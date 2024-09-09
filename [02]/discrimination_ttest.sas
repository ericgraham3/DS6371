data discrimination;                                                                                                                           
input fired age;   /* 1 is fired and 0 is not fired */                                                                                                                                                                                                     
datalines;                                                                                                                                                                                                                   
1 34
1 37
1 37
1 38
1 41
1 42
1 43
1 44
1 44
1 45
1 45
1 45
1 46
1 48
1 49
1 53
1 53
1 54
1 54
1 55
1 56
0 27
0 33
0 36
0 37
0 38
0 38
0 39
0 42
0 42
0 43
0 43
0 44
0 44
0 44
0 45
0 45
0 45
0 45
0 46
0 46
0 47
0 47
0 48
0 48
0 49
0 49
0 51
0 51
0 52
0 54
;                                                                                                                                                                                                                            
                                                                                                                                                                                                                             
data critval;
p = quantile("T",.975,51)
;

proc print data = critval;
run;
                                                                                                                                                                                       
proc ttest data=discrimination;  * You will need to change the dataset name here.;                                                                                                                                                     
                                                                                                                                                                                                                             
   class fired;    *and change the class variable to match yours here;                                                                                                                                                  
                                                                                                                                                                                                                             
   var age;          * and change the var name here.;                                                                                                                                                                      
                                                                                                                                                                                                                             
run; 