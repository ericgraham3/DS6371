proc import datafile="/home/u63869883/6371.11/Metabolism Data Prob 26.csv"
    out=metabolism_data
    dbms=csv
    replace;
    getnames=yes;
run;

data metabolism_data;
    set metabolism_data;
    Mass_3_4 = Mass**(3/4);
run;

proc sgplot data=metabolism_data;
    scatter x=Mass_3_4 y=Metab;
    reg x=Mass_3_4 y=Metab / clm cli;
    xaxis label="Mass^(3/4)";
    yaxis label="Metabolic Rate";
    title "Scatter Plot of Metabolic Rate vs. Mass^(3/4)";
run;

proc reg data=metabolism_data;
    model Metab = Mass_3_4;
    output out=residual_data r=residual p=predicted;
    title "Linear Regression Model for Metabolic Rate vs. Mass^(3/4)";
run;

proc sgplot data=residual_data;
    scatter x=predicted y=residual;
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    xaxis label="Predicted Metabolic Rate";
    yaxis label="Residuals";
    title "Scatterplot of Residuals (Original Data)";
run;

proc univariate data=residual_data normal;
    var residual;
    histogram residual / normal kernel;
    inset mean std / format=5.2;
    title "Histogram of Residuals (Original Data)";
run;

data metabolism_data;
    set metabolism_data;
    log_Mass_3_4 = log(Mass_3_4);
    log_Metab = log(Metab);
run;

proc sgplot data=metabolism_data;
    scatter x=log_Mass_3_4 y=log_Metab;
    reg x=log_Mass_3_4 y=log_Metab / clm cli;
    xaxis label="Log(Mass^(3/4))";
    yaxis label="Log(Metabolic Rate)";
    title "Scatter Plot of Log(Metabolic Rate) vs. Log(Mass^(3/4))";
run;

proc reg data=metabolism_data;
    model log_Metab = log_Mass_3_4 /clb;
    output out=residual_data_log r=residual_log p=predicted_log;
    title "Linear Regression Model for Log Transformed Data";
run;

proc sgplot data=residual_data_log;
    scatter x=predicted_log y=residual_log;
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    xaxis label="Predicted Log(Metabolic Rate)";
    yaxis label="Residuals (Log Data)";
    title "Scatterplot of Residuals (Log Transformed Data)";
run;

proc univariate data=residual_data_log normal;
    var residual_log;
    histogram residual_log / normal kernel;
    inset mean std / format=5.2;
    title "Histogram of Residuals (Log Transformed Data)";
run;