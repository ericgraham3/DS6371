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
                                                                                                                                                                                                                             
* To get the observed difference;                                                                                                                                                                                            
proc ttest data=discrimination;  * You will need to change the dataset name here.;                                                                                                                                                     
                                                                                                                                                                                                                             
   class fired;    *and change the class variable to match yours here;                                                                                                                                                  
                                                                                                                                                                                                                             
   var age;          * and change the var name here.;                                                                                                                                                                      
                                                                                                                                                                                                                             
run;                                                                                                                                                                                                                         

ods output off;
ods exclude all;
                                                                                                                                                                                                                         
*borrowed code from internet ... randomizes observations and creates a matrix ... one row per randomization ;                                                                                                                
proc iml;                                                                                                                                                                                                                    
use discrimination;                        * change data set name here to match your data set name above;                                                                                                                              
read all var{fired age} into x;   *change varibale names here ... make sure it is class then var ... in that order.;                                                                                                  
p = t(ranperm(x[,2],1000));    *Note that the "1000" here is the number of permutations. ;                                                                                                                                    
paf = x[,1]||p;                                                                                                                                                                                                              
create newds from paf;                                                                                                                                                                                                       
append from paf;                                                                                                                                                                                                             
quit;                                                                                                                                                                                                                        
                                                                                                                                                                                                                             
*calculates differences and creates a histogram;                                                                                                                                                                             
ods output conflimits=diff;                                                                                                                                                                                                  
proc ttest data=newds plots=none;                                                                                                                                                                                            
  class col1;                                                                                                                                                                                                                
  var col2 - col1001;                                                                                                                                                                                                        
run;                                                                                                                                                                                                                         

ods output on;
ods exclude none;       
                  
proc univariate data=diff;                                                                                                                                                                                                   
  where method = "Pooled";                                                                                                                                                                                                   
  var mean;                                                                                                                                                                                                                  
  histogram mean;                                                                                                                                                                                                            
run;                                                                                                                                                                                                                         
                                                                                                                                                                                  
*The code below calculates the number of randomly generated differences that are as extreme or more extreme thant the one observed (divide this number by 1000 you have the pvalue);                                         
*check the log to see how many observations are in the data set.... divide this by 1000 (or however many permutations you generated) and that is the (one sided)p-value;                                                     
data numdiffs;                                                                                                                                                                                                               
set diff;                                                                                                                                                                                                                    
where method = "Pooled";                                                                                                                                                                                                     
if abs(mean) >= 1.9238;   *you will need to put the observed difference you got from t test above here.  note if you have a one or two tailed test.;                                                                           
run;                                                                                                                                                                                                                         
* just a visual of the rows produced ... you can get the number of obersvations from the last data step and the Log window.;                                                                                                 
proc print data = numdiffs;                                                                                                                                                                                                  
where method = "Pooled";                                                                                                                                                                                                     
run;                                                                                                                                                                                                                         
                                                                                                                                                                                                                             
                                                                                                                                                                                                                             
*Idea from http://sas-and-r.blogspot.com/2011/10/example-912-simpler-ways-to-carry-out.html ;                                                                                                                                
                              