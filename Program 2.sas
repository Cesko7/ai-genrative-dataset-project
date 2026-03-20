proc import datafile='/home/u64181877/generated_survey_data_lower_loc_alpha.csv' 
    out=work.survey_data
    dbms=csv
    replace;
    getnames=yes;
run;

/* data survey_data_summary;
    set survey_data;
    
proc contents data=survey_data_summary;
run;	*/

data survey_data_summary;
    set survey_data;
    
        label 
        id = 'Participant ID'
        intervention = 'Intervention Group (1=Intervention, 0=Comparison)'
        sex = 'Sex (1=Male, 0=Female)'
        age = 'Age of Participant'
        college = 'College (1-4)'
        year = 'Year (1=Freshman, 2=Sophomore, 3=Junior, 4=Senior)'
        loc_1_bl = 'LOC Item 1 at Baseline'
        loc_2_bl = 'LOC Item 2 at Baseline'
        loc_3_bl = 'LOC Item 3 at Baseline'
        loc_4_bl = 'LOC Item 4 at Baseline'
        loc_5_bl = 'LOC Item 5 at Baseline'
        loc_6_bl = 'LOC Item 6 at Baseline'
        loc_7_bl = 'LOC Item 7 at Baseline'
        loc_8_bl = 'LOC Item 8 at Baseline'
        loc_9_bl = 'LOC Item 9 at Baseline'
        loc_10_bl = 'LOC Item 10 at Baseline'
        loc_1_fu = 'LOC Item 1 at Follow-up'
        loc_2_fu = 'LOC Item 2 at Follow-up'
        loc_3_fu = 'LOC Item 3 at Follow-up'
        loc_4_fu = 'LOC Item 4 at Follow-up'
        loc_5_fu = 'LOC Item 5 at Follow-up'
        loc_6_fu = 'LOC Item 6 at Follow-up'
        loc_7_fu = 'LOC Item 7 at Follow-up'
        loc_8_fu = 'LOC Item 8 at Follow-up'
        loc_9_fu = 'LOC Item 9 at Follow-up'
        loc_10_fu = 'LOC Item 10 at Follow-up'
        eff_1_bl = 'Self-Efficacy Item 1 at Baseline'
        eff_2_bl = 'Self-Efficacy Item 2 at Baseline'
        eff_3_bl = 'Self-Efficacy Item 3 at Baseline'
        eff_4_bl = 'Self-Efficacy Item 4 at Baseline'
        eff_5_bl = 'Self-Efficacy Item 5 at Baseline'
        eff_1_fu = 'Self-Efficacy Item 1 at Follow-up'
        eff_2_fu = 'Self-Efficacy Item 2 at Follow-up'
        eff_3_fu = 'Self-Efficacy Item 3 at Follow-up'
        eff_4_fu = 'Self-Efficacy Item 4 at Follow-up'
        eff_5_fu = 'Self-Efficacy Item 5 at Follow-up'
        loc_baseline_total = 'Total LOC Score at Baseline (Sum of LOC Items)'
        loc_followup_total = 'Total LOC Score at Follow-up (Sum of LOC Items)'
        se_baseline_total = 'Total Self-Efficacy Score at Baseline (Sum of Self-Efficacy Items)'
        se_followup_total = 'Total Self-Efficacy Score at Follow-up (Sum of Self-Efficacy Items)'
        intervention_group = 'Dummy Variable for Intervention Group (1=Intervention, 0=Comparison)'
        comparison_group = 'Dummy Variable for Comparison Group (1=Comparison, 0=Intervention)';
    
    /* Reverse code LOC items 5, 6, 7 at baseline */
    loc_5_bl_r = 6 - loc_5_bl;
    loc_6_bl_r = 6 - loc_6_bl;
    loc_7_bl_r = 6 - loc_7_bl;
    
    label loc_5_bl_r = 'Reverse coded item 5 at baseline'
          loc_6_bl_r = 'Reverse coded item 6 at baseline'
          loc_7_bl_r = 'Reverse coded item 7 at baseline';

/*proc freq data=survey_data_summary;
tables loc_5_bl loc_5_bl_r loc_5_bl*loc_5_bl_r
loc_6_bl loc_6_bl_r loc_6_bl*loc_6_bl_r
loc_7_bl loc_7_bl_r loc_7_bl*loc_7_bl_r/list missing;
run;	*/

    /* Reverse code LOC items 5, 6, 7 at follow-up */
    loc_5_fu_r = 6 - loc_5_fu;
    loc_6_fu_r = 6 - loc_6_fu;
    loc_7_fu_r = 6 - loc_7_fu;
    
    label loc_5_fu_r = 'Reverse coded item 5 at follow-up'
          loc_6_fu_r = 'Reverse coded item 6 at follow-up'
          loc_7_fu_r = 'Reverse coded item 7 at follow-up';
          
/*proc freq data=survey_data_summary;
tables loc_5_fu loc_5_fu_r loc_5_fu*loc_5_fu_r
loc_6_fu loc_6_fu_r loc_6_fu*loc_6_fu_r
loc_7_fu loc_7_fu_r loc_7_fu*loc_7_fu_r/list missing;
run;	*/

	/* Create dummy variables for college */
    if college = 1 then state_c = 1; else state_c = 0;
    if college = 2 then state_u = 1; else state_u = 0;
    if college = 3 then private_c = 1; else private_c = 0;
    if college = 4 then private_u = 1; else private_u = 0;
    
    label state_c = 'State College Dummy'
    	  state_u = 'State University Dummy'
    	  private_c = 'Private College Dummy'
    	  private_u = 'Private University Dummy';
    	  
/* proc freq data=survey_data_summary;
tables college state_c college*state_c
college state_u college*state_u
college private_c college*private_c
college private_u college*private_u/list missing;
run;	*/

    /* Create dummy variables for year */
    if year = 1 then freshman = 1; else freshman = 0;
    if year = 2 then sophomore = 1; else sophomore = 0;
    if year = 3 then junior = 1; else junior = 0;
    if year = 4 then senior = 1; else senior = 0;
    
    label freshman = 'Freshman Dummy'
    	  sophomore = 'Sophomore Dummy'
    	  junior = 'Junior Dummy'
    	  senior = 'Senior Dummy';
    	
/* proc freq data=survey_data_summary;
tables year freshman year*freshman
year sophomore year*sophomore
year junior year*junior
year senior year*senior/list missing;
run;	*/
    
    /* look up summing vs adding variables due to missing data, also proc print fu and eff */
    /* LOC: sum of 10 items */
    loc_baseline_total = sum(loc_1_bl, loc_2_bl, loc_3_bl, loc_4_bl, loc_5_bl_r, loc_6_bl_r, loc_7_bl_r, loc_8_bl, loc_9_bl, loc_10_bl);
    loc_followup_total = sum(loc_1_fu, loc_2_fu, loc_3_fu, loc_4_fu, loc_5_fu_r, loc_6_fu_r, loc_7_fu_r, loc_8_fu, loc_9_fu, loc_10_fu);

    /* SE: sum of 5 items */
    se_baseline_total = sum(eff_1_bl, eff_2_bl, eff_3_bl, eff_4_bl, eff_5_bl);
    se_followup_total = sum(eff_1_fu, eff_2_fu, eff_3_fu, eff_4_fu, eff_5_fu);
    
    /* Calculate the average for LOC items at baseline and follow-up */
    loc_baseline_avg = mean(of loc_1_bl--loc_10_bl);
    loc_followup_avg = mean(of loc_1_fu--loc_10_fu);
    
    /* Calculate the average for SE items at baseline and follow-up */
    se_baseline_avg = mean(of eff_1_bl--eff_5_bl);
    se_followup_avg = mean(of eff_1_fu--eff_5_fu);
    
    /* Calculate the change score for LOC and SE */
    loc_change = loc_followup_total - loc_baseline_total;
    se_change = se_followup_total - se_baseline_total;
run;

/* Summary Stats. */
proc means data=survey_data_summary n mean;
    var loc_baseline_total loc_followup_total se_baseline_total se_followup_total;
run;

/* Perform t-tests for LOC and SE at baseline */
proc ttest data=survey_data_summary;
    class intervention;  /* Grouping variable for intervention vs. comparison */
    var loc_baseline_total se_baseline_total;  /* Variables for which we perform the t-test */
run;

proc ttest data=survey_data_summary;
    class intervention;  /* Grouping variable for intervention vs. comparison */
    var loc_followup_total se_followup_total;  /* Variables for which we perform the t-test */
run;

/* Check for normaility */
proc univariate data=survey_data_summary normal;
    var loc_baseline_total loc_followup_total se_baseline_total se_followup_total;
    histogram / normal;
    inset mean std skew kurtosis / position=ne;
run;

/* For calculating Cronbach's Alpha for LOC items at baseline and follow-up */
proc corr data=survey_data_summary alpha;
    var loc_1_bl loc_2_bl loc_3_bl loc_4_bl loc_5_bl_r loc_6_bl_r loc_7_bl_r loc_8_bl loc_9_bl loc_10_bl;
run;

/* For calculating Cronbach's Alpha for SE items at baseline and follow-up */
proc corr data=survey_data_summary alpha;
    var eff_1_bl eff_2_bl eff_3_bl eff_4_bl eff_5_bl;
run;

/* Regression models, ignore limited range of outcome variable */

/*proc reg */

/* effect of inter. controlling for bl (lagged dept. variable model) */
proc glm data=survey_data_summary;
    class college;  /* Classify the cluster variable, e.g., college */
    model loc_baseline_total loc_followup_total = intervention sex age year;
    random college; /* Account for clustering by college */
run;

proc surveyreg data=survey_data_summary;
    cluster college;  /* Cluster variable */
    strata year;  /* Stratification variable */
    model loc_baseline_total = intervention sex age; /* Model with covariates */
run;

proc genmod data=survey_data_summary;
    class college id;  /* Clustering variable */
    model loc_followup_total = intervention loc_baseline_total sex age sophomore junior senior state_u private_c private_u / dist=normal link=identity;
    repeated subject=college / type=ar(1); /* Type specifies the correlation structure (exchangeable in this case) */
run;

proc reg data=survey_data_summary;
	model loc_followup_total = intervention loc_baseline_total sex age sophomore junior senior state_u private_c private_u;
run;

proc genmod data=survey_data_summary;
    class college id;  /* Clustering variable */
    model se_followup_total = intervention se_baseline_total sex age sophomore junior senior state_u private_c private_u / dist=normal link=identity;
    repeated subject=college / type=exch; /* Type specifies the correlation structure (exchangeable in this case) */
run;

proc reg data=survey_data_summary;
	model se_followup_total = intervention se_baseline_total sex age sophomore junior senior state_u private_c private_u;
run;

proc reg data=survey_data_summary;
	model loc_followup_total = intervention loc_baseline_total;
run;

/* Regression Models End. */
/* Additional Summary Stats. */
proc means data=survey_data_summary mean;
    var loc_baseline_avg loc_followup_avg se_baseline_avg se_followup_avg;
run;

proc contents data=survey_data_summary;
run;

proc print data=survey_data_summary(obs=50);
    var loc_baseline_total loc_followup_total se_baseline_total se_followup_total;
run;
