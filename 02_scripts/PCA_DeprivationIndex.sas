dm log "clear";

/*proc import datafile="S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Aim 2\full_dep_ds.csv"*/
/*	out = dep_ds*/
/*	dbms = csv*/
/*	replace;*/
/*	guessingrows=max;*/
/*run;*/

* PCA;
/*proc factor data = dep_ds method = principal nfactors=1 scree outstat= PCA_dep1;*/
/*	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;*/
/*	Title1 '1 Factor Deprivation Index - before rotation';*/
/*run;*/

proc factor data = dep_ds method = principal scree rotate = varimax outstat= PCA_dep;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 'No Factors: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=1 rotate = varimax outstat= PCA_dep;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '1 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=2 rotate = varimax outstat= PCA_dep;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '2 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=3 rotate = varimax outstat= PCA_dep3;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '3 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=4 rotate = varimax outstat= PCA_dep4;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '4 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=5 rotate = varimax outstat= PCA_dep5;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '5 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=6 rotate = varimax outstat= PCA_dep6;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '6 Factor: Deprivation Index - after rotation';
run;

proc factor data = dep_ds method = principal scree nfactors=7 rotate = varimax outstat= PCA_dep6;
	var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
	Title1 '7 Factor: Deprivation Index - after rotation';
run;




* alpha;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei malei asian_pacislanderi blacki otheri whitei hispi age_ge65i veterani foreign_born_ct not_citizen_ct nohsgrad_25plusi noenrolledinschool_3plusi singledadi singlemomi nonfam_householdsi moved_1yr_ct commute_60minplusi publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi unemployedi med_houseincomei percapita_incomei gini_ct households_w_publicassisti socsecinsuri vacanti occupantsperroomi renter_occupiedi no_mortgagei no_telephonei no_vehiclei no_heati lack_plumbingi lack_kitcheni house_unitsi;
TITLE "Full 39 Vars - Chronbach's Alpha of Deprivation Index";
run;

************ 3 Factor - Before Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki hispi nohsgrad_25plusi singlemomi belowpovertylinei householder45plus_povertyi famkids_povertyi households_w_publicassisti vacanti renter_occupiedi no_vehiclei lack_plumbingi lack_kitcheni;
TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i veterani noenrolledinschool_3plusi socsecinsuri vacanti no_mortgagei lack_plumbingi lack_kitcheni;
TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi foreign_born_ct not_citizen_ct foreign_langi med_houseincomei;
TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 2 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei percapita_incomei;
TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var malei;*/
/*TITLE "Before Rotation: 3 Factor Solution Chronbach's Alpha - 3 (Negative)";*/
/*run;*/

************ 3 Factor - After Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki hispi nohsgrad_25plusi singlemomi belowpovertylinei householder45plus_povertyi famkids_povertyi households_w_publicassisti vacanti renter_occupiedi no_vehiclei lack_plumbingi lack_kitcheni;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi hispi foreign_born_ct not_citizen_ct moved_1yr_ct foreign_langi;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei age_ge65i veterani socsecinsuri;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 2 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei blacki nonfam_householdsi publtrans_bike_walki gini_ct renter_occupiedi no_vehiclei;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var malei whitei;
TITLE "After Rotation: 3 Factor Solution Chronbach's Alpha - 3 (Negative)";
run;



************ 4 Factor - Before Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki hispi not_citizen_ct nohsgrad_25plusi singlemomi nonfam_householdsi moved_1yr_ct publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi gini_ct households_w_publicassisti renter_occupiedi no_vehiclei lack_kitcheni;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i veterani noenrolledinschool_3plusi socsecinsuri vacanti no_mortgagei lack_plumbingi lack_kitcheni;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi foreign_born_ct not_citizen_ct foreign_langi med_houseincomei;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 2 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei percapita_incomei;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var malei;*/
/*TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 3 (Negative)";*/
/*run;*/

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var malei nonfam_householdsi moved_1yr_ct;
TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 4 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var femalei;*/
/*TITLE "Before Rotation: 4 Factor Solution Chronbach's Alpha - 4 (Negative)";*/
/*run;*/

************ 4 Factor - After Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki hispi nohsgrad_25plusi singlemomi foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi households_w_publicassisti no_vehiclei;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki nonfam_householdsi moved_1yr_ct publtrans_bike_walki belowpovertylinei householder45plus_povertyi gini_ct renter_occupiedi no_vehiclei lack_kitcheni;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 2 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi hispi foreign_born_ct not_citizen_ct foreign_langi;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i veterani noenrolledinschool_3plusi socsecinsuri no_mortgagei;
TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 3 (Negative)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var femalei;*/
/*TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 4 (Positive)";*/
/*run;*/
/**/
/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var malei;*/
/*TITLE "After Rotation: 4 Factor Solution Chronbach's Alpha - 4 (Negative)";*/
/*run;*/



************ 5 Factor - Before Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki hispi not_citizen_ct nohsgrad_25plusi singlemomi nonfam_householdsi moved_1yr_ct publtrans_bike_walki foreign_langi belowpovertylinei householder45plus_povertyi famkids_povertyi gini_ct households_w_publicassisti renter_occupiedi no_vehiclei lack_kitcheni;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i veterani noenrolledinschool_3plusi socsecinsuri vacanti no_mortgagei lack_plumbingi lack_kitcheni;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi foreign_born_ct not_citizen_ct foreign_langi med_houseincomei;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 2 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei percapita_incomei;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var malei;*/
/*TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 3 (Negative)";*/
/*run;*/

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var malei nonfam_householdsi moved_1yr_ct;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 4 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var femalei;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 4 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i noenrolledinschool_3plusi socsecinsuri;
TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 5 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var ;*/
/*TITLE "Before Rotation: 5 Factor Solution Chronbach's Alpha - 5 (Negative)";*/
/*run;*/

************ 5 Factor - After Rotation;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var blacki nohsgrad_25plusi singlemomi belowpovertylinei householder45plus_povertyi famkids_povertyi households_w_publicassisti vacanti no_vehiclei lack_plumbingi lack_kitcheni;
TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 1 (Positive)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var whitei med_houseincomei percapita_incomei;
TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 1 (Negative)";
run;

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var asian_pacislanderi foreign_born_ct not_citizen_ct nonfam_householdsi moved_1yr_ct publtrans_bike_walki belowpovertylinei gini_ct renter_occupiedi no_vehiclei;
TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 2 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var whitei;*/
/*TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 2 (Negative)";*/
/*run;*/

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var hispi foreign_born_ct not_citizen_ct nohsgrad_25plusi foreign_langi;
TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 3 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var ;*/
/*TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 3 (Negative)";*/
/*run;*/

proc corr data = dep_ds alpha nomiss nocorr nosimple;
var age_ge65i veterani noenrolledinschool_3plusi socsecinsuri no_mortgagei;
TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 4 (Positive)";
run;

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var ;*/
/*TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 4 (Negative)";*/
/*run;*/

/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var femalei;*/
/*TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 5 (Positive)";*/
/*run;*/
/**/
/*proc corr data = dep_ds alpha nomiss nocorr nosimple;*/
/*var malei;*/
/*TITLE "After Rotation: 5 Factor Solution Chronbach's Alpha - 5 (Negative)";*/
/*run;*/






