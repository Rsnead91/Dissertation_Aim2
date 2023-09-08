dm log 'clear';

libname ds "C:\Users\tuk04132\OneDrive - Temple University\Documents\ACS Data Test";

proc contents data = ds.acs_06_10 varnum; run;

data ds.acs_06_10;
  set ds.acs_06_10;
	year1 = "2006";
	year2 = "2010";
run;

data ds.acs_07_11;
  set ds.acs_07_11;
	year1 = "2007";
	year2 = "2011";
run;

data ds.acs_08_12;
  set ds.acs_08_12;
	year1 = "2008";
	year2 = "2012";
run;

data ds.acs_09_13;
  set ds.acs_09_13;
	year1 = "2009";
	year2 = "2013";
run;

data ds.acs_10_14;
  set ds.acs_10_14;
	year1 = "2010";
	year2 = "2014";
run;

data ds.acs_11_15;
  set ds.acs_11_15;
	year1 = "2011";
	year2 = "2015";
run;

data ds.acs_12_16;
  set ds.pabg12_16;
	year1 = "2012";
	year2 = "2016";
	%rename;
run;

data ds.acs_13_17;
  set ds.acs_13_17;
	year1 = "2013";
	year2 = "2017";
run;

data ds.acs_14_18;
  set ds.acs_14_18;
	year1 = "2014";
	year2 = "2018";
run;

data ds.acs_15_19;
  set ds.pabg15_19;
	year1 = "2015";
	year2 = "2019";
	%rename;
run;

libname acs "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

data acs.acs_raw;
  set ds.acs_06_10
      ds.acs_07_11
      ds.acs_08_12
      ds.acs_09_13
      ds.acs_10_14
      ds.acs_11_15
      ds.acs_12_16
      ds.acs_13_17
      ds.acs_14_18
	  ds.acs_15_19
  ;
run;

/*proc options option = work; run;*/


%macro bgvars;

	/*Total Population*/

	total_pop = B01001001; /*Total Population*/
	label total_pop = "Count of Total Population";

	total_pop_u = B01001001 + B01001001s; /*Total Population*/
	label total_pop_u = "[Margin of Error]Count of Total Population - Upper";

	total_pop_l = B01001001 - B01001001s; /*Total Population*/
	label total_pop_l = "[Margin of Error]Count of Total Population - Lower";




	/*Age*/

	age_45_74 = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		);

	label age_45_74 = "Count of population ages 45 to 74 years";

	age_45_74_u = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		) + 
		sum(
			B01001015s, /*Male: 45 to 49 Years*/
			B01001016s, /*Male: 50 to 54 Years*/
			B01001017s, /*Male: 55 to 59 Years*/
			B01001018s, /*Male: 60 and 61 Years*/
			B01001019s, /*Male: 62 to 64 Years*/
			B01001020s, /*Male: 65 and 66 Years*/
			B01001021s, /*Male: 67 to 69 Years*/
			B01001022s, /*Male: 70 to 74 Years*/
			B01001039s, /*Female: 45 to 49 Years*/
			B01001040s, /*Female: 50 to 54 Years*/
			B01001041s, /*Female: 55 to 59 Years*/
			B01001042s, /*Female: 60 and 61 Years*/
			B01001043s, /*Female: 62 to 64 Years*/
			B01001044s, /*Female: 65 and 66 Years*/
			B01001045s, /*Female: 67 to 69 Years*/
			B01001046s  /*Female: 70 to 74 Years*/
		);

	label age_45_74_u = "[Margin of Error]Count of population ages 45 to 74 years - Upper";

	age_45_74_l = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		) - 
		sum(
			B01001015s, /*Male: 45 to 49 Years*/
			B01001016s, /*Male: 50 to 54 Years*/
			B01001017s, /*Male: 55 to 59 Years*/
			B01001018s, /*Male: 60 and 61 Years*/
			B01001019s, /*Male: 62 to 64 Years*/
			B01001020s, /*Male: 65 and 66 Years*/
			B01001021s, /*Male: 67 to 69 Years*/
			B01001022s, /*Male: 70 to 74 Years*/
			B01001039s, /*Female: 45 to 49 Years*/
			B01001040s, /*Female: 50 to 54 Years*/
			B01001041s, /*Female: 55 to 59 Years*/
			B01001042s, /*Female: 60 and 61 Years*/
			B01001043s, /*Female: 62 to 64 Years*/
			B01001044s, /*Female: 65 and 66 Years*/
			B01001045s, /*Female: 67 to 69 Years*/
			B01001046s  /*Female: 70 to 74 Years*/
		);

	label age_45_74_l = "[Margin of Error]Count of population ages 45 to 74 years - Lower";





		age_ge65 = 
			sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) / 
			B01001001 /*Total Population*/;

		label age_ge65 = "Percent of population ages 65 years and older";

		age_ge65_u = 
			(sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) + 
			sum(
				B01001020s, /*Male: 65 and 66 Years*/
				B01001021s, /*Male: 67 to 69 Years*/
				B01001022s, /*Male: 70 to 74 Years*/
				B01001023s, /*Male: 75 to 79 Years*/
				B01001024s, /*Male: 80 to 84 Years*/
				B01001025s, /*Male: 85 Years and Over*/
				B01001044s, /*Female: 65 and 66 Years*/
				B01001045s, /*Female: 67 to 69 Years*/
				B01001046s, /*Female: 70 to 74 Years*/
				B01001047s, /*Female: 75 to 79 Years*/
				B01001048s, /*Female: 80 to 84 Years*/
				B01001049s  /*Female: 85 Years and Over*/
			)) / 
			B01001001 /*Total Population*/;

		label age_ge65_u = "[Margin of Error]Percent of population ages 65 years and older - Upper";

		age_ge65_l = 
			(sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) - 
			sum(
				B01001020s, /*Male: 65 and 66 Years*/
				B01001021s, /*Male: 67 to 69 Years*/
				B01001022s, /*Male: 70 to 74 Years*/
				B01001023s, /*Male: 75 to 79 Years*/
				B01001024s, /*Male: 80 to 84 Years*/
				B01001025s, /*Male: 85 Years and Over*/
				B01001044s, /*Female: 65 and 66 Years*/
				B01001045s, /*Female: 67 to 69 Years*/
				B01001046s, /*Female: 70 to 74 Years*/
				B01001047s, /*Female: 75 to 79 Years*/
				B01001048s, /*Female: 80 to 84 Years*/
				B01001049s  /*Female: 85 Years and Over*/
			)) / 
			B01001001 /*Total Population*/;

		label age_ge65_l = "[Margin of Error]Percent of population ages 65 years and older - Lower";





	/*Sex*/

	male = 
		B01001002 /*Males*/ / 
		B01001001 /*Total Population*/;

	label male = "Proportion of geographic unit who are male";

	male_u = 
		(B01001002 + B01001002s) /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_u = "[Margin of Error]Proportion of geographic unit who are male - Upper";

	male_l = 
		(B01001002 - B01001002s) /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_l = "[Margin of Error]Proportion of geographic unit who are male - Lower";





	female = 
		B01001026 /*Females*/ / 
		B01001001 /*Total Population*/;

	label female = "Proportion of geographic unit who are female";

	female_u = 
		(B01001026 + B01001026s) /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_u = "[Margin of Error]Proportion of geographic unit who are female - Upper";

	female_l = 
		(B01001026 - B01001026s) /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_l = "[Margin of Error]Proportion of geographic unit who are female - Lower";




	/*Race*/

	white = 
		B02001002 /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white = "Proportion of geographic unit who are recorded as White";

	white_u = 
		(B02001002 + B02001002s) /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_u = "[Margin of Error]Proportion of geographic unit who are recorded as White - Upper";

	white_l = 
		(B02001002 - B02001002s) /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_l = "[Margin of Error]Proportion of geographic unit who are recorded as White - Lower";




	black = 
		B02001003 /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black = "Proportion of geographic unit who are recorded as Black";

	black_u = 
		(B02001003 + B02001003s) /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_u = "[Margin of Error]Proportion of geographic unit who are recorded as Black - Upper";

	black_l = 
		(B02001003 - B02001003s) /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_l = "[Margin of Error]Proportion of geographic unit who are recorded as Black - Lower";





	asian_pacislander = 
	   (B02001005 /*Asian Alone*/ + 
		B02001006 /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		B01001001 /*Total Population*/; 

	label asian_pacislander = "Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";

	asian_pacislander_u = 
	   ((B02001005 + B02001005s) /*Asian Alone*/ + 
		(B02001006 + B02001006s) /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		 B01001001 /*Total Population*/; 

	label asian_pacislander_u = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander - Upper";

	asian_pacislander_l = 
	   ((B02001005 - B02001005s) /*Asian Alone*/ + 
		(B02001006 - B02001006s) /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		 B01001001 /*Total Population*/; 

	label asian_pacislander_l = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander - Lower";






	other = 
	   (B02001004 /*American Indian and Alaska Native Alone*/ + 
		B02001009 /*Two or More Races: Two Races Including Some Other Race*/) / 
		B01001001 /*Total Population*/;

	label other = "Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";

	other_u = 
	   ((B02001004 + B02001004s) /*American Indian and Alaska Native Alone*/ + 
		(B02001009 + B02001009s) /*Two or More Races: Two Races Including Some Other Race*/) / 
		 B01001001 /*Total Population*/;

	label other_u = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race - Upper";

	other_l = 
	   ((B02001004 - B02001004s) /*American Indian and Alaska Native Alone*/ + 
		(B02001009 - B02001009s) /*Two or More Races: Two Races Including Some Other Race*/) / 
		 B01001001 /*Total Population*/;

	label other_l = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race - Lower";




	/*Ethnicity*/

	hisp = 
		B03002012 /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp = "Proportion of geographic unit who are reported as Hispanic or Latino";

	hisp_u = 
		(B03002012 + B03002012s) /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_u = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino - Upper";

	hisp_l = 
		(B03002012 - B03002012s) /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_l = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino - Lower";




	/*School enrollment (3+)*/

	noenrolledinschool_3plus = 
	   (B14002025 /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		B14002049 /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus = "Proportion of Population 3+ Not Enrolled in School";

	noenrolledinschool_3plus_u = 
	   ((B14002025 + B14002025s) /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		(B14002049 + B14002049s) /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		 B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_u = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School - Upper";

	noenrolledinschool_3plus_l = 
	   ((B14002025 - B14002025s) /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		(B14002049 - B14002049s) /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		 B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_l = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School - Lower";





	/*Educational Attainment (25+)*/

	nohsgrad_25plus =
	   (B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus = "Proportion of Population 25+ who did not Graduate High School ";

	nohsgrad_25plus_u =
	   ((B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) +
	   (B15002003s /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004s /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005s /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006s /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007s /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008s /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009s /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010s /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020s /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021s /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022s /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023s /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024s /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ )) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus_u = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School - Upper";

	nohsgrad_25plus_l =
	   ((B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) -
	   (B15002003s /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004s /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005s /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006s /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007s /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008s /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009s /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010s /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020s /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021s /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022s /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023s /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024s /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ )) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus_l = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School - Lower";





	/*Employment status*/

	unemployed = 	
		(B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ )/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed = "Proportion of families with an unemployed parent";

	unemployed_u = 
		((B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ) +
		(B23007008s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024s + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029s + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053s + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ))/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_u = "[Margin of Error]Proportion of families with an unemployed parent - Upper";

	unemployed_l = 
		((B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ) -
		(B23007008s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024s + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029s + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053s + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ))/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_l = "[Margin of Error]Proportion of families with an unemployed parent - Lower";




	/*Median Household income*/

	med_houseincome = B19013001;

	label med_houseincome = "Median Household Income";

	med_houseincome_u = B19013001 + B19013001s;

	label med_houseincome_u = "[Margin of Error]Median Household Income - Upper";

	med_houseincome_l = B19013001 - B19013001s;

	label med_houseincome_l = "[Margin of Error]Median Household Income - Lower";





	/*Public assistance*/

	households_w_publicassist = 
		B19057002 /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist = "Proportion of Households with Public Assistance Income";

	households_w_publicassist_u = 
		(B19057002 + B19057002s) /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_u = "[Margin of Error]Proportion of Households with Public Assistance Income - Upper";

	households_w_publicassist_l = 
		(B19057002 - B19057002s) /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_l = "[Margin of Error]Proportion of Households with Public Assistance Income - Lower";







	/*Social security income*/

	socsecinsur = 
		B19055002 /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur = "Proportion with social security income";

	socsecinsur_u = 
		(B19055002 + B19055002s) /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_u = "[Margin of Error]Proportion with social security income - Upper";

	socsecinsur_l = 
		(B19055002 - B19055002s) /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_l = "[Margin of Error]Proportion with social security income - Lower";





	/*Poverty status*/

	belowpovertyline = 
		B17017002 / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline = "Proportion below the poverty line";

	belowpovertyline_u = 
		(B17017002 + B17017002s) / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_u = "[Margin of Error]Proportion below the poverty line - Upper";

	belowpovertyline_l = 
		(B17017002 - B17017002s) / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_l = "[Margin of Error]Proportion below the poverty line - Lower";






	/*Familes with kids under poverty line*/

	famkids_poverty =
	   (B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
		B17010001 /*Total Families*/;

	label famkids_poverty = "Proportion of all family types below the poverty line with children under 18 years";

	famkids_poverty_u =
	   ((B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) +
	   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/)) /
		B17010001 /*Total Families*/;

	label famkids_poverty_u = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years - Upper";

	famkids_poverty_l =
	   ((B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) -
	   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/)) /
		B17010001 /*Total Families*/;

	label famkids_poverty_l = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years - Lower";







	/*Households with income below poverty line and householder 45+*/

	householder45plus_poverty = 
	   (B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017001 /*Households*/;

	label householder45plus_poverty = "Proportion of households which are below the poverty line and the householder is 45 years or greater";

	householder45plus_poverty_u = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) +
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017001 /*Households*/;

	label householder45plus_poverty_u = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater - Upper";

	householder45plus_poverty_l = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) -
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017001 /*Households*/;

	label householder45plus_poverty_l = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater - Lower";






	householder45plus_poverty2 = 
	   (B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2 = "Proportion of households below the poverty line which have a householder who is 45 years or greater";

	householder45plus_poverty2_u = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) +
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_u = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater - Upper";

	householder45plus_poverty2_l = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) -
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_l = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater - Lower";





	/*Per capita income*/

	percapita_income = B19301001;
	label percapita_income = "Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";

	percapita_income_u = B19301001 + B19301001s;
	label percapita_income_u = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars) - Upper";

	percapita_income_l = B19301001 - B19301001s;
	label percapita_income_l = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars) - Lower";





	/*Citizenship*/

	not_citizen = 
		B05001006 /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen = "Proportion who are not U.S. Citizens ";

	not_citizen_u = 
		(B05001006 + B05001006s) /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_u = "[Margin of Error]Proportion who are not U.S. Citizens - Upper";

	not_citizen_l = 
		(B05001006 - B05001006s) /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_l = "[Margin of Error]Proportion who are not U.S. Citizens - Lower";





	foreign_born = 
		B05002013 /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born = "Proportion who are foreign born ";

	foreign_born_u = 
		(B05002013 + B05002013s) /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_u = "[Margin of Error]Proportion who are foreign born - Upper";

	foreign_born_l = 
		(B05002013 - B05002013s) /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_l = "[Margin of Error]Proportion who are foreign born - Lower";






	/*Language spoken at home*/

	foreign_lang = 
		(B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang = "Proportion who speak a foreign language";

	foreign_lang_u = 
		((B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) +
		(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/)) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_u = "[Margin of Error]Proportion who speak a foreign language - Upper";

	foreign_lang_l = 
		((B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) -
		(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/)) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_l = "[Margin of Error]Proportion who speak a foreign language - Lower";





	/*Travel time to work*/

	commute_60minplus = 
		(B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus = "Proportion who have a commute to work of 60min or longer";

	commute_60minplus_u = 
		((B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) +
		(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/)) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_u = "[Margin of Error]Proportion who have a commute to work of 60min or longer - Upper";

	commute_60minplus_l = 
		((B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) -
		(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/)) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_l = "[Margin of Error]Proportion who have a commute to work of 60min or longer - Lower";






	/*Means of Transportation: Workers 16+*/

	publtrans_bike_walk = 
	   (B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk = "Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";

	publtrans_bike_walk_u = 
	   ((B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) +
	   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
		B08301019s /*Workers 16 Years and Over: Walked*/ )) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_u = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work - Upper";

	publtrans_bike_walk_l = 
	   ((B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) -
	   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
		B08301019s /*Workers 16 Years and Over: Walked*/ )) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_l = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work - Lower";







	/*Veteran status*/
	
	veteran = 
		B21001002 /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran = "Proportion of civilian population 18 years and over who are veterans";

	veteran_u = 
		(B21001002 + B21001002s) /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_u = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans - Upper";

	veteran_l = 
		(B21001002 - B21001002s) /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_l = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans - Lower";






	/*Households*/

	nonfam_households = 
		B11001007 /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households = "Proportions of households which are non-family";

	nonfam_households_u = 
		(B11001007 + B11001007s) /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_u = "[Margin of Error]Proportions of households which are non-family - Upper";

	nonfam_households_l = 
		(B11001007 - B11001007s) /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_l = "[Margin of Error]Proportions of households which are non-family - Lower";





	/*Single parents with kids*/

	singledad = 
		B11003010 /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad = "Proportion of families with single fathers";

	singledad_u = 
		(B11003010 + B11003010s) /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_u = "[Margin of Error]Proportion of families with single fathers - Upper";

	singledad_l = 
		(B11003010 - B11003010s) /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_l = "[Margin of Error]Proportion of families with single fathers - Lower";





	singlemom = 
		B11003016 /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom = "Proportion of families with single mothers";

	singlemom_u = 
		(B11003016 + B11003016s) /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_u = "[Margin of Error]Proportion of families with single mothers - Upper";

	singlemom_l = 
		(B11003016 - B11003016s) /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_l = "[Margin of Error]Proportion of families with single mothers - Lower";





	/*Housing Units*/

	house_units = B25001001;
	label house_units = "Number of housing units";

	house_units_u = B25001001 + B25001001s;
	label house_units_u = "[Margin of Error]Number of housing units - Upper";

	house_units_l = B25001001 - B25001001s;
	label house_units_l = "[Margin of Error]Number of housing units - Lower";




	/*Occupancy Status*/

	renter_occupied = 
		B25003003 /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied = "Proportion of renter occupied households";

	renter_occupied_u = 
		(B25003003 + B25003003s) /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_u = "[Margin of Error]Proportion of renter occupied households - Upper";

	renter_occupied_l = 
		(B25003003 - B25003003s) /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_l = "[Margin of Error]Proportion of renter occupied households - Lower";






	/*Vacant Housing Units*/

	vacant = 
		B25002003 /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant = "Proportion of housing units which are vacant";

	vacant_u = 
		(B25002003 + B25002003s) /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_u = "[Margin of Error]Proportion of housing units which are vacant - Upper";

	vacant_l = 
		(B25002003 - B25002003s) /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_l = "[Margin of Error]Proportion of housing units which are vacant - Lower";






	/*Mortgage Status*/

	no_mortgage = 
		B25081008 /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage = "Proportion of owner-occupied housing units without a mortgage";

	no_mortgage_u = 
		(B25081008 + B25081008s) /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_u = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage - Upper";

	no_mortgage_l = 
		(B25081008 - B25081008s) /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_l = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage - Lower";





	/*Occupants per room*/

	occupantsperroom = 
	   (B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom = "Proportion of occupied housing units with more than 1.5 occupants per room";

	occupantsperroom_u = 
	   ((B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) +
	   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/)) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_u = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room - Upper";

	occupantsperroom_l = 
	   ((B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) -
	   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/)) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_l = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room - Lower";






	/*Telephone Service Available*/

	no_telephone = 
	   (B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone = "Proportion of households with no telephone service";

	no_telephone_u = 
	   ((B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) +
	   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/)) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_u = "[Margin of Error]Proportion of households with no telephone service - Upper";

	no_telephone_l = 
	   ((B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) -
	   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/)) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_l = "[Margin of Error]Proportion of households with no telephone service - Lower";








	/*Vehicles Available*/

	no_vehicle = 
	   (B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle = "Proportion of households with no vehicle available";

	no_vehicle_u = 
	   ((B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) +
	   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/)) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_u = "[Margin of Error]Proportion of households with no vehicle available - Upper";

	no_vehicle_l = 
	   ((B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) -
	   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/)) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_l = "[Margin of Error]Proportion of households with no vehicle available - Lower";






	/*House heating fuel*/

	no_heat = 
		B25040010 /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat = "Proportion of occupied housing units with no house heating fuel used";

	no_heat_u = 
		(B25040010 + B25040010s) /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_u = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used - Upper";

	no_heat_l = 
		(B25040010 - B25040010s) /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_l = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used - Lower";







	/*Plumbing facilities*/

	lack_plumbing = 
		B25047003 /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing = "Proportion of households lacking complete plumbing facilities";

	lack_plumbing_u = 
		(B25047003 + B25047003s) /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_u = "[Margin of Error]Proportion of households lacking complete plumbing facilities - Upper";

	lack_plumbing_l = 
		(B25047003 - B25047003s) /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_l = "[Margin of Error]Proportion of households lacking complete plumbing facilities - Lower";







	/*Kitchen facilities*/

	lack_kitchen = 
		B25051003 /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen = "Proportion of households lacking complete kitchen facilities";

	lack_kitchen_u = 
		(B25051003 + B25051003s) /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_u = "[Margin of Error]Proportion of households lacking complete kitchen facilities - Upper";

	lack_kitchen_l = 
		(B25051003 - B25051003s) /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_l = "[Margin of Error]Proportion of households lacking complete kitchen facilities - Lower";


/*	geoid = input(substr(geoid,8,11), BEST.);*/
/**/
/*		if year1 eq "2015" then do;*/
/*			geoid = substr(geoid,1,11);*/
/*		end;*/

%mend;



/* Census Tracts */

%macro ctvars;

	/*Total Population*/

	total_pop_ct = B01001001; /*Total Population*/
	label total_pop_ct = "Count of Total Population";

	total_pop_u_ct = B01001001 + B01001001s; /*Total Population*/
	label total_pop_u_ct = "[Margin of Error]Count of Total Population - Upper";

	total_pop_l_ct = B01001001 - B01001001s; /*Total Population*/
	label total_pop_l_ct = "[Margin of Error]Count of Total Population - Lower";




	/*Age*/

	age_45_74_ct = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		);

	label age_45_74_ct = "Count of population ages 45 to 74 years";

	age_45_74_u_ct = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		) + 
		sum(
			B01001015s, /*Male: 45 to 49 Years*/
			B01001016s, /*Male: 50 to 54 Years*/
			B01001017s, /*Male: 55 to 59 Years*/
			B01001018s, /*Male: 60 and 61 Years*/
			B01001019s, /*Male: 62 to 64 Years*/
			B01001020s, /*Male: 65 and 66 Years*/
			B01001021s, /*Male: 67 to 69 Years*/
			B01001022s, /*Male: 70 to 74 Years*/
			B01001039s, /*Female: 45 to 49 Years*/
			B01001040s, /*Female: 50 to 54 Years*/
			B01001041s, /*Female: 55 to 59 Years*/
			B01001042s, /*Female: 60 and 61 Years*/
			B01001043s, /*Female: 62 to 64 Years*/
			B01001044s, /*Female: 65 and 66 Years*/
			B01001045s, /*Female: 67 to 69 Years*/
			B01001046s  /*Female: 70 to 74 Years*/
		);

	label age_45_74_u_ct = "[Margin of Error]Count of population ages 45 to 74 years - Upper";

	age_45_74_l_ct = 
		sum(
			B01001015, /*Male: 45 to 49 Years*/
			B01001016, /*Male: 50 to 54 Years*/
			B01001017, /*Male: 55 to 59 Years*/
			B01001018, /*Male: 60 and 61 Years*/
			B01001019, /*Male: 62 to 64 Years*/
			B01001020, /*Male: 65 and 66 Years*/
			B01001021, /*Male: 67 to 69 Years*/
			B01001022, /*Male: 70 to 74 Years*/
			B01001039, /*Female: 45 to 49 Years*/
			B01001040, /*Female: 50 to 54 Years*/
			B01001041, /*Female: 55 to 59 Years*/
			B01001042, /*Female: 60 and 61 Years*/
			B01001043, /*Female: 62 to 64 Years*/
			B01001044, /*Female: 65 and 66 Years*/
			B01001045, /*Female: 67 to 69 Years*/
			B01001046  /*Female: 70 to 74 Years*/
		) - 
		sum(
			B01001015s, /*Male: 45 to 49 Years*/
			B01001016s, /*Male: 50 to 54 Years*/
			B01001017s, /*Male: 55 to 59 Years*/
			B01001018s, /*Male: 60 and 61 Years*/
			B01001019s, /*Male: 62 to 64 Years*/
			B01001020s, /*Male: 65 and 66 Years*/
			B01001021s, /*Male: 67 to 69 Years*/
			B01001022s, /*Male: 70 to 74 Years*/
			B01001039s, /*Female: 45 to 49 Years*/
			B01001040s, /*Female: 50 to 54 Years*/
			B01001041s, /*Female: 55 to 59 Years*/
			B01001042s, /*Female: 60 and 61 Years*/
			B01001043s, /*Female: 62 to 64 Years*/
			B01001044s, /*Female: 65 and 66 Years*/
			B01001045s, /*Female: 67 to 69 Years*/
			B01001046s  /*Female: 70 to 74 Years*/
		);

	label age_45_74_l_ct = "[Margin of Error]Count of population ages 45 to 74 years - Lower";





		age_ge65_ct = 
			sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) / 
			B01001001 /*Total Population*/;

		label age_ge65_ct = "Percent of population ages 65 years and older";

		age_ge65_u_ct = 
			(sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) + 
			sum(
				B01001020s, /*Male: 65 and 66 Years*/
				B01001021s, /*Male: 67 to 69 Years*/
				B01001022s, /*Male: 70 to 74 Years*/
				B01001023s, /*Male: 75 to 79 Years*/
				B01001024s, /*Male: 80 to 84 Years*/
				B01001025s, /*Male: 85 Years and Over*/
				B01001044s, /*Female: 65 and 66 Years*/
				B01001045s, /*Female: 67 to 69 Years*/
				B01001046s, /*Female: 70 to 74 Years*/
				B01001047s, /*Female: 75 to 79 Years*/
				B01001048s, /*Female: 80 to 84 Years*/
				B01001049s  /*Female: 85 Years and Over*/
			)) / 
			B01001001 /*Total Population*/;

		label age_ge65_u_ct = "[Margin of Error]Percent of population ages 65 years and older - Upper";

		age_ge65_l_ct = 
			(sum(
				B01001020, /*Male: 65 and 66 Years*/
				B01001021, /*Male: 67 to 69 Years*/
				B01001022, /*Male: 70 to 74 Years*/
				B01001023, /*Male: 75 to 79 Years*/
				B01001024, /*Male: 80 to 84 Years*/
				B01001025, /*Male: 85 Years and Over*/
				B01001044, /*Female: 65 and 66 Years*/
				B01001045, /*Female: 67 to 69 Years*/
				B01001046, /*Female: 70 to 74 Years*/
				B01001047, /*Female: 75 to 79 Years*/
				B01001048, /*Female: 80 to 84 Years*/
				B01001049  /*Female: 85 Years and Over*/
			) - 
			sum(
				B01001020s, /*Male: 65 and 66 Years*/
				B01001021s, /*Male: 67 to 69 Years*/
				B01001022s, /*Male: 70 to 74 Years*/
				B01001023s, /*Male: 75 to 79 Years*/
				B01001024s, /*Male: 80 to 84 Years*/
				B01001025s, /*Male: 85 Years and Over*/
				B01001044s, /*Female: 65 and 66 Years*/
				B01001045s, /*Female: 67 to 69 Years*/
				B01001046s, /*Female: 70 to 74 Years*/
				B01001047s, /*Female: 75 to 79 Years*/
				B01001048s, /*Female: 80 to 84 Years*/
				B01001049s  /*Female: 85 Years and Over*/
			)) / 
			B01001001 /*Total Population*/;

		label age_ge65_l_ct = "[Margin of Error]Percent of population ages 65 years and older - Lower";





	/*Sex*/

	male_ct = 
		B01001002 /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_ct = "Proportion of geographic unit who are male";

	male_u_ct = 
		(B01001002 + B01001002s) /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_u_ct = "[Margin of Error]Proportion of geographic unit who are male - Upper";

	male_l_ct = 
		(B01001002 - B01001002s) /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_l_ct = "[Margin of Error]Proportion of geographic unit who are male - Lower";





	female_ct = 
		B01001026 /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_ct = "Proportion of geographic unit who are female";

	female_u_ct = 
		(B01001026 + B01001026s) /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_u_ct = "[Margin of Error]Proportion of geographic unit who are female - Upper";

	female_l_ct = 
		(B01001026 - B01001026s) /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_l_ct = "[Margin of Error]Proportion of geographic unit who are female - Lower";




	/*Race*/

	white_ct = 
		B02001002 /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_ct = "Proportion of geographic unit who are recorded as White";

	white_u_ct = 
		(B02001002 + B02001002s) /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_u_ct = "[Margin of Error]Proportion of geographic unit who are recorded as White - Upper";

	white_l_ct = 
		(B02001002 - B02001002s) /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_l_ct = "[Margin of Error]Proportion of geographic unit who are recorded as White - Lower";




	black_ct = 
		B02001003 /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_ct = "Proportion of geographic unit who are recorded as Black";

	black_u_ct = 
		(B02001003 + B02001003s) /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_u_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Black - Upper";

	black_l_ct = 
		(B02001003 - B02001003s) /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_l_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Black - Lower";





	asian_pacislander_ct = 
	   (B02001005 /*Asian Alone*/ + 
		B02001006 /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		B01001001 /*Total Population*/; 

	label asian_pacislander_ct = "Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";

	asian_pacislander_u_ct = 
	   ((B02001005 + B02001005s) /*Asian Alone*/ + 
		(B02001006 + B02001006s) /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		 B01001001 /*Total Population*/; 

	label asian_pacislander_u_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander - Upper";

	asian_pacislander_l_ct = 
	   ((B02001005 - B02001005s) /*Asian Alone*/ + 
		(B02001006 - B02001006s) /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		 B01001001 /*Total Population*/; 

	label asian_pacislander_l_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander - Lower";






	other_ct = 
	   (B02001004 /*American Indian and Alaska Native Alone*/ + 
		B02001009 /*Two or More Races: Two Races Including Some Other Race*/) / 
		B01001001 /*Total Population*/;

	label other_ct = "Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";

	other_u_ct = 
	   ((B02001004 + B02001004s) /*American Indian and Alaska Native Alone*/ + 
		(B02001009 + B02001009s) /*Two or More Races: Two Races Including Some Other Race*/) / 
		 B01001001 /*Total Population*/;

	label other_u_ct = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race - Upper";

	other_l_ct = 
	   ((B02001004 - B02001004s) /*American Indian and Alaska Native Alone*/ + 
		(B02001009 - B02001009s) /*Two or More Races: Two Races Including Some Other Race*/) / 
		 B01001001 /*Total Population*/;

	label other_l_ct = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race - Lower";




	/*Ethnicity*/

	hisp_ct = 
		B03002012 /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_ct = "Proportion of geographic unit who are reported as Hispanic or Latino";

	hisp_u_ct = 
		(B03002012 + B03002012s) /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_u_ct = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino - Upper";

	hisp_l_ct = 
		(B03002012 - B03002012s) /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_l_ct = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino - Lower";




	/*School enrollment (3+)*/

	noenrolledinschool_3plus_ct = 
	   (B14002025 /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		B14002049 /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_ct = "Proportion of Population 3+ Not Enrolled in School";

	noenrolledinschool_3plus_u_ct = 
	   ((B14002025 + B14002025s) /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		(B14002049 + B14002049s) /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		 B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_u_ct = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School - Upper";

	noenrolledinschool_3plus_l_ct = 
	   ((B14002025 - B14002025s) /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		(B14002049 - B14002049s) /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		 B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_l_ct = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School - Lower";





	/*Educational Attainment (25+)*/

	nohsgrad_25plus_ct =
	   (B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus_ct = "Proportion of Population 25+ who did not Graduate High School ";

	nohsgrad_25plus_u_ct =
	   ((B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) +
	   (B15002003s /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004s /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005s /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006s /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007s /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008s /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009s /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010s /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020s /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021s /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022s /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023s /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024s /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ )) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus_u_ct = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School - Upper";

	nohsgrad_25plus_l_ct =
	   ((B15002003 /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004 /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005 /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006 /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007 /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008 /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009 /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010 /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020 /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021 /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022 /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023 /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024 /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026 /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027 /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) -
	   (B15002003s /*Population 25 Years and Over: Male: No Schooling Completed*/ +
		B15002004s /*Population 25 Years and Over: Male: Nursery to 4th Grade*/ +
		B15002005s /*Population 25 Years and Over: Male: 5th and 6th Grade*/ +
		B15002006s /*Population 25 Years and Over: Male: 7th and 8th Grade*/ +
		B15002007s /*Population 25 Years and Over: Male: 9th Grade*/ +
		B15002008s /*Population 25 Years and Over: Male: 10th Grade*/ +
		B15002009s /*Population 25 Years and Over: Male: 11th Grade*/ +
		B15002010s /*Population 25 Years and Over: Male: 12th Grade, No Diploma*/ +
		B15002020s /*Population 25 Years and Over: Female: No Schooling Completed*/ +
		B15002021s /*Population 25 Years and Over: Female: Nursery to 4th Grade*/ +
		B15002022s /*Population 25 Years and Over: Female: 5th and 6th Grade*/ +
		B15002023s /*Population 25 Years and Over: Female: 7th and 8th Grade*/ +
		B15002024s /*Population 25 Years and Over: Female: 9th Grade*/ +
		B15002025s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002026s /*Population 25 Years and Over: Female: 10th Grade*/ +
		B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ )) /
		B15002001 /*Population 25 Years and Over*/;

	label nohsgrad_25plus_l_ct = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School - Lower";





	/*Employment status*/

	unemployed_ct = 	
		(B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ )/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_ct = "Proportion of families with an unemployed parent";

	unemployed_u_ct = 
		((B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ) +
		(B23007008s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024s + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029s + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053s + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ))/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_u_ct = "[Margin of Error]Proportion of families with an unemployed parent - Upper";

	unemployed_l_ct = 
		((B23007008 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018 + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024 + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029 + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047 + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053 + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ) -
		(B23007008s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007010s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed*/
		 B23007013s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007018s + /*Families: with Own Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007024s + /*Families: with Own Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007029s + /*Families: with Own Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/
		 B23007037s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Employed or in Armed Forces: Wife in Labor Force: Unemployed*/
		 B23007042s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband in Labor Force: Unemployed: Wife in Labor Force: Unemployed*/
		 B23007047s + /*Families: No Children Under 18 Years: Married-Couple Family: Husband Not in Labor Force: Wife in Labor Force: Unemployed*/
		 B23007053s + /*Families: No Children Under 18 Years: Other Family: Male Householder, No Wife Present: in Labor Force: Unemployed*/
		 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ ))/
		(B23007031 + /*Families: No Children Under 18 Years*/
		 B23007002   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_l_ct = "[Margin of Error]Proportion of families with an unemployed parent - Lower";




	/*Median Household income*/

	med_houseincome_ct = B19013001;

	label med_houseincome_ct = "Median Household Income";

	med_houseincome_u_ct = B19013001 + B19013001s;

	label med_houseincome_u_ct = "[Margin of Error]Median Household Income - Upper";

	med_houseincome_l_ct = B19013001 - B19013001s;

	label med_houseincome_l_ct = "[Margin of Error]Median Household Income - Lower";





	/*Public assistance*/

	households_w_publicassist_ct = 
		B19057002 /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_ct = "Proportion of Households with Public Assistance Income";

	households_w_publicassist_u_ct = 
		(B19057002 + B19057002s) /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_u_ct = "[Margin of Error]Proportion of Households with Public Assistance Income - Upper";

	households_w_publicassist_l_ct = 
		(B19057002 - B19057002s) /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_l_ct = "[Margin of Error]Proportion of Households with Public Assistance Income - Lower";







	/*Social security income*/

	socsecinsur_ct = 
		B19055002 /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_ct = "Proportion with social security income";

	socsecinsur_u_ct = 
		(B19055002 + B19055002s) /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_u_ct = "[Margin of Error]Proportion with social security income - Upper";

	socsecinsur_l_ct = 
		(B19055002 - B19055002s) /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_l_ct = "[Margin of Error]Proportion with social security income - Lower";





	/*Poverty status*/

	belowpovertyline_ct = 
		B17017002 / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_ct = "Proportion below the poverty line";

	belowpovertyline_u_ct = 
		(B17017002 + B17017002s) / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_u_ct = "[Margin of Error]Proportion below the poverty line - Upper";

	belowpovertyline_l_ct = 
		(B17017002 - B17017002s) / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_l_ct = "[Margin of Error]Proportion below the poverty line - Lower";






	/*Familes with kids under poverty line*/

	famkids_poverty_ct =
	   (B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
		B17010001 /*Total Families*/;

	label famkids_poverty_ct = "Proportion of all family types below the poverty line with children under 18 years";

	famkids_poverty_u_ct =
	   ((B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) +
	   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/)) /
		B17010001 /*Total Families*/;

	label famkids_poverty_u_ct = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years - Upper";

	famkids_poverty_l_ct =
	   ((B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) -
	   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/)) /
		B17010001 /*Total Families*/;

	label famkids_poverty_l_ct = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years - Lower";







	/*Households with income below poverty line and householder 45+*/

	householder45plus_poverty_ct = 
	   (B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017001 /*Households*/;

	label householder45plus_poverty_ct = "Proportion of households which are below the poverty line and the householder is 45 years or greater";

	householder45plus_poverty_u_ct = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) +
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017001 /*Households*/;

	label householder45plus_poverty_u_ct = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater - Upper";

	householder45plus_poverty_l_ct = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) -
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017001 /*Households*/;

	label householder45plus_poverty_l_ct = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater - Lower";






	householder45plus_poverty2_ct = 
	   (B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_ct = "Proportion of households below the poverty line which have a householder who is 45 years or greater";

	householder45plus_poverty2_u_ct = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) +
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_u_ct = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater - Upper";

	householder45plus_poverty2_l_ct = 
	   ((B17017007 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019 /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030 /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) -
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/)) /
		B17017002 /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_l_ct = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater - Lower";





	/*Per capita income*/

	percapita_income_ct = B19301001;
	label percapita_income_ct = "Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";

	percapita_income_u_ct = B19301001 + B19301001s;
	label percapita_income_u_ct = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars) - Upper";

	percapita_income_l_ct = B19301001 - B19301001s;
	label percapita_income_l_ct = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars) - Lower";





	/*Citizenship*/

	not_citizen_ct = 
		B05001006 /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_ct = "Proportion who are not U.S. Citizens ";

	not_citizen_u_ct = 
		(B05001006 + B05001006s) /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_u_ct = "[Margin of Error]Proportion who are not U.S. Citizens - Upper";

	not_citizen_l_ct = 
		(B05001006 - B05001006s) /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_l_ct = "[Margin of Error]Proportion who are not U.S. Citizens - Lower";





	foreign_born_ct = 
		B05002013 /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_ct = "Proportion who are foreign born ";

	foreign_born_u_ct = 
		(B05002013 + B05002013s) /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_u_ct = "[Margin of Error]Proportion who are foreign born - Upper";

	foreign_born_l_ct = 
		(B05002013 - B05002013s) /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_l_ct = "[Margin of Error]Proportion who are foreign born - Lower";






	/*Language spoken at home*/

	foreign_lang_ct = 
		(B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_ct = "Proportion who speak a foreign language";

	foreign_lang_u_ct = 
		((B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) +
		(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/)) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_u_ct = "[Margin of Error]Proportion who speak a foreign language - Upper";

	foreign_lang_l_ct = 
		((B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) -
		(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/)) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_l_ct = "[Margin of Error]Proportion who speak a foreign language - Lower";





	/*Travel time to work*/

	commute_60minplus_ct = 
		(B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_ct = "Proportion who have a commute to work of 60min or longer";

	commute_60minplus_u_ct = 
		((B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) +
		(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/)) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_u_ct = "[Margin of Error]Proportion who have a commute to work of 60min or longer - Upper";

	commute_60minplus_l_ct = 
		((B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) -
		(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/)) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_l_ct = "[Margin of Error]Proportion who have a commute to work of 60min or longer - Lower";






	/*Means of Transportation: Workers 16+*/

	publtrans_bike_walk_ct = 
	   (B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_ct = "Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";

	publtrans_bike_walk_u_ct = 
	   ((B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) +
	   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
		B08301019s /*Workers 16 Years and Over: Walked*/ )) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_u_ct = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work - Upper";

	publtrans_bike_walk_l_ct = 
	   ((B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) -
	   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
		B08301019s /*Workers 16 Years and Over: Walked*/ )) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_l_ct = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work - Lower";







	/*Veteran status*/
	
	veteran_ct = 
		B21001002 /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_ct = "Proportion of civilian population 18 years and over who are veterans";

	veteran_u_ct = 
		(B21001002 + B21001002s) /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_u_ct = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans - Upper";

	veteran_l_ct = 
		(B21001002 - B21001002s) /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_l_ct = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans - Lower";






	/*Households*/

	nonfam_households_ct = 
		B11001007 /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_ct = "Proportions of households which are non-family";

	nonfam_households_u_ct = 
		(B11001007 + B11001007s) /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_u_ct = "[Margin of Error]Proportions of households which are non-family - Upper";

	nonfam_households_l_ct = 
		(B11001007 - B11001007s) /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_l_ct = "[Margin of Error]Proportions of households which are non-family - Lower";





	/*Single parents with kids*/

	singledad_ct = 
		B11003010 /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_ct = "Proportion of families with single fathers";

	singledad_u_ct = 
		(B11003010 + B11003010s) /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_u_ct = "[Margin of Error]Proportion of families with single fathers - Upper";

	singledad_l_ct = 
		(B11003010 - B11003010s) /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_l_ct = "[Margin of Error]Proportion of families with single fathers - Lower";





	singlemom_ct = 
		B11003016 /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_ct = "Proportion of families with single mothers";

	singlemom_u_ct = 
		(B11003016 + B11003016s) /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_u_ct = "[Margin of Error]Proportion of families with single mothers - Upper";

	singlemom_l_ct = 
		(B11003016 - B11003016s) /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_l_ct = "[Margin of Error]Proportion of families with single mothers - Lower";





	/*Housing Units*/

	house_units_ct = B25001001;
	label house_units_ct = "Number of housing units";

	house_units_u_ct = B25001001 + B25001001s;
	label house_units_u_ct = "[Margin of Error]Number of housing units - Upper";

	house_units_l_ct = B25001001 - B25001001s;
	label house_units_l_ct = "[Margin of Error]Number of housing units - Lower";




	/*Occupancy Status*/

	renter_occupied_ct = 
		B25003003 /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_ct = "Proportion of renter occupied households";

	renter_occupied_u_ct = 
		(B25003003 + B25003003s) /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_u_ct = "[Margin of Error]Proportion of renter occupied households - Upper";

	renter_occupied_l_ct = 
		(B25003003 - B25003003s) /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_l_ct = "[Margin of Error]Proportion of renter occupied households - Lower";






	/*Vacant Housing Units*/

	vacant_ct = 
		B25002003 /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_ct = "Proportion of housing units which are vacant";

	vacant_u_ct = 
		(B25002003 + B25002003s) /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_u_ct = "[Margin of Error]Proportion of housing units which are vacant - Upper";

	vacant_l_ct = 
		(B25002003 - B25002003s) /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_l_ct = "[Margin of Error]Proportion of housing units which are vacant - Lower";






	/*Mortgage Status*/

	no_mortgage_ct = 
		B25081008 /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_ct = "Proportion of owner-occupied housing units without a mortgage";

	no_mortgage_u_ct = 
		(B25081008 + B25081008s) /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_u_ct = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage - Upper";

	no_mortgage_l_ct = 
		(B25081008 - B25081008s) /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_l_ct = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage - Lower";





	/*Occupants per room*/

	occupantsperroom_ct = 
	   (B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_ct = "Proportion of occupied housing units with more than 1.5 occupants per room";

	occupantsperroom_u_ct = 
	   ((B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) +
	   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/)) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_u_ct = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room - Upper";

	occupantsperroom_l_ct = 
	   ((B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) -
	   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/)) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_l_ct = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room - Lower";






	/*Telephone Service Available*/

	no_telephone_ct = 
	   (B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_ct = "Proportion of households with no telephone service";

	no_telephone_u_ct = 
	   ((B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) +
	   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/)) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_u_ct = "[Margin of Error]Proportion of households with no telephone service - Upper";

	no_telephone_l_ct = 
	   ((B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) -
	   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/)) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_l_ct = "[Margin of Error]Proportion of households with no telephone service - Lower";








	/*Vehicles Available*/

	no_vehicle_ct = 
	   (B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_ct = "Proportion of households with no vehicle available";

	no_vehicle_u_ct = 
	   ((B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) +
	   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/)) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_u_ct = "[Margin of Error]Proportion of households with no vehicle available - Upper";

	no_vehicle_l_ct = 
	   ((B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) -
	   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/)) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_l_ct = "[Margin of Error]Proportion of households with no vehicle available - Lower";






	/*House heating fuel*/

	no_heat_ct = 
		B25040010 /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_ct = "Proportion of occupied housing units with no house heating fuel used";

	no_heat_u_ct = 
		(B25040010 + B25040010s) /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_u_ct = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used - Upper";

	no_heat_l_ct = 
		(B25040010 - B25040010s) /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_l_ct = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used - Lower";







	/*Plumbing facilities*/

	lack_plumbing_ct = 
		B25047003 /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_ct = "Proportion of households lacking complete plumbing facilities";

	lack_plumbing_u_ct = 
		(B25047003 + B25047003s) /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_u_ct = "[Margin of Error]Proportion of households lacking complete plumbing facilities - Upper";

	lack_plumbing_l_ct = 
		(B25047003 - B25047003s) /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_l_ct = "[Margin of Error]Proportion of households lacking complete plumbing facilities - Lower";







	/*Kitchen facilities*/

	lack_kitchen_ct = 
		B25051003 /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_ct = "Proportion of households lacking complete kitchen facilities";

	lack_kitchen_u_ct = 
		(B25051003 + B25051003s) /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_u_ct = "[Margin of Error]Proportion of households lacking complete kitchen facilities - Upper";

	lack_kitchen_l_ct = 
		(B25051003 - B25051003s) /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_l_ct = "[Margin of Error]Proportion of households lacking complete kitchen facilities - Lower";






	med_yearbuilt_ct = B25035001; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_ct = "Median year homes in geographic unit were built";

	med_yearbuilt_u_ct = B25035001 + B25035001s; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_u_ct = "[Margin of Error]Median year homes in geographic unit were built - Upper";

	med_yearbuilt_l_ct = B25035001 - B25035001s; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_l_ct = "[Margin of Error]Median year homes in geographic unit were built - Lower";






	gini_ct = B19083001; /* Households: Gini Index */

	label gini_ct = "Gini index of inequality";

	gini_u_ct = B19083001 + B19083001s; /* [Std. Error: Households: Gini Index */

	label gini_u_ct = "[Margin of Error]Gini index of inequality - Upper";

	gini_l_ct = B19083001 - B19083001s; /* [Std. Error: Households: Gini Index */

	label gini_l_ct = "[Margin of Error]Gini index of inequality - Lower";




	moved_1yr_ct = 
		(B07003001 /* Population 1 Year and Over in the United States */ - B07003004 /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) /
		 B07003001 /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_ct = "Proportion of population who moved houses within a year";

	moved_1yr_u_ct = 
		((B07003001 /* Population 1 Year and Over in the United States */ - B07003004 /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) +
		(B07003001s /* Population 1 Year and Over in the United States */ - B07003004s /* Population 1 Year and Over in the United States: Same House 1 Year Ago */)) /
		 B07003001 /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_u_ct = "[Margin of Error]Proportion of population who moved houses within a year - Upper";

	moved_1yr_l_ct = 
		((B07003001 /* Population 1 Year and Over in the United States */ - B07003004 /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) -
		(B07003001s /* Population 1 Year and Over in the United States */ - B07003004s /* Population 1 Year and Over in the United States: Same House 1 Year Ago */)) /
		 B07003001 /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_l_ct = "[Margin of Error]Proportion of population who moved houses within a year - Lower";




	geoid_ct = input(substr(geoid,8,11), BEST.);

		if year1 eq "2015" then do;
			geoid_ct = substr(geoid,1,11);
		end;

%mend;

%macro imp(y1,y2);

	libname acs "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

	proc import 
		datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\20&y1.-20&y2. ACS\ct&y1._&y2._citizen_foreign.csv"
		out=ct&y1._&y2.(keep=Geo_STATE Geo_COUNTY Geo_TRACT ACS&y2._5yr_B05001001 ACS&y2._5yr_B05001006 ACS&y2._5yr_B05002001 ACS&y2._5yr_B05002013 ACS&y2._5yr_B05001001s ACS&y2._5yr_B05001006s ACS&y2._5yr_B05002001s ACS&y2._5yr_B05002013s)
		dbms=csv
		replace;
	run;
	quit;

	data ct&y1._&y2.1;
	  set ct&y1._&y2.;
		geoid = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
		geoid_ct = input(geoid, BEST.);
		rename 
			ACS&y2._5yr_B05001001 = B05001001
			ACS&y2._5yr_B05001006 = B05001006
			ACS&y2._5yr_B05002001 = B05002001
			ACS&y2._5yr_B05002013 = B05002013
			ACS&y2._5yr_B05001001s = B05001001s
			ACS&y2._5yr_B05001006s = B05001006s
			ACS&y2._5yr_B05002001s = B05002001s
			ACS&y2._5yr_B05002013s = B05002013s
		;
		year1 = "20&y1.";
		year2 = "20&y2.";
		drop geoid Geo_STATE Geo_COUNTY Geo_TRACT;
	run;

	proc sort data = ct&y1._&y2.1; by geoid_ct year1; run;

	proc import 
		datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\20&y1.-20&y2. ACS\ct&y1._&y2._medyear.csv"
		out=ct&y1._&y2.(keep=Geo_STATE Geo_COUNTY Geo_TRACT ACS&y2._5yr_B25035001 ACS&y2._5yr_B25035001s)
		dbms=csv
		replace;
	run;
	quit;

	data ct&y1._&y2.2;
	  set ct&y1._&y2.;
		geoid = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
		geoid_ct = input(geoid, BEST.);
		rename ACS&y2._5yr_B25035001 = B25035001 ACS&y2._5yr_B25035001 = B25035001s;
		year1 = "20&y1.";
		year2 = "20&y2.";
		drop geoid Geo_STATE Geo_COUNTY Geo_TRACT;
	run;

	proc sort data = ct&y1._&y2.2; by geoid_ct year1; run;

	data acs.ct&y1._&y2.;
	  merge ct&y1._&y2.1 ct&y1._&y2.2;
	  by geoid_ct year1;
	run;

%mend;

data acs_06_10_ct;
  set ds.acs_ct_06_10;
	year1 = "2006";
	year2 = "2010";
	%ctvars;
run;

proc means data = acs_06_10_ct nmiss mean maxdec=2 nolabels;
var &ctvarlist.;
run;

proc contents data = acs_06_10_ct varnum; run;

proc print data = acs_06_10_ct (obs=10);
var b17017001 b17017002 belowpovertyline_ct b17017001s b17017002s belowpovertyline_moe_ct;
run;


%imp(06,10);


data acs_07_11_ct;
  set ds.acs_ct_07_11;
	year1 = "2007";
	year2 = "2011";
run;

%imp(07,11);



data acs_08_12_ct;
  set ds.acs_ct_08_12;
	year1 = "2008";
	year2 = "2012";
run;

%imp(08,12);


data acs_09_13_ct;
  set ds.acs_09_13_ct;
	year1 = "2009";
	year2 = "2013";
run;

%imp(09,13);


dm log 'clear';

libname ds13 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2009-2013 ACS";

data acs.acs_09_13_ct_citizen_foreignborn;
  set ds13.pact09_13(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2009";
	year2 = "2013";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;


proc sort data = acs_09_13_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_09_13_ct_citizen_foreignborn;
  merge acs_09_13_ct_citizen_foreignborn CT09_13;
  by geoid_ct year1;
run;




data acs_10_14_ct;
  set ds.acs_10_14_ct;
	year1 = "2010";
	year2 = "2014";
run;

%imp(10,14);

libname ds14 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2010-2014 ACS";

data acs.acs_10_14_ct_citizen_foreignborn;
  set ds14.pact10_14(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2010";
	year2 = "2014";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;

proc sort data = acs_10_14_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_10_14_ct_citizen_foreignborn;
  merge acs_10_14_ct_citizen_foreignborn CT10_14;
  by geoid_ct year1;
run;




data acs_11_15_ct;
  set ds.acs_11_15_ct;
	year1 = "2011";
	year2 = "2015";
run;

dm log 'clear';

libname ds15 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2011-2015 ACS";

data acs.acs_11_15_ct_citizen_foreignborn;
  set ds15.pact11_15(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2011";
	year2 = "2015";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;

%imp(11,15);

proc sort data = acs_11_15_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_11_15_ct_citizen_foreignborn;
  merge acs_11_15_ct_citizen_foreignborn CT11_15;
  by geoid_ct year1;
run;







dm log 'clear';

libname ds16 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2012-2016 ACS";

data acs.acs_12_16_ct;
  set ds16.pact12_16;
	year1 = "2012";
	year2 = "2016";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
		%rename2;
run;

proc contents data = acs_12_16_ct; run;

%imp(12,16);

dm log 'clear';

libname ds16 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2012-2016 ACS";

data acs.acs_12_16_ct_citizen_foreignborn;
  set ds16.pact12_16(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2012";
	year2 = "2016";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;

proc sort data = acs_12_16_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_12_16_ct_citizen_foreignborn;
  merge acs_12_16_ct_citizen_foreignborn CT12_16;
  by geoid_ct year1;
run;

proc print data = acs_12_16_ct_citizen_foreignborn (obs=100); run;







data acs_13_17_ct;
  set ds.acs_13_17_ct;
	year1 = "2013";
	year2 = "2017";
run;

dm log 'clear';

libname ds17 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2013-2017 ACS";

data acs.acs_13_17_ct_citizen_foreignborn;
  set ds17.pact13_17(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2013";
	year2 = "2017";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;

%imp(13,17);

proc sort data = acs_13_17_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_13_17_ct_citizen_foreignborn;
  merge acs_13_17_ct_citizen_foreignborn CT13_17;
  by geoid_ct year1;
run;

proc print data = acs_13_17_ct_citizen_foreignborn (obs=100); run;



data acs_14_18_ct;
  set ds.acs_14_18_ct;
	year1 = "2014";
	year2 = "2018";
run;

proc contents data = acs_14_18_ct varnum; run;

%imp(14,18);




dm log 'clear';

libname ds18 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2014-2018 ACS";

data acs.acs_14_18_ct_citizen_foreignborn;
  set ds18.pact14_18(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);
  	year1 = "2014";
	year2 = "2018";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1  = B05001001
		B05001i6  = B05001006
		B05002i1  = B05002001
		B05002i13 = B05002013
		B05001m1  = B05001001s
		B05001m6  = B05001006s
		B05002m1  = B05002001s
		B05002m13 = B05002013s
	;
run;

proc sort data = acs_14_18_ct_citizen_foreignborn; by geoid_ct year1; run;

data acs_14_18_ct_citizen_foreignborn;
  merge acs_14_18_ct_citizen_foreignborn CT14_18;
  by geoid_ct year1;
run;

proc print data = acs_14_18_ct_citizen_foreignborn (obs=100); run;


proc contents data = ds18.pact14_18; run;

libname d "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2015-2019 ACS";

data acs.acs_15_19_ct;
  set d.pact15_19;
	year1 = "2015";
	year2 = "2019";
	geoid_ct = input(esriid, BEST.);
	rename esriid = geoid;
	%rename;
run;

data acs_15_19_ct_gini_movedonly;
  set acs_15_19_ct;
	keep geoid_ct year1 year2 B19083001 B07003001 B07003004;
run;

data acs_15_19_ct_citizen_foreignborn;
  set d.pact15_19(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13);
  	year1 = "2015";
	year2 = "2019";
	geoid_ct = input(esriid, BEST.);
	drop esriid;
	rename
		B05001i1 = B05001001
		B05001i6 = B05001006
		B05002i1 = B05002001
		B05002i13 = B05002013
	;
run;

proc contents data = CT06_10; run;
proc contents data = acs_15_19_ct_gini_movedonly; run;

data ds.acs_15_19_ct_gini_movedonly;
  set acs_15_19_ct_gini_movedonly;
run;


proc print data = acs_15_19_ct_gini_movedonly (obs=100);
run;


data acs_ct_missingdepvars;
  set
	CT06_10
	CT07_11
	CT08_12
	acs_09_13_ct_citizen_foreignborn
	acs_10_14_ct_citizen_foreignborn
	acs_11_15_ct_citizen_foreignborn
	acs_12_16_ct_citizen_foreignborn
	acs_13_17_ct_citizen_foreignborn
	acs_14_18_ct_citizen_foreignborn
	acs_15_19_ct_citizen_foreignborn
  ;
run;

proc sort data = acs_ct_missingdepvars; 
by geoid_ct year1;
run;

proc print data = acs_ct_missingdepvars (obs=100);
run;

proc contents data = acs_ct_missingdepvars; run;






data acs.acs_raw_ct;
  set acs_06_10_ct
      acs_07_11_ct
      acs_08_12_ct
      acs_09_13_ct
      acs_10_14_ct
      acs_11_15_ct
      acs.acs_12_16_ct
      acs_13_17_ct
      acs_14_18_ct
	  acs.acs_15_19_ct
  ;
run;
















/********************* STARTING FROM SCRATCH 01/25/23 *********************/

%macro rename_list(y1,y2);
	data acs&y1._&y2.ct_depvars;
	  set acs&y1._&y2.ct_depvars;
	  	%do i = 1 %to %sysfunc(countw(&var_list.));
			rename
				%scan(&var_list.,&i.) = %sysfunc(substr(%scan(&var_list.,&i.),11))
			;
		%end;
			year1 = "20&y1.";
			year2 = "20&y2.";
	run;
%mend;

%macro importcsv(y1,y2);

dm log 'clear';

proc import datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS\acs&y1._&y2.ct_depvars.csv"
	out = acs&y1._&y2.ct_depvars
	dbms = csv
	replace;
	guessingrows = max;
run;
quit;

proc sql noprint;
	CREATE TABLE VAR_NAMES AS
	SELECT NAME
	FROM DICTIONARY.COLUMNS
	WHERE LIBNAME = "WORK" AND MEMNAME = "ACS&y1._&y2.CT_DEPVARS"
	AND NAME CONTAINS "ACS&y2._5yr";
	SELECT COMPRESS(NAME) INTO :VAR_LIST SEPARATED BY " "
	FROM VAR_NAMES;
quit;

%rename_list(&y1.,&y2.);

proc sort data = acs&y1._&y2.ct_depvars; by year1; run;

%mend;

%importcsv(06,10);
%importcsv(07,11);
%importcsv(08,12);
%importcsv(09,13);
%importcsv(10,14);
%importcsv(11,15);
%importcsv(12,16);
%importcsv(13,17);
%importcsv(14,18);
%importcsv(15,19);

data acs_ct_depvars;
  format geoid_ct;
  set acs06_10ct_depvars acs07_11ct_depvars acs08_12ct_depvars acs09_13ct_depvars acs10_14ct_depvars acs11_15ct_depvars acs12_16ct_depvars acs13_17ct_depvars acs14_18ct_depvars acs15_19ct_depvars;
	%ctvars;
	geoid = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
	geoid_ct = input(geoid, BEST.);
  keep year1 year2 total_pop_ct total_pop_u_ct total_pop_l_ct age_45_74_ct age_45_74_u_ct age_45_74_l_ct age_ge65_ct age_ge65_u_ct age_ge65_l_ct male_ct female_ct male_u_ct male_l_ct female_u_ct female_l_ct white_ct black_ct asian_pacislander_ct other_ct white_u_ct black_u_ct asian_pacislander_u_ct other_u_ct white_l_ct black_l_ct asian_pacislander_l_ct other_l_ct hisp_ct hisp_u_ct hisp_l_ct noenrolledinschool_3plus_ct noenrolledinschool_3plus_u_ct noenrolledinschool_3plus_l_ct nohsgrad_25plus_ct nohsgrad_25plus_u_ct nohsgrad_25plus_l_ct unemployed_ct unemployed_u_ct unemployed_l_ct med_houseincome_ct med_houseincome_u_ct med_houseincome_l_ct households_w_publicassist_ct households_w_publicassist_u_ct households_w_publicassist_l_ct socsecinsur_ct socsecinsur_u_ct socsecinsur_l_ct belowpovertyline_ct belowpovertyline_u_ct belowpovertyline_l_ct famkids_poverty_ct famkids_poverty_u_ct famkids_poverty_l_ct householder45plus_poverty_ct householder45plus_poverty2_ct householder45plus_poverty_u_ct householder45plus_poverty2_u_ct householder45plus_poverty_l_ct householder45plus_poverty2_l_ct percapita_income_ct percapita_income_u_ct percapita_income_l_ct not_citizen_ct not_citizen_u_ct not_citizen_l_ct foreign_born_ct foreign_born_u_ct foreign_born_l_ct foreign_lang_ct foreign_lang_u_ct foreign_lang_l_ct commute_60minplus_ct commute_60minplus_u_ct commute_60minplus_l_ct publtrans_bike_walk_ct publtrans_bike_walk_u_ct publtrans_bike_walk_l_ct veteran_ct veteran_u_ct veteran_l_ct nonfam_households_ct nonfam_households_u_ct nonfam_households_l_ct singledad_ct singlemom_ct singledad_u_ct singlemom_u_ct singledad_l_ct singlemom_l_ct house_units_ct house_units_u_ct house_units_l_ct renter_occupied_ct renter_occupied_u_ct renter_occupied_l_ct vacant_ct vacant_u_ct vacant_l_ct no_mortgage_ct no_mortgage_u_ct no_mortgage_l_ct occupantsperroom_ct occupantsperroom_u_ct occupantsperroom_l_ct no_telephone_ct no_telephone_u_ct no_telephone_l_ct no_vehicle_ct no_vehicle_u_ct no_vehicle_l_ct no_heat_ct no_heat_u_ct no_heat_l_ct lack_plumbing_ct lack_plumbing_u_ct lack_plumbing_l_ct lack_kitchen_ct lack_kitchen_u_ct lack_kitchen_l_ct med_yearbuilt_ct med_yearbuilt_u_ct med_yearbuilt_l_ct gini_ct gini_u_ct gini_l_ct moved_1yr_ct moved_1yr_u_ct moved_1yr_l_ct geoid_ct;
run;

proc sort data = acs_ct_depvars; by geoid_ct year1; run;
/*proc contents data = acs_ct_depvars varnum; run;*/

/*proc print data = acs_ct_depvars (obs=10); run;*/
/*%let ctvarlist = female_moe_ct male_moe_ct asian_pacislander_moe_ct black_moe_ct other_moe_ct white_moe_ct hisp_moe_ct age_ge65_moe_ct veteran_moe_ct nohsgrad_25plus_moe_ct noenrolledinschool_3plus_moe_ct singledad_moe_ct singlemom_moe_ct nonfam_households_moe_ct commute_60minplus_moe_ct publtrans_bike_walk_moe_ct foreign_lang_moe_ct belowpovertyline_moe_ct householder45plus_poverty_moe_ct famkids_poverty_moe_ct unemployed_moe_ct med_houseincome_moe_ct percapita_income_moe_ct households_w_publicassist_moe_ct socsecinsur_moe_ct vacant_moe_ct occupantsperroom_moe_ct renter_occupied_moe_ct no_mortgage_moe_ct no_telephone_moe_ct no_vehicle_moe_ct no_heat_moe_ct lack_plumbing_moe_ct lack_kitchen_moe_ct house_units_moe_ct foreign_born_moe_ct not_citizen_moe_ct moved_1yr_moe_ct gini_moe_ct;*/
/*proc means data = acs_ct_depvars nmiss;*/
/*var total_pop_ct total_pop_u_ct total_pop_l_ct age_45_74_ct age_45_74_u_ct age_45_74_l_ct age_ge65_ct age_ge65_u_ct age_ge65_l_ct male_ct female_ct male_u_ct male_l_ct female_u_ct female_l_ct white_ct black_ct asian_pacislander_ct other_ct white_u_ct black_u_ct asian_pacislander_u_ct other_u_ct white_l_ct black_l_ct asian_pacislander_l_ct other_l_ct hisp_ct hisp_u_ct hisp_l_ct noenrolledinschool_3plus_ct noenrolledinschool_3plus_u_ct noenrolledinschool_3plus_l_ct nohsgrad_25plus_ct nohsgrad_25plus_u_ct nohsgrad_25plus_l_ct unemployed_ct unemployed_u_ct unemployed_l_ct med_houseincome_ct med_houseincome_u_ct med_houseincome_l_ct households_w_publicassist_ct households_w_publicassist_u_ct households_w_publicassist_l_ct socsecinsur_ct socsecinsur_u_ct socsecinsur_l_ct belowpovertyline_ct belowpovertyline_u_ct belowpovertyline_l_ct famkids_poverty_ct famkids_poverty_u_ct famkids_poverty_l_ct householder45plus_poverty_ct householder45plus_poverty2_ct householder45plus_poverty_u_ct householder45plus_poverty2_u_ct householder45plus_poverty_l_ct householder45plus_poverty2_l_ct percapita_income_ct percapita_income_u_ct percapita_income_l_ct not_citizen_ct not_citizen_u_ct not_citizen_l_ct foreign_born_ct foreign_born_u_ct foreign_born_l_ct foreign_lang_ct foreign_lang_u_ct foreign_lang_l_ct commute_60minplus_ct commute_60minplus_u_ct commute_60minplus_l_ct publtrans_bike_walk_ct publtrans_bike_walk_u_ct publtrans_bike_walk_l_ct veteran_ct veteran_u_ct veteran_l_ct nonfam_households_ct nonfam_households_u_ct nonfam_households_l_ct singledad_ct singlemom_ct singledad_u_ct singlemom_u_ct singledad_l_ct singlemom_l_ct house_units_ct house_units_u_ct house_units_l_ct renter_occupied_ct renter_occupied_u_ct renter_occupied_l_ct vacant_ct vacant_u_ct vacant_l_ct no_mortgage_ct no_mortgage_u_ct no_mortgage_l_ct occupantsperroom_ct occupantsperroom_u_ct occupantsperroom_l_ct no_telephone_ct no_telephone_u_ct no_telephone_l_ct no_vehicle_ct no_vehicle_u_ct no_vehicle_l_ct no_heat_ct no_heat_u_ct no_heat_l_ct lack_plumbing_ct lack_plumbing_u_ct lack_plumbing_l_ct lack_kitchen_ct lack_kitchen_u_ct lack_kitchen_l_ct med_yearbuilt_ct med_yearbuilt_u_ct med_yearbuilt_l_ct gini_ct gini_u_ct gini_l_ct moved_1yr_ct moved_1yr_u_ct moved_1yr_l_ct;*/
/*by year1;*/
/*run;*/

libname out "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

data out.acs_ct_depvars;
  set acs_ct_depvars;
run;



/* Block Group */

%macro rename_list_bg(y1,y2);
	data acs&y1._&y2.bg_depvars;
	  set acs&y1._&y2.bg_depvars;
	  	%do i = 1 %to %sysfunc(countw(&var_list.));
			rename
				%scan(&var_list.,&i.) = %sysfunc(substr(%scan(&var_list.,&i.),11))
			;
		%end;
			year1 = "20&y1.";
			year2 = "20&y2.";
	run;
%mend;

%macro importcsv_bg(y1,y2);

dm log 'clear';

proc import datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS\acs&y1._&y2.bg_depvars.csv"
	out = acs&y1._&y2.bg_depvars
	dbms = csv
	replace;
	guessingrows = max;
run;
quit;

proc sql noprint;
	CREATE TABLE VAR_NAMES AS
	SELECT NAME
	FROM DICTIONARY.COLUMNS
	WHERE LIBNAME = "WORK" AND MEMNAME = "ACS&y1._&y2.BG_DEPVARS"
	AND NAME CONTAINS "ACS&y2._5yr";
	SELECT COMPRESS(NAME) INTO :VAR_LIST SEPARATED BY " "
	FROM VAR_NAMES;
quit;

%rename_list_bg(&y1.,&y2.);

proc sort data = acs&y1._&y2.bg_depvars; by year1; run;

%mend;

%importcsv_bg(06,10);
%importcsv_bg(07,11);
%importcsv_bg(08,12);
%importcsv_bg(09,13);
%importcsv_bg(10,14);
%importcsv_bg(11,15);
%importcsv_bg(12,16);
%importcsv_bg(13,17);
%importcsv_bg(14,18);
%importcsv_bg(15,19);

data acs_depvars;
  format geoid;
  set acs06_10bg_depvars (drop = B19083001 B19083001s) acs07_11bg_depvars (drop = B19083001 B19083001s) acs08_12bg_depvars (drop = B19083001 B19083001s) acs09_13bg_depvars (drop = B19083001 B19083001s) acs10_14bg_depvars (drop = B19083001 B19083001s) acs11_15bg_depvars (drop = B19083001 B19083001s) acs12_16bg_depvars (drop = B19083001 B19083001s) acs13_17bg_depvars (drop = B19083001 B19083001s) acs14_18bg_depvars (drop = B19083001 B19083001s) acs15_19bg_depvars (drop = B19083001 B19083001s);
	%bgvars;
	geoidc = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT,Geo_BLKGRP);
	geoid = input(geoidc, BEST.);
	geoid_ctc = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
	geoid_ct = input(geoid_ctc, BEST.);
  keep geoid geoid_ct year1 year2 total_pop total_pop_u total_pop_l age_45_74 age_45_74_u age_45_74_l age_ge65 age_ge65_u age_ge65_l male female male_u male_l female_u female_l white black asian_pacislander other white_u black_u asian_pacislander_u other_u white_l black_l asian_pacislander_l other_l hisp hisp_u hisp_l noenrolledinschool_3plus noenrolledinschool_3plus_u noenrolledinschool_3plus_l nohsgrad_25plus nohsgrad_25plus_u nohsgrad_25plus_l unemployed unemployed_u unemployed_l med_houseincome med_houseincome_u med_houseincome_l households_w_publicassist households_w_publicassist_u households_w_publicassist_l socsecinsur socsecinsur_u socsecinsur_l belowpovertyline belowpovertyline_u belowpovertyline_l famkids_poverty famkids_poverty_u famkids_poverty_l householder45plus_poverty householder45plus_poverty2 householder45plus_poverty_u householder45plus_poverty2_u householder45plus_poverty_l householder45plus_poverty2_l percapita_income percapita_income_u percapita_income_l foreign_lang foreign_lang_u foreign_lang_l commute_60minplus commute_60minplus_u commute_60minplus_l publtrans_bike_walk publtrans_bike_walk_u publtrans_bike_walk_l veteran veteran_u veteran_l nonfam_households nonfam_households_u nonfam_households_l singledad singlemom singledad_u singlemom_u singledad_l singlemom_l house_units house_units_u house_units_l renter_occupied renter_occupied_u renter_occupied_l vacant vacant_u vacant_l no_mortgage no_mortgage_u no_mortgage_l occupantsperroom occupantsperroom_u occupantsperroom_l no_telephone no_telephone_u no_telephone_l no_vehicle no_vehicle_u no_vehicle_l no_heat no_heat_u no_heat_l lack_plumbing lack_plumbing_u lack_plumbing_l lack_kitchen lack_kitchen_u lack_kitchen_l;
run;

proc sort data = acs_depvars; by geoid_ct year1; run;

data out.acs_depvars;
  set acs_depvars;
run; 

/*proc contents data = acs_depvars varnum; run;*/
/*proc print data = acs_depvars (obs=10); run;*/
/*proc means data = acs_depvars nmiss;*/
/*var total_pop total_pop_moe age_45_74 age_45_74_moe age_ge65 age_ge65_moe male female male_moe female_moe white black asian_pacislander other white_moe black_moe asian_pacislander_moe other_moe hisp hisp_moe noenrolledinschool_3plus noenrolledinschool_3plus_moe nohsgrad_25plus nohsgrad_25plus_moe unemployed unemployed_moe med_houseincome med_houseincome_moe households_w_publicassist households_w_publicassist_moe socsecinsur socsecinsur_moe belowpovertyline belowpovertyline_moe famkids_poverty famkids_poverty_moe householder45plus_poverty householder45plus_poverty2 householder45plus_poverty_moe householder45plus_poverty2_moe_c percapita_income percapita_income_moe foreign_lang foreign_lang_moe commute_60minplus commute_60minplus_moe publtrans_bike_walk publtrans_bike_walk_moe veteran veteran_moe nonfam_households nonfam_households_moe singledad singlemom singledad_moe singlemom_moe house_units house_units_moe renter_occupied renter_occupied_moe vacant vacant_moe no_mortgage no_mortgage_moe occupantsperroom occupantsperroom_moe no_telephone no_telephone_moe no_vehicle no_vehicle_moe no_heat no_heat_moe lack_plumbing lack_plumbing_moe lack_kitchen lack_kitchen_moe med_yearbuilt med_yearbuilt_moe;*/
/*by year1;*/
/*run;*/


proc sort data = acs_depvars; by geoid_ct year1; run;

proc sort data = acs_ct_depvars; by geoid_ct year1; run;

data acs_depvars_moe;
  merge acs_depvars acs_ct_depvars;
  by geoid_ct year1;
run; 






/* Merging BG and CT data */

/* export and convert to Rdata. Run WQS to calculate index. */

data out.acs_depvars_moe;
  set acs_depvars_moe;
run; 



total_pop_u age_45_74_u age_ge65_u male_u female_u white_u black_u asian_pacislander_u other_u hisp_u noenrolledinschool_3plus_u nohsgrad_25plus_u unemployed_u med_houseincome_u households_w_publicassist_u socsecinsur_u belowpovertyline_u famkids_poverty_u householder45plus_poverty_u householder45plus_poverty2_u percapita_income_u foreign_lang_u commute_60minplus_u publtrans_bike_walk_u veteran_u nonfam_households_u singledad_u singlemom_u house_units_u renter_occupied_u vacant_u no_mortgage_u occupantsperroom_u no_telephone_u no_vehicle_u no_heat_u lack_plumbing_u lack_kitchen_u gini_u_ct moved_1yr_u_ct not_citizen_u_ct foreign_born_u_ct total_pop_l age_45_74_l age_ge65_l male_l female_l white_l black_l asian_pacislander_l other_l hisp_l noenrolledinschool_3plus_l nohsgrad_25plus_l unemployed_l med_houseincome_l households_w_publicassist_l socsecinsur_l belowpovertyline_l famkids_poverty_l householder45plus_poverty_l householder45plus_poverty2_l percapita_income_l foreign_lang_l commute_60minplus_l publtrans_bike_walk_l veteran_l nonfam_households_l singledad_l singlemom_l house_lnits_l renter_occupied_l vacant_l no_mortgage_l occupantsperroom_l no_telephone_l no_vehicle_l no_heat_l lack_plumbing_l lack_kitchen_l gini_l_ct moved_1yr_l_ct not_citizen_l_ct foreign_born_l_ct

/**************************************************************************/






data acs.acs_raw_ct;
  set acs_06_10_ct
      acs_07_11_ct
      acs_08_12_ct
      acs_09_13_ct
      acs_10_14_ct
      acs_11_15_ct
      acs.acs_12_16_ct
      acs_13_17_ct
      acs_14_18_ct
	  acs.acs_15_19_ct
  ;
run;

/**************************************************************************/











































proc means data = acs.acs_raw_ct nmiss mean maxdec=2 nolabels;
var &ctvarlist.;
by year1;
run;







%macro rename;
rename
esriid = geoid
B19083i1 = B19083001 
B07003i1 = B07003001
B07003i4 = B07003004
B01001i1 = B01001001
B01001i2 = B01001002
B01001i3 = B01001003
B01001i4 = B01001004
B01001i5 = B01001005
B01001i6 = B01001006
B01001i7 = B01001007
B01001i8 = B01001008
B01001i9 = B01001009
B01001i10 = B01001010
B01001i11 = B01001011
B01001i12 = B01001012
B01001i13 = B01001013
B01001i14 = B01001014
B01001i15 = B01001015
B01001i16 = B01001016
B01001i17 = B01001017
B01001i18 = B01001018
B01001i19 = B01001019
B01001i20 = B01001020
B01001i21 = B01001021
B01001i22 = B01001022
B01001i23 = B01001023
B01001i24 = B01001024
B01001i25 = B01001025
B01001i26 = B01001026
B01001i27 = B01001027
B01001i28 = B01001028
B01001i29 = B01001029
B01001i30 = B01001030
B01001i31 = B01001031
B01001i32 = B01001032
B01001i33 = B01001033
B01001i34 = B01001034
B01001i35 = B01001035
B01001i36 = B01001036
B01001i37 = B01001037
B01001i38 = B01001038
B01001i39 = B01001039
B01001i40 = B01001040
B01001i41 = B01001041
B01001i42 = B01001042
B01001i43 = B01001043
B01001i44 = B01001044
B01001i45 = B01001045
B01001i46 = B01001046
B01001i47 = B01001047
B01001i48 = B01001048
B01001i49 = B01001049
B01002Ai1 = B01002A001
B01002Ai2 = B01002A002
B01002Ai3 = B01002A003
B01002Bi1 = B01002B001
B01002Bi2 = B01002B002
B01002Bi3 = B01002B003
B01002Ci1 = B01002C001
B01002Ci2 = B01002C002
B01002Ci3 = B01002C003
B01002Di1 = B01002D001
B01002Di2 = B01002D002
B01002Di3 = B01002D003
B01002Fi1 = B01002F001
B01002Fi2 = B01002F002
B01002Fi3 = B01002F003
B01002Gi1 = B01002G001
B01002Gi2 = B01002G002
B01002Gi3 = B01002G003
B01002Hi1 = B01002H001
B01002Hi2 = B01002H002
B01002Hi3 = B01002H003
B01002Ii1 = B01002I001
B01002Ii2 = B01002I002
B01002Ii3 = B01002I003
B01002i1 = B01002001
B01002i2 = B01002002
B01002i3 = B01002003
B01003i1 = B01003001
B02001i1 = B02001001
B02001i2 = B02001002
B02001i3 = B02001003
B02001i4 = B02001004
B02001i5 = B02001005
B02001i6 = B02001006
B02001i7 = B02001007
B02001i8 = B02001008
B02001i9 = B02001009
B02001i10 = B02001010
B02008i1 = B02008001
B02009i1 = B02009001
B02010i1 = B02010001
B02011i1 = B02011001
B02012i1 = B02012001
B02013i1 = B02013001
B03002i1 = B03002001
B03002i2 = B03002002
B03002i3 = B03002003
B03002i4 = B03002004
B03002i5 = B03002005
B03002i6 = B03002006
B03002i7 = B03002007
B03002i8 = B03002008
B03002i9 = B03002009
B03002i10 = B03002010
B03002i11 = B03002011
B03002i12 = B03002012
B03002i13 = B03002013
B03002i14 = B03002014
B03002i15 = B03002015
B03002i16 = B03002016
B03002i17 = B03002017
B03002i18 = B03002018
B03002i19 = B03002019
B03002i20 = B03002020
B03002i21 = B03002021
B03003i1 = B03003001
B03003i2 = B03003002
B03003i3 = B03003003
B07201i1 = B07201001
B07201i2 = B07201002
B07201i3 = B07201003
B07201i4 = B07201004
B07201i5 = B07201005
B07201i6 = B07201006
B07201i7 = B07201007
B07201i8 = B07201008
B07201i9 = B07201009
B07201i10 = B07201010
B07201i11 = B07201011
B07201i12 = B07201012
B07201i13 = B07201013
B07201i14 = B07201014
B07202i1 = B07202001
B07202i2 = B07202002
B07202i3 = B07202003
B07202i4 = B07202004
B07202i5 = B07202005
B07202i6 = B07202006
B07202i7 = B07202007
B07202i8 = B07202008
B07202i9 = B07202009
B07202i10 = B07202010
B07202i11 = B07202011
B07202i12 = B07202012
B07202i13 = B07202013
B07202i14 = B07202014
B07203i1 = B07203001
B07203i2 = B07203002
B07203i3 = B07203003
B07203i4 = B07203004
B07203i5 = B07203005
B07203i6 = B07203006
B07203i7 = B07203007
B07203i8 = B07203008
B07203i9 = B07203009
B07203i10 = B07203010
B07203i11 = B07203011
C02003i1 = C02003001
C02003i2 = C02003002
C02003i3 = C02003003
C02003i4 = C02003004
C02003i5 = C02003005
C02003i6 = C02003006
C02003i7 = C02003007
C02003i8 = C02003008
C02003i9 = C02003009
C02003i10 = C02003010
C02003i11 = C02003011
C02003i12 = C02003012
C02003i13 = C02003013
C02003i14 = C02003014
C02003i15 = C02003015
C02003i16 = C02003016
C02003i17 = C02003017
C02003i18 = C02003018
C02003i19 = C02003019
B08007i1 = B08007001
B08007i2 = B08007002
B08007i3 = B08007003
B08007i4 = B08007004
B08007i5 = B08007005
B08007i6 = B08007006
B08007i7 = B08007007
B08007i8 = B08007008
B08007i9 = B08007009
B08007i10 = B08007010
B08007i11 = B08007011
B08007i12 = B08007012
B08007i13 = B08007013
B08007i14 = B08007014
B08007i15 = B08007015
B08008i1 = B08008001
B08008i2 = B08008002
B08008i3 = B08008003
B08008i4 = B08008004
B08008i5 = B08008005
B08008i6 = B08008006
B08008i7 = B08008007
B08008i8 = B08008008
B08008i9 = B08008009
B08008i10 = B08008010
B08008i11 = B08008011
B08008i12 = B08008012
B08008i13 = B08008013
B08008i14 = B08008014
B08008i15 = B08008015
B08009i1 = B08009001
B08009i2 = B08009002
B08009i3 = B08009003
B08009i4 = B08009004
B08009i5 = B08009005
B08009i6 = B08009006
B08009i7 = B08009007
B08009i8 = B08009008
B08009i9 = B08009009
B08009i10 = B08009010
B08009i11 = B08009011
B08009i12 = B08009012
B08009i13 = B08009013
B08009i14 = B08009014
B08009i15 = B08009015
B08016i1 = B08016001
B08016i2 = B08016002
B08016i3 = B08016003
B08016i4 = B08016004
B08016i5 = B08016005
B08016i6 = B08016006
B08016i7 = B08016007
B08016i8 = B08016008
B08016i9 = B08016009
B08016i10 = B08016010
B08016i11 = B08016011
B08016i12 = B08016012
B08016i13 = B08016013
B08016i14 = B08016014
B08016i15 = B08016015
B08016i16 = B08016016
B08016i17 = B08016017
B08016i18 = B08016018
B08016i19 = B08016019
B08016i20 = B08016020
B08016i21 = B08016021
B08016i22 = B08016022
B08016i23 = B08016023
B08017i1 = B08017001
B08017i2 = B08017002
B08017i3 = B08017003
B08017i4 = B08017004
B08017i5 = B08017005
B08017i6 = B08017006
B08017i7 = B08017007
B08017i8 = B08017008
B08017i9 = B08017009
B08017i10 = B08017010
B08017i11 = B08017011
B08017i12 = B08017012
B08017i13 = B08017013
B08017i14 = B08017014
B08017i15 = B08017015
B08017i16 = B08017016
B08017i17 = B08017017
B08017i18 = B08017018
B08017i19 = B08017019
B08017i20 = B08017020
B08017i21 = B08017021
B08017i22 = B08017022
B08017i23 = B08017023
B08018i1 = B08018001
B08018i2 = B08018002
B08018i3 = B08018003
B08018i4 = B08018004
B08018i5 = B08018005
B08018i6 = B08018006
B08018i7 = B08018007
B08018i8 = B08018008
B08134i1 = B08134001
B08134i2 = B08134002
B08134i3 = B08134003
B08134i4 = B08134004
B08134i5 = B08134005
B08134i6 = B08134006
B08134i7 = B08134007
B08134i8 = B08134008
B08134i9 = B08134009
B08134i10 = B08134010
B08134i11 = B08134011
B08134i12 = B08134012
B08134i13 = B08134013
B08134i14 = B08134014
B08134i15 = B08134015
B08134i16 = B08134016
B08134i17 = B08134017
B08134i18 = B08134018
B08134i19 = B08134019
B08134i20 = B08134020
B08134i21 = B08134021
B08134i22 = B08134022
B08134i23 = B08134023
B08134i24 = B08134024
B08134i25 = B08134025
B08134i26 = B08134026
B08134i27 = B08134027
B08134i28 = B08134028
B08134i29 = B08134029
B08134i30 = B08134030
B08134i31 = B08134031
B08134i32 = B08134032
B08134i33 = B08134033
B08134i34 = B08134034
B08134i35 = B08134035
B08134i36 = B08134036
B08134i37 = B08134037
B08134i38 = B08134038
B08134i39 = B08134039
B08134i40 = B08134040
B08134i41 = B08134041
B08134i42 = B08134042
B08134i43 = B08134043
B08134i44 = B08134044
B08134i45 = B08134045
B08134i46 = B08134046
B08134i47 = B08134047
B08134i48 = B08134048
B08134i49 = B08134049
B08134i50 = B08134050
B08134i51 = B08134051
B08134i52 = B08134052
B08134i53 = B08134053
B08134i54 = B08134054
B08134i55 = B08134055
B08134i56 = B08134056
B08134i57 = B08134057
B08134i58 = B08134058
B08134i59 = B08134059
B08134i60 = B08134060
B08134i61 = B08134061
B08134i62 = B08134062
B08134i63 = B08134063
B08134i64 = B08134064
B08134i65 = B08134065
B08134i66 = B08134066
B08134i67 = B08134067
B08134i68 = B08134068
B08134i69 = B08134069
B08134i70 = B08134070
B08134i71 = B08134071
B08134i72 = B08134072
B08134i73 = B08134073
B08134i74 = B08134074
B08134i75 = B08134075
B08134i76 = B08134076
B08134i77 = B08134077
B08134i78 = B08134078
B08134i79 = B08134079
B08134i80 = B08134080
B08134i81 = B08134081
B08134i82 = B08134082
B08134i83 = B08134083
B08134i84 = B08134084
B08134i85 = B08134085
B08134i86 = B08134086
B08134i87 = B08134087
B08134i88 = B08134088
B08134i89 = B08134089
B08134i90 = B08134090
B08134i91 = B08134091
B08134i92 = B08134092
B08134i93 = B08134093
B08134i94 = B08134094
B08134i95 = B08134095
B08134i96 = B08134096
B08134i97 = B08134097
B08134i98 = B08134098
B08134i99 = B08134099
B08134i100 = B081340100
B08134i101 = B081340101
B08134i102 = B081340102
B08134i103 = B081340103
B08134i104 = B081340104
B08134i105 = B081340105
B08134i106 = B081340106
B08134i107 = B081340107
B08134i108 = B081340108
B08134i109 = B081340109
B08134i110 = B081340110
B08134i111 = B081340111
B08134i112 = B081340112
B08134i113 = B081340113
B08134i114 = B081340114
B08134i115 = B081340115
B08134i116 = B081340116
B08134i117 = B081340117
B08134i118 = B081340118
B08134i119 = B081340119
B08134i120 = B081340120
B08135i1 = B08135001
B08135i2 = B08135002
B08135i3 = B08135003
B08135i4 = B08135004
B08135i5 = B08135005
B08135i6 = B08135006
B08135i7 = B08135007
B08135i8 = B08135008
B08135i9 = B08135009
B08135i10 = B08135010
B08136i1 = B08136001
B08136i2 = B08136002
B08136i3 = B08136003
B08136i4 = B08136004
B08136i5 = B08136005
B08136i6 = B08136006
B08136i7 = B08136007
B08136i8 = B08136008
B08136i9 = B08136009
B08136i10 = B08136010
B08136i11 = B08136011
B08136i12 = B08136012
B08301i1 = B08301001
B08301i2 = B08301002
B08301i3 = B08301003
B08301i4 = B08301004
B08301i5 = B08301005
B08301i6 = B08301006
B08301i7 = B08301007
B08301i8 = B08301008
B08301i9 = B08301009
B08301i10 = B08301010
B08301i11 = B08301011
B08301i12 = B08301012
B08301i13 = B08301013
B08301i14 = B08301014
B08301i15 = B08301015
B08301i16 = B08301016
B08301i17 = B08301017
B08301i18 = B08301018
B08301i19 = B08301019
B08301i20 = B08301020
B08301i21 = B08301021
B08302i1 = B08302001
B08302i2 = B08302002
B08302i3 = B08302003
B08302i4 = B08302004
B08302i5 = B08302005
B08302i6 = B08302006
B08302i7 = B08302007
B08302i8 = B08302008
B08302i9 = B08302009
B08302i10 = B08302010
B08302i11 = B08302011
B08302i12 = B08302012
B08302i13 = B08302013
B08302i14 = B08302014
B08302i15 = B08302015
B08303i1 = B08303001
B08303i2 = B08303002
B08303i3 = B08303003
B08303i4 = B08303004
B08303i5 = B08303005
B08303i6 = B08303006
B08303i7 = B08303007
B08303i8 = B08303008
B08303i9 = B08303009
B08303i10 = B08303010
B08303i11 = B08303011
B08303i12 = B08303012
B08303i13 = B08303013
B09002i1 = B09002001
B09002i2 = B09002002
B09002i3 = B09002003
B09002i4 = B09002004
B09002i5 = B09002005
B09002i6 = B09002006
B09002i7 = B09002007
B09002i8 = B09002008
B09002i9 = B09002009
B09002i10 = B09002010
B09002i11 = B09002011
B09002i12 = B09002012
B09002i13 = B09002013
B09002i14 = B09002014
B09002i15 = B09002015
B09002i16 = B09002016
B09002i17 = B09002017
B09002i18 = B09002018
B09002i19 = B09002019
B09002i20 = B09002020
B09018i1 = B09018001
B09018i2 = B09018002
B09018i3 = B09018003
B09018i4 = B09018004
B09018i5 = B09018005
B09018i6 = B09018006
B09018i7 = B09018007
B09018i8 = B09018008
B09019i1 = B09019001
B09019i2 = B09019002
B09019i3 = B09019003
B09019i4 = B09019004
B09019i5 = B09019005
B09019i6 = B09019006
B09019i7 = B09019007
B09019i8 = B09019008
B09019i9 = B09019009
B09019i10 = B09019010
B09019i11 = B09019011
B09019i12 = B09019012
B09019i13 = B09019013
B09019i14 = B09019014
B09019i15 = B09019015
B09019i16 = B09019016
B09019i17 = B09019017
B09019i18 = B09019018
B09019i19 = B09019019
B09019i20 = B09019020
B09019i21 = B09019021
B09019i22 = B09019022
B09019i23 = B09019023
B09019i24 = B09019024
B09019i25 = B09019025
B09019i26 = B09019026
B09020i1 = B09020001
B09020i2 = B09020002
B09020i3 = B09020003
B09020i4 = B09020004
B09020i5 = B09020005
B09020i6 = B09020006
B09020i7 = B09020007
B09020i8 = B09020008
B09020i9 = B09020009
B09020i10 = B09020010
B09020i11 = B09020011
B09020i12 = B09020012
B09020i13 = B09020013
B09020i14 = B09020014
B09020i15 = B09020015
B09020i16 = B09020016
B09020i17 = B09020017
B09020i18 = B09020018
B09020i19 = B09020019
B09020i20 = B09020020
B09020i21 = B09020021
B09021i1 = B09021001
B09021i2 = B09021002
B09021i3 = B09021003
B09021i4 = B09021004
B09021i5 = B09021005
B09021i6 = B09021006
B09021i7 = B09021007
B09021i8 = B09021008
B09021i9 = B09021009
B09021i10 = B09021010
B09021i11 = B09021011
B09021i12 = B09021012
B09021i13 = B09021013
B09021i14 = B09021014
B09021i15 = B09021015
B09021i16 = B09021016
B09021i17 = B09021017
B09021i18 = B09021018
B09021i19 = B09021019
B09021i20 = B09021020
B09021i21 = B09021021
B09021i22 = B09021022
B09021i23 = B09021023
B09021i24 = B09021024
B09021i25 = B09021025
B09021i26 = B09021026
B09021i27 = B09021027
B09021i28 = B09021028
B11001Ai1 = B11001A001
B11001Ai2 = B11001A002
B11001Ai3 = B11001A003
B11001Ai4 = B11001A004
B11001Ai5 = B11001A005
B11001Ai6 = B11001A006
B11001Ai7 = B11001A007
B11001Ai8 = B11001A008
B11001Ai9 = B11001A009
B11001Bi1 = B11001B001
B11001Bi2 = B11001B002
B11001Bi3 = B11001B003
B11001Bi4 = B11001B004
B11001Bi5 = B11001B005
B11001Bi6 = B11001B006
B11001Bi7 = B11001B007
B11001Bi8 = B11001B008
B11001Bi9 = B11001B009
B11001Ci1 = B11001C001
B11001Ci2 = B11001C002
B11001Ci3 = B11001C003
B11001Ci4 = B11001C004
B11001Ci5 = B11001C005
B11001Ci6 = B11001C006
B11001Ci7 = B11001C007
B11001Ci8 = B11001C008
B11001Ci9 = B11001C009
B11001Di1 = B11001D001
B11001Di2 = B11001D002
B11001Di3 = B11001D003
B11001Di4 = B11001D004
B11001Di5 = B11001D005
B11001Di6 = B11001D006
B11001Di7 = B11001D007
B11001Di8 = B11001D008
B11001Di9 = B11001D009
B11001Ei1 = B11001E001
B11001Ei2 = B11001E002
B11001Ei3 = B11001E003
B11001Ei4 = B11001E004
B11001Ei5 = B11001E005
B11001Ei6 = B11001E006
B11001Ei7 = B11001E007
B11001Ei8 = B11001E008
B11001Ei9 = B11001E009
B11001Fi1 = B11001F001
B11001Fi2 = B11001F002
B11001Fi3 = B11001F003
B11001Fi4 = B11001F004
B11001Fi5 = B11001F005
B11001Fi6 = B11001F006
B11001Fi7 = B11001F007
B11001Fi8 = B11001F008
B11001Fi9 = B11001F009
B11001Gi1 = B11001G001
B11001Gi2 = B11001G002
B11001Gi3 = B11001G003
B11001Gi4 = B11001G004
B11001Gi5 = B11001G005
B11001Gi6 = B11001G006
B11001Gi7 = B11001G007
B11001Gi8 = B11001G008
B11001Gi9 = B11001G009
B11001Hi1 = B11001H001
B11001Hi2 = B11001H002
B11001Hi3 = B11001H003
B11001Hi4 = B11001H004
B11001Hi5 = B11001H005
B11001Hi6 = B11001H006
B11001Hi7 = B11001H007
B11001Hi8 = B11001H008
B11001Hi9 = B11001H009
B11001Ii1 = B11001I001
B11001Ii2 = B11001I002
B11001Ii3 = B11001I003
B11001Ii4 = B11001I004
B11001Ii5 = B11001I005
B11001Ii6 = B11001I006
B11001Ii7 = B11001I007
B11001Ii8 = B11001I008
B11001Ii9 = B11001I009
B11001i1 = B11001001
B11001i2 = B11001002
B11001i3 = B11001003
B11001i4 = B11001004
B11001i5 = B11001005
B11001i6 = B11001006
B11001i7 = B11001007
B11001i8 = B11001008
B11001i9 = B11001009
B11002Ai1 = B11002A001
B11002Ai2 = B11002A002
B11002Ai3 = B11002A003
B11002Ai4 = B11002A004
B11002Ai5 = B11002A005
B11002Ai6 = B11002A006
B11002Ai7 = B11002A007
B11002Ai8 = B11002A008
B11002Ai9 = B11002A009
B11002Ai10 = B11002A010
B11002Ai11 = B11002A011
B11002Ai12 = B11002A012
B11002Bi1 = B11002B001
B11002Bi2 = B11002B002
B11002Bi3 = B11002B003
B11002Bi4 = B11002B004
B11002Bi5 = B11002B005
B11002Bi6 = B11002B006
B11002Bi7 = B11002B007
B11002Bi8 = B11002B008
B11002Bi9 = B11002B009
B11002Bi10 = B11002B010
B11002Bi11 = B11002B011
B11002Bi12 = B11002B012
B11002Ci1 = B11002C001
B11002Ci2 = B11002C002
B11002Ci3 = B11002C003
B11002Ci4 = B11002C004
B11002Ci5 = B11002C005
B11002Ci6 = B11002C006
B11002Ci7 = B11002C007
B11002Ci8 = B11002C008
B11002Ci9 = B11002C009
B11002Ci10 = B11002C010
B11002Ci11 = B11002C011
B11002Ci12 = B11002C012
B11002Di1 = B11002D001
B11002Di2 = B11002D002
B11002Di3 = B11002D003
B11002Di4 = B11002D004
B11002Di5 = B11002D005
B11002Di6 = B11002D006
B11002Di7 = B11002D007
B11002Di8 = B11002D008
B11002Di9 = B11002D009
B11002Di10 = B11002D010
B11002Di11 = B11002D011
B11002Di12 = B11002D012
B11002Ei1 = B11002E001
B11002Ei2 = B11002E002
B11002Ei3 = B11002E003
B11002Ei4 = B11002E004
B11002Ei5 = B11002E005
B11002Ei6 = B11002E006
B11002Ei7 = B11002E007
B11002Ei8 = B11002E008
B11002Ei9 = B11002E009
B11002Ei10 = B11002E010
B11002Ei11 = B11002E011
B11002Ei12 = B11002E012
B11002Fi1 = B11002F001
B11002Fi2 = B11002F002
B11002Fi3 = B11002F003
B11002Fi4 = B11002F004
B11002Fi5 = B11002F005
B11002Fi6 = B11002F006
B11002Fi7 = B11002F007
B11002Fi8 = B11002F008
B11002Fi9 = B11002F009
B11002Fi10 = B11002F010
B11002Fi11 = B11002F011
B11002Fi12 = B11002F012
B11002Gi1 = B11002G001
B11002Gi2 = B11002G002
B11002Gi3 = B11002G003
B11002Gi4 = B11002G004
B11002Gi5 = B11002G005
B11002Gi6 = B11002G006
B11002Gi7 = B11002G007
B11002Gi8 = B11002G008
B11002Gi9 = B11002G009
B11002Gi10 = B11002G010
B11002Gi11 = B11002G011
B11002Gi12 = B11002G012
B11002Hi1 = B11002H001
B11002Hi2 = B11002H002
B11002Hi3 = B11002H003
B11002Hi4 = B11002H004
B11002Hi5 = B11002H005
B11002Hi6 = B11002H006
B11002Hi7 = B11002H007
B11002Hi8 = B11002H008
B11002Hi9 = B11002H009
B11002Hi10 = B11002H010
B11002Hi11 = B11002H011
B11002Hi12 = B11002H012
B11002Ii1 = B11002I001
B11002Ii2 = B11002I002
B11002Ii3 = B11002I003
B11002Ii4 = B11002I004
B11002Ii5 = B11002I005
B11002Ii6 = B11002I006
B11002Ii7 = B11002I007
B11002Ii8 = B11002I008
B11002Ii9 = B11002I009
B11002Ii10 = B11002I010
B11002Ii11 = B11002I011
B11002Ii12 = B11002I012
B11002i1 = B11002001
B11002i2 = B11002002
B11002i3 = B11002003
B11002i4 = B11002004
B11002i5 = B11002005
B11002i6 = B11002006
B11002i7 = B11002007
B11002i8 = B11002008
B11002i9 = B11002009
B11002i10 = B11002010
B11002i11 = B11002011
B11002i12 = B11002012
B11003i1 = B11003001
B11003i2 = B11003002
B11003i3 = B11003003
B11003i4 = B11003004
B11003i5 = B11003005
B11003i6 = B11003006
B11003i7 = B11003007
B11003i8 = B11003008
B11003i9 = B11003009
B11003i10 = B11003010
B11003i11 = B11003011
B11003i12 = B11003012
B11003i13 = B11003013
B11003i14 = B11003014
B11003i15 = B11003015
B11003i16 = B11003016
B11003i17 = B11003017
B11003i18 = B11003018
B11003i19 = B11003019
B11003i20 = B11003020
B11004i1 = B11004001
B11004i2 = B11004002
B11004i3 = B11004003
B11004i4 = B11004004
B11004i5 = B11004005
B11004i6 = B11004006
B11004i7 = B11004007
B11004i8 = B11004008
B11004i9 = B11004009
B11004i10 = B11004010
B11004i11 = B11004011
B11004i12 = B11004012
B11004i13 = B11004013
B11004i14 = B11004014
B11004i15 = B11004015
B11004i16 = B11004016
B11004i17 = B11004017
B11004i18 = B11004018
B11004i19 = B11004019
B11004i20 = B11004020
B11005i1 = B11005001
B11005i2 = B11005002
B11005i3 = B11005003
B11005i4 = B11005004
B11005i5 = B11005005
B11005i6 = B11005006
B11005i7 = B11005007
B11005i8 = B11005008
B11005i9 = B11005009
B11005i10 = B11005010
B11005i11 = B11005011
B11005i12 = B11005012
B11005i13 = B11005013
B11005i14 = B11005014
B11005i15 = B11005015
B11005i16 = B11005016
B11005i17 = B11005017
B11005i18 = B11005018
B11005i19 = B11005019
B11006i1 = B11006001
B11006i2 = B11006002
B11006i3 = B11006003
B11006i4 = B11006004
B11006i5 = B11006005
B11006i6 = B11006006
B11006i7 = B11006007
B11006i8 = B11006008
B11006i9 = B11006009
B11006i10 = B11006010
B11006i11 = B11006011
B11006i12 = B11006012
B11006i13 = B11006013
B11006i14 = B11006014
B11006i15 = B11006015
B11007i1 = B11007001
B11007i2 = B11007002
B11007i3 = B11007003
B11007i4 = B11007004
B11007i5 = B11007005
B11007i6 = B11007006
B11007i7 = B11007007
B11007i8 = B11007008
B11007i9 = B11007009
B11007i10 = B11007010
B11007i11 = B11007011
B11008i1 = B11008001
B11008i2 = B11008002
B11008i3 = B11008003
B11008i4 = B11008004
B11008i5 = B11008005
B11008i6 = B11008006
B11008i7 = B11008007
B11008i8 = B11008008
B11012i1 = B11012001
B11012i2 = B11012002
B11012i3 = B11012003
B11012i4 = B11012004
B11012i5 = B11012005
B11012i6 = B11012006
B11012i7 = B11012007
B11012i8 = B11012008
B11012i9 = B11012009
B11012i10 = B11012010
B11012i11 = B11012011
B11012i12 = B11012012
B11012i13 = B11012013
B11012i14 = B11012014
B11012i15 = B11012015
B11012i16 = B11012016
B11012i17 = B11012017
B11015i1 = B11015001
B11015i2 = B11015002
B11015i3 = B11015003
B11016i1 = B11016001
B11016i2 = B11016002
B11016i3 = B11016003
B11016i4 = B11016004
B11016i5 = B11016005
B11016i6 = B11016006
B11016i7 = B11016007
B11016i8 = B11016008
B11016i9 = B11016009
B11016i10 = B11016010
B11016i11 = B11016011
B11016i12 = B11016012
B11016i13 = B11016013
B11016i14 = B11016014
B11016i15 = B11016015
B11016i16 = B11016016
B12001i1 = B12001001
B12001i2 = B12001002
B12001i3 = B12001003
B12001i4 = B12001004
B12001i5 = B12001005
B12001i6 = B12001006
B12001i7 = B12001007
B12001i8 = B12001008
B12001i9 = B12001009
B12001i10 = B12001010
B12001i11 = B12001011
B12001i12 = B12001012
B12001i13 = B12001013
B12001i14 = B12001014
B12001i15 = B12001015
B12001i16 = B12001016
B12001i17 = B12001017
B12001i18 = B12001018
B12001i19 = B12001019
B14002i1 = B14002001
B14002i2 = B14002002
B14002i3 = B14002003
B14002i4 = B14002004
B14002i5 = B14002005
B14002i6 = B14002006
B14002i7 = B14002007
B14002i8 = B14002008
B14002i9 = B14002009
B14002i10 = B14002010
B14002i11 = B14002011
B14002i12 = B14002012
B14002i13 = B14002013
B14002i14 = B14002014
B14002i15 = B14002015
B14002i16 = B14002016
B14002i17 = B14002017
B14002i18 = B14002018
B14002i19 = B14002019
B14002i20 = B14002020
B14002i21 = B14002021
B14002i22 = B14002022
B14002i23 = B14002023
B14002i24 = B14002024
B14002i25 = B14002025
B14002i26 = B14002026
B14002i27 = B14002027
B14002i28 = B14002028
B14002i29 = B14002029
B14002i30 = B14002030
B14002i31 = B14002031
B14002i32 = B14002032
B14002i33 = B14002033
B14002i34 = B14002034
B14002i35 = B14002035
B14002i36 = B14002036
B14002i37 = B14002037
B14002i38 = B14002038
B14002i39 = B14002039
B14002i40 = B14002040
B14002i41 = B14002041
B14002i42 = B14002042
B14002i43 = B14002043
B14002i44 = B14002044
B14002i45 = B14002045
B14002i46 = B14002046
B14002i47 = B14002047
B14002i48 = B14002048
B14002i49 = B14002049
B14005i1 = B14005001
B14005i2 = B14005002
B14005i3 = B14005003
B14005i4 = B14005004
B14005i5 = B14005005
B14005i6 = B14005006
B14005i7 = B14005007
B14005i8 = B14005008
B14005i9 = B14005009
B14005i10 = B14005010
B14005i11 = B14005011
B14005i12 = B14005012
B14005i13 = B14005013
B14005i14 = B14005014
B14005i15 = B14005015
B14005i16 = B14005016
B14005i17 = B14005017
B14005i18 = B14005018
B14005i19 = B14005019
B14005i20 = B14005020
B14005i21 = B14005021
B14005i22 = B14005022
B14005i23 = B14005023
B14005i24 = B14005024
B14005i25 = B14005025
B14005i26 = B14005026
B14005i27 = B14005027
B14005i28 = B14005028
B14005i29 = B14005029
B14007Ai1 = B14007A001
B14007Ai2 = B14007A002
B14007Ai3 = B14007A003
B14007Ai4 = B14007A004
B14007Ai5 = B14007A005
B14007Ai6 = B14007A006
B14007Ai7 = B14007A007
B14007Ai8 = B14007A008
B14007Ai9 = B14007A009
B14007Ai10 = B14007A010
B14007Ai11 = B14007A011
B14007Ai12 = B14007A012
B14007Ai13 = B14007A013
B14007Ai14 = B14007A014
B14007Ai15 = B14007A015
B14007Ai16 = B14007A016
B14007Ai17 = B14007A017
B14007Ai18 = B14007A018
B14007Ai19 = B14007A019
B14007Bi1 = B14007B001
B14007Bi2 = B14007B002
B14007Bi3 = B14007B003
B14007Bi4 = B14007B004
B14007Bi5 = B14007B005
B14007Bi6 = B14007B006
B14007Bi7 = B14007B007
B14007Bi8 = B14007B008
B14007Bi9 = B14007B009
B14007Bi10 = B14007B010
B14007Bi11 = B14007B011
B14007Bi12 = B14007B012
B14007Bi13 = B14007B013
B14007Bi14 = B14007B014
B14007Bi15 = B14007B015
B14007Bi16 = B14007B016
B14007Bi17 = B14007B017
B14007Bi18 = B14007B018
B14007Bi19 = B14007B019
B14007Ci1 = B14007C001
B14007Ci2 = B14007C002
B14007Ci3 = B14007C003
B14007Ci4 = B14007C004
B14007Ci5 = B14007C005
B14007Ci6 = B14007C006
B14007Ci7 = B14007C007
B14007Ci8 = B14007C008
B14007Ci9 = B14007C009
B14007Ci10 = B14007C010
B14007Ci11 = B14007C011
B14007Ci12 = B14007C012
B14007Ci13 = B14007C013
B14007Ci14 = B14007C014
B14007Ci15 = B14007C015
B14007Ci16 = B14007C016
B14007Ci17 = B14007C017
B14007Ci18 = B14007C018
B14007Ci19 = B14007C019
B14007Di1 = B14007D001
B14007Di2 = B14007D002
B14007Di3 = B14007D003
B14007Di4 = B14007D004
B14007Di5 = B14007D005
B14007Di6 = B14007D006
B14007Di7 = B14007D007
B14007Di8 = B14007D008
B14007Di9 = B14007D009
B14007Di10 = B14007D010
B14007Di11 = B14007D011
B14007Di12 = B14007D012
B14007Di13 = B14007D013
B14007Di14 = B14007D014
B14007Di15 = B14007D015
B14007Di16 = B14007D016
B14007Di17 = B14007D017
B14007Di18 = B14007D018
B14007Di19 = B14007D019
B14007Ei1 = B14007E001
B14007Ei2 = B14007E002
B14007Ei3 = B14007E003
B14007Ei4 = B14007E004
B14007Ei5 = B14007E005
B14007Ei6 = B14007E006
B14007Ei7 = B14007E007
B14007Ei8 = B14007E008
B14007Ei9 = B14007E009
B14007Ei10 = B14007E010
B14007Ei11 = B14007E011
B14007Ei12 = B14007E012
B14007Ei13 = B14007E013
B14007Ei14 = B14007E014
B14007Ei15 = B14007E015
B14007Ei16 = B14007E016
B14007Ei17 = B14007E017
B14007Ei18 = B14007E018
B14007Ei19 = B14007E019
B14007Fi1 = B14007F001
B14007Fi2 = B14007F002
B14007Fi3 = B14007F003
B14007Fi4 = B14007F004
B14007Fi5 = B14007F005
B14007Fi6 = B14007F006
B14007Fi7 = B14007F007
B14007Fi8 = B14007F008
B14007Fi9 = B14007F009
B14007Fi10 = B14007F010
B14007Fi11 = B14007F011
B14007Fi12 = B14007F012
B14007Fi13 = B14007F013
B14007Fi14 = B14007F014
B14007Fi15 = B14007F015
B14007Fi16 = B14007F016
B14007Fi17 = B14007F017
B14007Fi18 = B14007F018
B14007Fi19 = B14007F019
B14007Gi1 = B14007G001
B14007Gi2 = B14007G002
B14007Gi3 = B14007G003
B14007Gi4 = B14007G004
B14007Gi5 = B14007G005
B14007Gi6 = B14007G006
B14007Gi7 = B14007G007
B14007Gi8 = B14007G008
B14007Gi9 = B14007G009
B14007Gi10 = B14007G010
B14007Gi11 = B14007G011
B14007Gi12 = B14007G012
B14007Gi13 = B14007G013
B14007Gi14 = B14007G014
B14007Gi15 = B14007G015
B14007Gi16 = B14007G016
B14007Gi17 = B14007G017
B14007Gi18 = B14007G018
B14007Gi19 = B14007G019
B14007Hi1 = B14007H001
B14007Hi2 = B14007H002
B14007Hi3 = B14007H003
B14007Hi4 = B14007H004
B14007Hi5 = B14007H005
B14007Hi6 = B14007H006
B14007Hi7 = B14007H007
B14007Hi8 = B14007H008
B14007Hi9 = B14007H009
B14007Hi10 = B14007H010
B14007Hi11 = B14007H011
B14007Hi12 = B14007H012
B14007Hi13 = B14007H013
B14007Hi14 = B14007H014
B14007Hi15 = B14007H015
B14007Hi16 = B14007H016
B14007Hi17 = B14007H017
B14007Hi18 = B14007H018
B14007Hi19 = B14007H019
B14007Ii1 = B14007I001
B14007Ii2 = B14007I002
B14007Ii3 = B14007I003
B14007Ii4 = B14007I004
B14007Ii5 = B14007I005
B14007Ii6 = B14007I006
B14007Ii7 = B14007I007
B14007Ii8 = B14007I008
B14007Ii9 = B14007I009
B14007Ii10 = B14007I010
B14007Ii11 = B14007I011
B14007Ii12 = B14007I012
B14007Ii13 = B14007I013
B14007Ii14 = B14007I014
B14007Ii15 = B14007I015
B14007Ii16 = B14007I016
B14007Ii17 = B14007I017
B14007Ii18 = B14007I018
B14007Ii19 = B14007I019
B14007i1 = B14007001
B14007i2 = B14007002
B14007i3 = B14007003
B14007i4 = B14007004
B14007i5 = B14007005
B14007i6 = B14007006
B14007i7 = B14007007
B14007i8 = B14007008
B14007i9 = B14007009
B14007i10 = B14007010
B14007i11 = B14007011
B14007i12 = B14007012
B14007i13 = B14007013
B14007i14 = B14007014
B14007i15 = B14007015
B14007i16 = B14007016
B14007i17 = B14007017
B14007i18 = B14007018
B14007i19 = B14007019
B15002i1 = B15002001
B15002i2 = B15002002
B15002i3 = B15002003
B15002i4 = B15002004
B15002i5 = B15002005
B15002i6 = B15002006
B15002i7 = B15002007
B15002i8 = B15002008
B15002i9 = B15002009
B15002i10 = B15002010
B15002i11 = B15002011
B15002i12 = B15002012
B15002i13 = B15002013
B15002i14 = B15002014
B15002i15 = B15002015
B15002i16 = B15002016
B15002i17 = B15002017
B15002i18 = B15002018
B15002i19 = B15002019
B15002i20 = B15002020
B15002i21 = B15002021
B15002i22 = B15002022
B15002i23 = B15002023
B15002i24 = B15002024
B15002i25 = B15002025
B15002i26 = B15002026
B15002i27 = B15002027
B15002i28 = B15002028
B15002i29 = B15002029
B15002i30 = B15002030
B15002i31 = B15002031
B15002i32 = B15002032
B15002i33 = B15002033
B15002i34 = B15002034
B15002i35 = B15002035
B15003i1 = B15003001
B15003i2 = B15003002
B15003i3 = B15003003
B15003i4 = B15003004
B15003i5 = B15003005
B15003i6 = B15003006
B15003i7 = B15003007
B15003i8 = B15003008
B15003i9 = B15003009
B15003i10 = B15003010
B15003i11 = B15003011
B15003i12 = B15003012
B15003i13 = B15003013
B15003i14 = B15003014
B15003i15 = B15003015
B15003i16 = B15003016
B15003i17 = B15003017
B15003i18 = B15003018
B15003i19 = B15003019
B15003i20 = B15003020
B15003i21 = B15003021
B15003i22 = B15003022
B15003i23 = B15003023
B15003i24 = B15003024
B15003i25 = B15003025
B15011i1 = B15011001
B15011i2 = B15011002
B15011i3 = B15011003
B15011i4 = B15011004
B15011i5 = B15011005
B15011i6 = B15011006
B15011i7 = B15011007
B15011i8 = B15011008
B15011i9 = B15011009
B15011i10 = B15011010
B15011i11 = B15011011
B15011i12 = B15011012
B15011i13 = B15011013
B15011i14 = B15011014
B15011i15 = B15011015
B15011i16 = B15011016
B15011i17 = B15011017
B15011i18 = B15011018
B15011i19 = B15011019
B15011i20 = B15011020
B15011i21 = B15011021
B15011i22 = B15011022
B15011i23 = B15011023
B15011i24 = B15011024
B15011i25 = B15011025
B15011i26 = B15011026
B15011i27 = B15011027
B15011i28 = B15011028
B15011i29 = B15011029
B15011i30 = B15011030
B15011i31 = B15011031
B15011i32 = B15011032
B15011i33 = B15011033
B15011i34 = B15011034
B15011i35 = B15011035
B15011i36 = B15011036
B15011i37 = B15011037
B15011i38 = B15011038
B15011i39 = B15011039
B15012i1 = B15012001
B15012i2 = B15012002
B15012i3 = B15012003
B15012i4 = B15012004
B15012i5 = B15012005
B15012i6 = B15012006
B15012i7 = B15012007
B15012i8 = B15012008
B15012i9 = B15012009
B15012i10 = B15012010
B15012i11 = B15012011
B15012i12 = B15012012
B15012i13 = B15012013
B15012i14 = B15012014
B15012i15 = B15012015
B15012i16 = B15012016
B16004i1 = B16004001
B16004i2 = B16004002
B16004i3 = B16004003
B16004i4 = B16004004
B16004i5 = B16004005
B16004i6 = B16004006
B16004i7 = B16004007
B16004i8 = B16004008
B16004i9 = B16004009
B16004i10 = B16004010
B16004i11 = B16004011
B16004i12 = B16004012
B16004i13 = B16004013
B16004i14 = B16004014
B16004i15 = B16004015
B16004i16 = B16004016
B16004i17 = B16004017
B16004i18 = B16004018
B16004i19 = B16004019
B16004i20 = B16004020
B16004i21 = B16004021
B16004i22 = B16004022
B16004i23 = B16004023
B16004i24 = B16004024
B16004i25 = B16004025
B16004i26 = B16004026
B16004i27 = B16004027
B16004i28 = B16004028
B16004i29 = B16004029
B16004i30 = B16004030
B16004i31 = B16004031
B16004i32 = B16004032
B16004i33 = B16004033
B16004i34 = B16004034
B16004i35 = B16004035
B16004i36 = B16004036
B16004i37 = B16004037
B16004i38 = B16004038
B16004i39 = B16004039
B16004i40 = B16004040
B16004i41 = B16004041
B16004i42 = B16004042
B16004i43 = B16004043
B16004i44 = B16004044
B16004i45 = B16004045
B16004i46 = B16004046
B16004i47 = B16004047
B16004i48 = B16004048
B16004i49 = B16004049
B16004i50 = B16004050
B16004i51 = B16004051
B16004i52 = B16004052
B16004i53 = B16004053
B16004i54 = B16004054
B16004i55 = B16004055
B16004i56 = B16004056
B16004i57 = B16004057
B16004i58 = B16004058
B16004i59 = B16004059
B16004i60 = B16004060
B16004i61 = B16004061
B16004i62 = B16004062
B16004i63 = B16004063
B16004i64 = B16004064
B16004i65 = B16004065
B16004i66 = B16004066
B16004i67 = B16004067
C15010Ai1 = C15010A001
C15010Ai2 = C15010A002
C15010Ai3 = C15010A003
C15010Ai4 = C15010A004
C15010Ai5 = C15010A005
C15010Ai6 = C15010A006
C15010Bi1 = C15010B001
C15010Bi2 = C15010B002
C15010Bi3 = C15010B003
C15010Bi4 = C15010B004
C15010Bi5 = C15010B005
C15010Bi6 = C15010B006
C15010Ci1 = C15010C001
C15010Ci2 = C15010C002
C15010Ci3 = C15010C003
C15010Ci4 = C15010C004
C15010Ci5 = C15010C005
C15010Ci6 = C15010C006
C15010Di1 = C15010D001
C15010Di2 = C15010D002
C15010Di3 = C15010D003
C15010Di4 = C15010D004
C15010Di5 = C15010D005
C15010Di6 = C15010D006
C15010Ei1 = C15010E001
C15010Ei2 = C15010E002
C15010Ei3 = C15010E003
C15010Ei4 = C15010E004
C15010Ei5 = C15010E005
C15010Ei6 = C15010E006
C15010Fi1 = C15010F001
C15010Fi2 = C15010F002
C15010Fi3 = C15010F003
C15010Fi4 = C15010F004
C15010Fi5 = C15010F005
C15010Fi6 = C15010F006
C15010Gi1 = C15010G001
C15010Gi2 = C15010G002
C15010Gi3 = C15010G003
C15010Gi4 = C15010G004
C15010Gi5 = C15010G005
C15010Gi6 = C15010G006
C15010Hi1 = C15010H001
C15010Hi2 = C15010H002
C15010Hi3 = C15010H003
C15010Hi4 = C15010H004
C15010Hi5 = C15010H005
C15010Hi6 = C15010H006
C15010Ii1 = C15010I001
C15010Ii2 = C15010I002
C15010Ii3 = C15010I003
C15010Ii4 = C15010I004
C15010Ii5 = C15010I005
C15010Ii6 = C15010I006
C15010i1 = C15010001
C15010i2 = C15010002
C15010i3 = C15010003
C15010i4 = C15010004
C15010i5 = C15010005
C15010i6 = C15010006
C16002i1 = C16002001
C16002i2 = C16002002
C16002i3 = C16002003
C16002i4 = C16002004
C16002i5 = C16002005
C16002i6 = C16002006
C16002i7 = C16002007
C16002i8 = C16002008
C16002i9 = C16002009
C16002i10 = C16002010
C16002i11 = C16002011
C16002i12 = C16002012
C16002i13 = C16002013
C16002i14 = C16002014
B17010i1 = B17010001
B17010i2 = B17010002
B17010i3 = B17010003
B17010i4 = B17010004
B17010i5 = B17010005
B17010i6 = B17010006
B17010i7 = B17010007
B17010i8 = B17010008
B17010i9 = B17010009
B17010i10 = B17010010
B17010i11 = B17010011
B17010i12 = B17010012
B17010i13 = B17010013
B17010i14 = B17010014
B17010i15 = B17010015
B17010i16 = B17010016
B17010i17 = B17010017
B17010i18 = B17010018
B17010i19 = B17010019
B17010i20 = B17010020
B17010i21 = B17010021
B17010i22 = B17010022
B17010i23 = B17010023
B17010i24 = B17010024
B17010i25 = B17010025
B17010i26 = B17010026
B17010i27 = B17010027
B17010i28 = B17010028
B17010i29 = B17010029
B17010i30 = B17010030
B17010i31 = B17010031
B17010i32 = B17010032
B17010i33 = B17010033
B17010i34 = B17010034
B17010i35 = B17010035
B17010i36 = B17010036
B17010i37 = B17010037
B17010i38 = B17010038
B17010i39 = B17010039
B17010i40 = B17010040
B17010i41 = B17010041
B17017i1 = B17017001
B17017i2 = B17017002
B17017i3 = B17017003
B17017i4 = B17017004
B17017i5 = B17017005
B17017i6 = B17017006
B17017i7 = B17017007
B17017i8 = B17017008
B17017i9 = B17017009
B17017i10 = B17017010
B17017i11 = B17017011
B17017i12 = B17017012
B17017i13 = B17017013
B17017i14 = B17017014
B17017i15 = B17017015
B17017i16 = B17017016
B17017i17 = B17017017
B17017i18 = B17017018
B17017i19 = B17017019
B17017i20 = B17017020
B17017i21 = B17017021
B17017i22 = B17017022
B17017i23 = B17017023
B17017i24 = B17017024
B17017i25 = B17017025
B17017i26 = B17017026
B17017i27 = B17017027
B17017i28 = B17017028
B17017i29 = B17017029
B17017i30 = B17017030
B17017i31 = B17017031
B17017i32 = B17017032
B17017i33 = B17017033
B17017i34 = B17017034
B17017i35 = B17017035
B17017i36 = B17017036
B17017i37 = B17017037
B17017i38 = B17017038
B17017i39 = B17017039
B17017i40 = B17017040
B17017i41 = B17017041
B17017i42 = B17017042
B17017i43 = B17017043
B17017i44 = B17017044
B17017i45 = B17017045
B17017i46 = B17017046
B17017i47 = B17017047
B17017i48 = B17017048
B17017i49 = B17017049
B17017i50 = B17017050
B17017i51 = B17017051
B17017i52 = B17017052
B17017i53 = B17017053
B17017i54 = B17017054
B17017i55 = B17017055
B17017i56 = B17017056
B17017i57 = B17017057
B17017i58 = B17017058
B17017i59 = B17017059
B17021i1 = B17021001
B17021i2 = B17021002
B17021i3 = B17021003
B17021i4 = B17021004
B17021i5 = B17021005
B17021i6 = B17021006
B17021i7 = B17021007
B17021i8 = B17021008
B17021i9 = B17021009
B17021i10 = B17021010
B17021i11 = B17021011
B17021i12 = B17021012
B17021i13 = B17021013
B17021i14 = B17021014
B17021i15 = B17021015
B17021i16 = B17021016
B17021i17 = B17021017
B17021i18 = B17021018
B17021i19 = B17021019
B17021i20 = B17021020
B17021i21 = B17021021
B17021i22 = B17021022
B17021i23 = B17021023
B17021i24 = B17021024
B17021i25 = B17021025
B17021i26 = B17021026
B17021i27 = B17021027
B17021i28 = B17021028
B17021i29 = B17021029
B17021i30 = B17021030
B17021i31 = B17021031
B17021i32 = B17021032
B17021i33 = B17021033
B17021i34 = B17021034
B17021i35 = B17021035
B19001i1 = B19001001
B19001i2 = B19001002
B19001i3 = B19001003
B19001i4 = B19001004
B19001i5 = B19001005
B19001i6 = B19001006
B19001i7 = B19001007
B19001i8 = B19001008
B19001i9 = B19001009
B19001i10 = B19001010
B19001i11 = B19001011
B19001i12 = B19001012
B19001i13 = B19001013
B19001i14 = B19001014
B19001i15 = B19001015
B19001i16 = B19001016
B19001i17 = B19001017
B19013i1 = B19013001
B19025Ai1 = B19025A001
B19025Bi1 = B19025B001
B19025Hi1 = B19025H001
B19025i1 = B19025001
B19037i1 = B19037001
B19037i2 = B19037002
B19037i3 = B19037003
B19037i4 = B19037004
B19037i5 = B19037005
B19037i6 = B19037006
B19037i7 = B19037007
B19037i8 = B19037008
B19037i9 = B19037009
B19037i10 = B19037010
B19037i11 = B19037011
B19037i12 = B19037012
B19037i13 = B19037013
B19037i14 = B19037014
B19037i15 = B19037015
B19037i16 = B19037016
B19037i17 = B19037017
B19037i18 = B19037018
B19037i19 = B19037019
B19037i20 = B19037020
B19037i21 = B19037021
B19037i22 = B19037022
B19037i23 = B19037023
B19037i24 = B19037024
B19037i25 = B19037025
B19037i26 = B19037026
B19037i27 = B19037027
B19037i28 = B19037028
B19037i29 = B19037029
B19037i30 = B19037030
B19037i31 = B19037031
B19037i32 = B19037032
B19037i33 = B19037033
B19037i34 = B19037034
B19037i35 = B19037035
B19037i36 = B19037036
B19037i37 = B19037037
B19037i38 = B19037038
B19037i39 = B19037039
B19037i40 = B19037040
B19037i41 = B19037041
B19037i42 = B19037042
B19037i43 = B19037043
B19037i44 = B19037044
B19037i45 = B19037045
B19037i46 = B19037046
B19037i47 = B19037047
B19037i48 = B19037048
B19037i49 = B19037049
B19037i50 = B19037050
B19037i51 = B19037051
B19037i52 = B19037052
B19037i53 = B19037053
B19037i54 = B19037054
B19037i55 = B19037055
B19037i56 = B19037056
B19037i57 = B19037057
B19037i58 = B19037058
B19037i59 = B19037059
B19037i60 = B19037060
B19037i61 = B19037061
B19037i62 = B19037062
B19037i63 = B19037063
B19037i64 = B19037064
B19037i65 = B19037065
B19037i66 = B19037066
B19037i67 = B19037067
B19037i68 = B19037068
B19037i69 = B19037069
B19049i1 = B19049001
B19049i2 = B19049002
B19049i3 = B19049003
B19049i4 = B19049004
B19049i5 = B19049005
B19050i1 = B19050001
B19050i2 = B19050002
B19050i3 = B19050003
B19050i4 = B19050004
B19050i5 = B19050005
B19051i1 = B19051001
B19051i2 = B19051002
B19051i3 = B19051003
B19052i1 = B19052001
B19052i2 = B19052002
B19052i3 = B19052003
B19053i1 = B19053001
B19053i2 = B19053002
B19053i3 = B19053003
B19054i1 = B19054001
B19054i2 = B19054002
B19054i3 = B19054003
B19055i1 = B19055001
B19055i2 = B19055002
B19055i3 = B19055003
B19056i1 = B19056001
B19056i2 = B19056002
B19056i3 = B19056003
B19057i1 = B19057001
B19057i2 = B19057002
B19057i3 = B19057003
B19058i1 = B19058001
B19058i2 = B19058002
B19058i3 = B19058003
B19059i1 = B19059001
B19059i2 = B19059002
B19059i3 = B19059003
B19060i1 = B19060001
B19060i2 = B19060002
B19060i3 = B19060003
B19061i1 = B19061001
B19062i1 = B19062001
B19063i1 = B19063001
B19064i1 = B19064001
B19065i1 = B19065001
B19066i1 = B19066001
B19069i1 = B19069001
B19070i1 = B19070001
B19101i1 = B19101001
B19101i2 = B19101002
B19101i3 = B19101003
B19101i4 = B19101004
B19101i5 = B19101005
B19101i6 = B19101006
B19101i7 = B19101007
B19101i8 = B19101008
B19101i9 = B19101009
B19101i10 = B19101010
B19101i11 = B19101011
B19101i12 = B19101012
B19101i13 = B19101013
B19101i14 = B19101014
B19101i15 = B19101015
B19101i16 = B19101016
B19101i17 = B19101017
B19113i1 = B19113001
B19123i1 = B19123001
B19123i2 = B19123002
B19123i3 = B19123003
B19123i4 = B19123004
B19123i5 = B19123005
B19123i6 = B19123006
B19123i7 = B19123007
B19123i8 = B19123008
B19123i9 = B19123009
B19123i10 = B19123010
B19123i11 = B19123011
B19123i12 = B19123012
B19123i13 = B19123013
B19123i14 = B19123014
B19123i15 = B19123015
B19123i16 = B19123016
B19123i17 = B19123017
B19123i18 = B19123018
B19123i19 = B19123019
B19123i20 = B19123020
B19123i21 = B19123021
B19127i1 = B19127001
B19201i1 = B19201001
B19201i2 = B19201002
B19201i3 = B19201003
B19201i4 = B19201004
B19201i5 = B19201005
B19201i6 = B19201006
B19201i7 = B19201007
B19201i8 = B19201008
B19201i9 = B19201009
B19201i10 = B19201010
B19201i11 = B19201011
B19201i12 = B19201012
B19201i13 = B19201013
B19201i14 = B19201014
B19201i15 = B19201015
B19201i16 = B19201016
B19201i17 = B19201017
B19202i1 = B19202001
B19214i1 = B19214001
B19301Ai1 = B19301A001
B19301Bi1 = B19301B001
B19301Ci1 = B19301C001
B19301Fi1 = B19301F001
B19301Gi1 = B19301G001
B19301Hi1 = B19301H001
B19301Ii1 = B19301I001
B19301i1 = B19301001
B19313Ai1 = B19313A001
B19313Bi1 = B19313B001
B19313Ci1 = B19313C001
B19313Fi1 = B19313F001
B19313Gi1 = B19313G001
B19313Hi1 = B19313H001
B19313Ii1 = B19313I001
B19313i1 = B19313001
B20001i1 = B20001001
B20001i2 = B20001002
B20001i3 = B20001003
B20001i4 = B20001004
B20001i5 = B20001005
B20001i6 = B20001006
B20001i7 = B20001007
B20001i8 = B20001008
B20001i9 = B20001009
B20001i10 = B20001010
B20001i11 = B20001011
B20001i12 = B20001012
B20001i13 = B20001013
B20001i14 = B20001014
B20001i15 = B20001015
B20001i16 = B20001016
B20001i17 = B20001017
B20001i18 = B20001018
B20001i19 = B20001019
B20001i20 = B20001020
B20001i21 = B20001021
B20001i22 = B20001022
B20001i23 = B20001023
B20001i24 = B20001024
B20001i25 = B20001025
B20001i26 = B20001026
B20001i27 = B20001027
B20001i28 = B20001028
B20001i29 = B20001029
B20001i30 = B20001030
B20001i31 = B20001031
B20001i32 = B20001032
B20001i33 = B20001033
B20001i34 = B20001034
B20001i35 = B20001035
B20001i36 = B20001036
B20001i37 = B20001037
B20001i38 = B20001038
B20001i39 = B20001039
B20001i40 = B20001040
B20001i41 = B20001041
B20001i42 = B20001042
B20001i43 = B20001043
B20002i1 = B20002001
B20002i2 = B20002002
B20002i3 = B20002003
B20003i1 = B20003001
B20003i2 = B20003002
B20003i3 = B20003003
B20003i4 = B20003004
B20003i5 = B20003005
B20003i6 = B20003006
B20003i7 = B20003007
B20017i1 = B20017001
B20017i2 = B20017002
B20017i3 = B20017003
B20017i4 = B20017004
B20017i5 = B20017005
B20017i6 = B20017006
B20017i7 = B20017007
C17002i1 = C17002001
C17002i2 = C17002002
C17002i3 = C17002003
C17002i4 = C17002004
C17002i5 = C17002005
C17002i6 = C17002006
C17002i7 = C17002007
C17002i8 = C17002008
B21001i1 = B21001001
B21001i2 = B21001002
B21001i3 = B21001003
B21001i4 = B21001004
B21001i5 = B21001005
B21001i6 = B21001006
B21001i7 = B21001007
B21001i8 = B21001008
B21001i9 = B21001009
B21001i10 = B21001010
B21001i11 = B21001011
B21001i12 = B21001012
B21001i13 = B21001013
B21001i14 = B21001014
B21001i15 = B21001015
B21001i16 = B21001016
B21001i17 = B21001017
B21001i18 = B21001018
B21001i19 = B21001019
B21001i20 = B21001020
B21001i21 = B21001021
B21001i22 = B21001022
B21001i23 = B21001023
B21001i24 = B21001024
B21001i25 = B21001025
B21001i26 = B21001026
B21001i27 = B21001027
B21001i28 = B21001028
B21001i29 = B21001029
B21001i30 = B21001030
B21001i31 = B21001031
B21001i32 = B21001032
B21001i33 = B21001033
B21001i34 = B21001034
B21001i35 = B21001035
B21001i36 = B21001036
B21001i37 = B21001037
B21001i38 = B21001038
B21001i39 = B21001039
B21002i1 = B21002001
B21002i2 = B21002002
B21002i3 = B21002003
B21002i4 = B21002004
B21002i5 = B21002005
B21002i6 = B21002006
B21002i7 = B21002007
B21002i8 = B21002008
B21002i9 = B21002009
B21002i10 = B21002010
B21002i11 = B21002011
B21002i12 = B21002012
B21002i13 = B21002013
B21002i14 = B21002014
B21002i15 = B21002015
B21002i16 = B21002016
B22010i1 = B22010001
B22010i2 = B22010002
B22010i3 = B22010003
B22010i4 = B22010004
B22010i5 = B22010005
B22010i6 = B22010006
B22010i7 = B22010007
B23003i1 = B23003001
B23003i2 = B23003002
B23003i3 = B23003003
B23003i4 = B23003004
B23003i5 = B23003005
B23003i6 = B23003006
B23003i7 = B23003007
B23003i8 = B23003008
B23003i9 = B23003009
B23003i10 = B23003010
B23003i11 = B23003011
B23003i12 = B23003012
B23003i13 = B23003013
B23003i14 = B23003014
B23003i15 = B23003015
B23003i16 = B23003016
B23003i17 = B23003017
B23003i18 = B23003018
B23003i19 = B23003019
B23003i20 = B23003020
B23003i21 = B23003021
B23003i22 = B23003022
B23003i23 = B23003023
B23003i24 = B23003024
B23003i25 = B23003025
B23003i26 = B23003026
B23003i27 = B23003027
B23003i28 = B23003028
B23003i29 = B23003029
B23003i30 = B23003030
B23007i1 = B23007001
B23007i2 = B23007002
B23007i3 = B23007003
B23007i4 = B23007004
B23007i5 = B23007005
B23007i6 = B23007006
B23007i7 = B23007007
B23007i8 = B23007008
B23007i9 = B23007009
B23007i10 = B23007010
B23007i11 = B23007011
B23007i12 = B23007012
B23007i13 = B23007013
B23007i14 = B23007014
B23007i15 = B23007015
B23007i16 = B23007016
B23007i17 = B23007017
B23007i18 = B23007018
B23007i19 = B23007019
B23007i20 = B23007020
B23007i21 = B23007021
B23007i22 = B23007022
B23007i23 = B23007023
B23007i24 = B23007024
B23007i25 = B23007025
B23007i26 = B23007026
B23007i27 = B23007027
B23007i28 = B23007028
B23007i29 = B23007029
B23007i30 = B23007030
B23007i31 = B23007031
B23007i32 = B23007032
B23007i33 = B23007033
B23007i34 = B23007034
B23007i35 = B23007035
B23007i36 = B23007036
B23007i37 = B23007037
B23007i38 = B23007038
B23007i39 = B23007039
B23007i40 = B23007040
B23007i41 = B23007041
B23007i42 = B23007042
B23007i43 = B23007043
B23007i44 = B23007044
B23007i45 = B23007045
B23007i46 = B23007046
B23007i47 = B23007047
B23007i48 = B23007048
B23007i49 = B23007049
B23007i50 = B23007050
B23007i51 = B23007051
B23007i52 = B23007052
B23007i53 = B23007053
B23007i54 = B23007054
B23007i55 = B23007055
B23007i56 = B23007056
B23007i57 = B23007057
B23007i58 = B23007058
B23007i59 = B23007059
B23008i1 = B23008001
B23008i2 = B23008002
B23008i3 = B23008003
B23008i4 = B23008004
B23008i5 = B23008005
B23008i6 = B23008006
B23008i7 = B23008007
B23008i8 = B23008008
B23008i9 = B23008009
B23008i10 = B23008010
B23008i11 = B23008011
B23008i12 = B23008012
B23008i13 = B23008013
B23008i14 = B23008014
B23008i15 = B23008015
B23008i16 = B23008016
B23008i17 = B23008017
B23008i18 = B23008018
B23008i19 = B23008019
B23008i20 = B23008020
B23008i21 = B23008021
B23008i22 = B23008022
B23008i23 = B23008023
B23008i24 = B23008024
B23008i25 = B23008025
B23008i26 = B23008026
B23008i27 = B23008027
B23009i1 = B23009001
B23009i2 = B23009002
B23009i3 = B23009003
B23009i4 = B23009004
B23009i5 = B23009005
B23009i6 = B23009006
B23009i7 = B23009007
B23009i8 = B23009008
B23009i9 = B23009009
B23009i10 = B23009010
B23009i11 = B23009011
B23009i12 = B23009012
B23009i13 = B23009013
B23009i14 = B23009014
B23009i15 = B23009015
B23009i16 = B23009016
B23009i17 = B23009017
B23009i18 = B23009018
B23009i19 = B23009019
B23009i20 = B23009020
B23009i21 = B23009021
B23009i22 = B23009022
B23009i23 = B23009023
B23009i24 = B23009024
B23009i25 = B23009025
B23009i26 = B23009026
B23009i27 = B23009027
B23009i28 = B23009028
B23009i29 = B23009029
B23009i30 = B23009030
B23009i31 = B23009031
B23009i32 = B23009032
B23009i33 = B23009033
B23009i34 = B23009034
B23009i35 = B23009035
B23009i36 = B23009036
B23009i37 = B23009037
B23009i38 = B23009038
B23009i39 = B23009039
B23009i40 = B23009040
B23009i41 = B23009041
B23009i42 = B23009042
B23009i43 = B23009043
B23022i1 = B23022001
B23022i2 = B23022002
B23022i3 = B23022003
B23022i4 = B23022004
B23022i5 = B23022005
B23022i6 = B23022006
B23022i7 = B23022007
B23022i8 = B23022008
B23022i9 = B23022009
B23022i10 = B23022010
B23022i11 = B23022011
B23022i12 = B23022012
B23022i13 = B23022013
B23022i14 = B23022014
B23022i15 = B23022015
B23022i16 = B23022016
B23022i17 = B23022017
B23022i18 = B23022018
B23022i19 = B23022019
B23022i20 = B23022020
B23022i21 = B23022021
B23022i22 = B23022022
B23022i23 = B23022023
B23022i24 = B23022024
B23022i25 = B23022025
B23022i26 = B23022026
B23022i27 = B23022027
B23022i28 = B23022028
B23022i29 = B23022029
B23022i30 = B23022030
B23022i31 = B23022031
B23022i32 = B23022032
B23022i33 = B23022033
B23022i34 = B23022034
B23022i35 = B23022035
B23022i36 = B23022036
B23022i37 = B23022037
B23022i38 = B23022038
B23022i39 = B23022039
B23022i40 = B23022040
B23022i41 = B23022041
B23022i42 = B23022042
B23022i43 = B23022043
B23022i44 = B23022044
B23022i45 = B23022045
B23022i46 = B23022046
B23022i47 = B23022047
B23022i48 = B23022048
B23022i49 = B23022049
B23024i1 = B23024001
B23024i2 = B23024002
B23024i3 = B23024003
B23024i4 = B23024004
B23024i5 = B23024005
B23024i6 = B23024006
B23024i7 = B23024007
B23024i8 = B23024008
B23024i9 = B23024009
B23024i10 = B23024010
B23024i11 = B23024011
B23024i12 = B23024012
B23024i13 = B23024013
B23024i14 = B23024014
B23024i15 = B23024015
B23024i16 = B23024016
B23024i17 = B23024017
B23024i18 = B23024018
B23024i19 = B23024019
B23024i20 = B23024020
B23024i21 = B23024021
B23024i22 = B23024022
B23024i23 = B23024023
B23024i24 = B23024024
B23024i25 = B23024025
B23024i26 = B23024026
B23024i27 = B23024027
B23024i28 = B23024028
B23024i29 = B23024029
B23024i30 = B23024030
B23024i31 = B23024031
B23025i1 = B23025001
B23025i2 = B23025002
B23025i3 = B23025003
B23025i4 = B23025004
B23025i5 = B23025005
B23025i6 = B23025006
B23025i7 = B23025007
B23026i1 = B23026001
B23026i2 = B23026002
B23026i3 = B23026003
B23026i4 = B23026004
B23026i5 = B23026005
B23026i6 = B23026006
B23026i7 = B23026007
B23026i8 = B23026008
B23026i9 = B23026009
B23026i10 = B23026010
B23026i11 = B23026011
B23026i12 = B23026012
B23026i13 = B23026013
B23026i14 = B23026014
B23026i15 = B23026015
B23026i16 = B23026016
B23026i17 = B23026017
B23026i18 = B23026018
B23026i19 = B23026019
B23026i20 = B23026020
B23026i21 = B23026021
B23026i22 = B23026022
B23026i23 = B23026023
B23026i24 = B23026024
B23026i25 = B23026025
B23026i26 = B23026026
B23026i27 = B23026027
B23026i28 = B23026028
B23026i29 = B23026029
B23026i30 = B23026030
B23026i31 = B23026031
B23026i32 = B23026032
B23026i33 = B23026033
B23026i34 = B23026034
B23026i35 = B23026035
B23026i36 = B23026036
B23026i37 = B23026037
B23026i38 = B23026038
B23026i39 = B23026039
B23026i40 = B23026040
B23026i41 = B23026041
B23026i42 = B23026042
B23026i43 = B23026043
B23026i44 = B23026044
B23026i45 = B23026045
B23026i46 = B23026046
B23026i47 = B23026047
B23026i48 = B23026048
B23026i49 = B23026049
B23027i1 = B23027001
B23027i2 = B23027002
B23027i3 = B23027003
B23027i4 = B23027004
B23027i5 = B23027005
B23027i6 = B23027006
B23027i7 = B23027007
B23027i8 = B23027008
B23027i9 = B23027009
B23027i10 = B23027010
B23027i11 = B23027011
B23027i12 = B23027012
B23027i13 = B23027013
B23027i14 = B23027014
B23027i15 = B23027015
B23027i16 = B23027016
B23027i17 = B23027017
B23027i18 = B23027018
B23027i19 = B23027019
B23027i20 = B23027020
B23027i21 = B23027021
B23027i22 = B23027022
B23027i23 = B23027023
B23027i24 = B23027024
B23027i25 = B23027025
B23027i26 = B23027026
B23027i27 = B23027027
B23027i28 = B23027028
B23027i29 = B23027029
B23027i30 = B23027030
B23027i31 = B23027031
B23027i32 = B23027032
B23027i33 = B23027033
B23027i34 = B23027034
B23027i35 = B23027035
B23027i36 = B23027036
B24080i1 = B24080001
B24080i2 = B24080002
B24080i3 = B24080003
B24080i4 = B24080004
B24080i5 = B24080005
B24080i6 = B24080006
B24080i7 = B24080007
B24080i8 = B24080008
B24080i9 = B24080009
B24080i10 = B24080010
B24080i11 = B24080011
B24080i12 = B24080012
B24080i13 = B24080013
B24080i14 = B24080014
B24080i15 = B24080015
B24080i16 = B24080016
B24080i17 = B24080017
B24080i18 = B24080018
B24080i19 = B24080019
B24080i20 = B24080020
B24080i21 = B24080021
C21007i1 = C21007001
C21007i2 = C21007002
C21007i3 = C21007003
C21007i4 = C21007004
C21007i5 = C21007005
C21007i6 = C21007006
C21007i7 = C21007007
C21007i8 = C21007008
C21007i9 = C21007009
C21007i10 = C21007010
C21007i11 = C21007011
C21007i12 = C21007012
C21007i13 = C21007013
C21007i14 = C21007014
C21007i15 = C21007015
C21007i16 = C21007016
C21007i17 = C21007017
C21007i18 = C21007018
C21007i19 = C21007019
C21007i20 = C21007020
C21007i21 = C21007021
C21007i22 = C21007022
C21007i23 = C21007023
C21007i24 = C21007024
C21007i25 = C21007025
C21007i26 = C21007026
C21007i27 = C21007027
C21007i28 = C21007028
C21007i29 = C21007029
C21007i30 = C21007030
C21007i31 = C21007031
C24010Ai1 = C24010A001
C24010Ai2 = C24010A002
C24010Ai3 = C24010A003
C24010Ai4 = C24010A004
C24010Ai5 = C24010A005
C24010Ai6 = C24010A006
C24010Ai7 = C24010A007
C24010Ai8 = C24010A008
C24010Ai9 = C24010A009
C24010Ai10 = C24010A010
C24010Ai11 = C24010A011
C24010Ai12 = C24010A012
C24010Ai13 = C24010A013
C24010Bi1 = C24010B001
C24010Bi2 = C24010B002
C24010Bi3 = C24010B003
C24010Bi4 = C24010B004
C24010Bi5 = C24010B005
C24010Bi6 = C24010B006
C24010Bi7 = C24010B007
C24010Bi8 = C24010B008
C24010Bi9 = C24010B009
C24010Bi10 = C24010B010
C24010Bi11 = C24010B011
C24010Bi12 = C24010B012
C24010Bi13 = C24010B013
C24010Ci1 = C24010C001
C24010Ci2 = C24010C002
C24010Ci3 = C24010C003
C24010Ci4 = C24010C004
C24010Ci5 = C24010C005
C24010Ci6 = C24010C006
C24010Ci7 = C24010C007
C24010Ci8 = C24010C008
C24010Ci9 = C24010C009
C24010Ci10 = C24010C010
C24010Ci11 = C24010C011
C24010Ci12 = C24010C012
C24010Ci13 = C24010C013
C24010Di1 = C24010D001
C24010Di2 = C24010D002
C24010Di3 = C24010D003
C24010Di4 = C24010D004
C24010Di5 = C24010D005
C24010Di6 = C24010D006
C24010Di7 = C24010D007
C24010Di8 = C24010D008
C24010Di9 = C24010D009
C24010Di10 = C24010D010
C24010Di11 = C24010D011
C24010Di12 = C24010D012
C24010Di13 = C24010D013
C24010Ei1 = C24010E001
C24010Ei2 = C24010E002
C24010Ei3 = C24010E003
C24010Ei4 = C24010E004
C24010Ei5 = C24010E005
C24010Ei6 = C24010E006
C24010Ei7 = C24010E007
C24010Ei8 = C24010E008
C24010Ei9 = C24010E009
C24010Ei10 = C24010E010
C24010Ei11 = C24010E011
C24010Ei12 = C24010E012
C24010Ei13 = C24010E013
C24010Fi1 = C24010F001
C24010Fi2 = C24010F002
C24010Fi3 = C24010F003
C24010Fi4 = C24010F004
C24010Fi5 = C24010F005
C24010Fi6 = C24010F006
C24010Fi7 = C24010F007
C24010Fi8 = C24010F008
C24010Fi9 = C24010F009
C24010Fi10 = C24010F010
C24010Fi11 = C24010F011
C24010Fi12 = C24010F012
C24010Fi13 = C24010F013
C24010Gi1 = C24010G001
C24010Gi2 = C24010G002
C24010Gi3 = C24010G003
C24010Gi4 = C24010G004
C24010Gi5 = C24010G005
C24010Gi6 = C24010G006
C24010Gi7 = C24010G007
C24010Gi8 = C24010G008
C24010Gi9 = C24010G009
C24010Gi10 = C24010G010
C24010Gi11 = C24010G011
C24010Gi12 = C24010G012
C24010Gi13 = C24010G013
C24010Hi1 = C24010H001
C24010Hi2 = C24010H002
C24010Hi3 = C24010H003
C24010Hi4 = C24010H004
C24010Hi5 = C24010H005
C24010Hi6 = C24010H006
C24010Hi7 = C24010H007
C24010Hi8 = C24010H008
C24010Hi9 = C24010H009
C24010Hi10 = C24010H010
C24010Hi11 = C24010H011
C24010Hi12 = C24010H012
C24010Hi13 = C24010H013
C24010Ii1 = C24010I001
C24010Ii2 = C24010I002
C24010Ii3 = C24010I003
C24010Ii4 = C24010I004
C24010Ii5 = C24010I005
C24010Ii6 = C24010I006
C24010Ii7 = C24010I007
C24010Ii8 = C24010I008
C24010Ii9 = C24010I009
C24010Ii10 = C24010I010
C24010Ii11 = C24010I011
C24010Ii12 = C24010I012
C24010Ii13 = C24010I013
C24010i1 = C24010001
C24010i2 = C24010002
C24010i3 = C24010003
C24010i4 = C24010004
C24010i5 = C24010005
C24010i6 = C24010006
C24010i7 = C24010007
C24010i8 = C24010008
C24010i9 = C24010009
C24010i10 = C24010010
C24010i11 = C24010011
C24010i12 = C24010012
C24010i13 = C24010013
C24010i14 = C24010014
C24010i15 = C24010015
C24010i16 = C24010016
C24010i17 = C24010017
C24010i18 = C24010018
C24010i19 = C24010019
C24010i20 = C24010020
C24010i21 = C24010021
C24010i22 = C24010022
C24010i23 = C24010023
C24010i24 = C24010024
C24010i25 = C24010025
C24010i26 = C24010026
C24010i27 = C24010027
C24010i28 = C24010028
C24010i29 = C24010029
C24010i30 = C24010030
C24010i31 = C24010031
C24010i32 = C24010032
C24010i33 = C24010033
C24010i34 = C24010034
C24010i35 = C24010035
C24010i36 = C24010036
C24010i37 = C24010037
C24010i38 = C24010038
C24010i39 = C24010039
C24010i40 = C24010040
C24010i41 = C24010041
C24010i42 = C24010042
C24010i43 = C24010043
C24010i44 = C24010044
C24010i45 = C24010045
C24010i46 = C24010046
C24010i47 = C24010047
C24010i48 = C24010048
C24010i49 = C24010049
C24010i50 = C24010050
C24010i51 = C24010051
C24010i52 = C24010052
C24010i53 = C24010053
C24010i54 = C24010054
C24010i55 = C24010055
C24010i56 = C24010056
C24010i57 = C24010057
C24010i58 = C24010058
C24010i59 = C24010059
C24010i60 = C24010060
C24010i61 = C24010061
C24010i62 = C24010062
C24010i63 = C24010063
C24010i64 = C24010064
C24010i65 = C24010065
C24010i66 = C24010066
C24010i67 = C24010067
C24010i68 = C24010068
C24010i69 = C24010069
C24010i70 = C24010070
C24010i71 = C24010071
C24010i72 = C24010072
C24010i73 = C24010073
C24020i1 = C24020001
C24020i2 = C24020002
C24020i3 = C24020003
C24020i4 = C24020004
C24020i5 = C24020005
C24020i6 = C24020006
C24020i7 = C24020007
C24020i8 = C24020008
C24020i9 = C24020009
C24020i10 = C24020010
C24020i11 = C24020011
C24020i12 = C24020012
C24020i13 = C24020013
C24020i14 = C24020014
C24020i15 = C24020015
C24020i16 = C24020016
C24020i17 = C24020017
C24020i18 = C24020018
C24020i19 = C24020019
C24020i20 = C24020020
C24020i21 = C24020021
C24020i22 = C24020022
C24020i23 = C24020023
C24020i24 = C24020024
C24020i25 = C24020025
C24020i26 = C24020026
C24020i27 = C24020027
C24020i28 = C24020028
C24020i29 = C24020029
C24020i30 = C24020030
C24020i31 = C24020031
C24020i32 = C24020032
C24020i33 = C24020033
C24020i34 = C24020034
C24020i35 = C24020035
C24020i36 = C24020036
C24020i37 = C24020037
C24020i38 = C24020038
C24020i39 = C24020039
C24020i40 = C24020040
C24020i41 = C24020041
C24020i42 = C24020042
C24020i43 = C24020043
C24020i44 = C24020044
C24020i45 = C24020045
C24020i46 = C24020046
C24020i47 = C24020047
C24020i48 = C24020048
C24020i49 = C24020049
C24020i50 = C24020050
C24020i51 = C24020051
C24020i52 = C24020052
C24020i53 = C24020053
C24020i54 = C24020054
C24020i55 = C24020055
C24020i56 = C24020056
C24020i57 = C24020057
C24020i58 = C24020058
C24020i59 = C24020059
C24020i60 = C24020060
C24020i61 = C24020061
C24020i62 = C24020062
C24020i63 = C24020063
C24020i64 = C24020064
C24020i65 = C24020065
C24020i66 = C24020066
C24020i67 = C24020067
C24020i68 = C24020068
C24020i69 = C24020069
C24020i70 = C24020070
C24020i71 = C24020071
C24020i72 = C24020072
C24020i73 = C24020073
C24030i1 = C24030001
C24030i2 = C24030002
C24030i3 = C24030003
C24030i4 = C24030004
C24030i5 = C24030005
C24030i6 = C24030006
C24030i7 = C24030007
C24030i8 = C24030008
C24030i9 = C24030009
C24030i10 = C24030010
C24030i11 = C24030011
C24030i12 = C24030012
C24030i13 = C24030013
C24030i14 = C24030014
C24030i15 = C24030015
C24030i16 = C24030016
C24030i17 = C24030017
C24030i18 = C24030018
C24030i19 = C24030019
C24030i20 = C24030020
C24030i21 = C24030021
C24030i22 = C24030022
C24030i23 = C24030023
C24030i24 = C24030024
C24030i25 = C24030025
C24030i26 = C24030026
C24030i27 = C24030027
C24030i28 = C24030028
C24030i29 = C24030029
C24030i30 = C24030030
C24030i31 = C24030031
C24030i32 = C24030032
C24030i33 = C24030033
C24030i34 = C24030034
C24030i35 = C24030035
C24030i36 = C24030036
C24030i37 = C24030037
C24030i38 = C24030038
C24030i39 = C24030039
C24030i40 = C24030040
C24030i41 = C24030041
C24030i42 = C24030042
C24030i43 = C24030043
C24030i44 = C24030044
C24030i45 = C24030045
C24030i46 = C24030046
C24030i47 = C24030047
C24030i48 = C24030048
C24030i49 = C24030049
C24030i50 = C24030050
C24030i51 = C24030051
C24030i52 = C24030052
C24030i53 = C24030053
C24030i54 = C24030054
C24030i55 = C24030055
B25001i1 = B25001001
B25002i1 = B25002001
B25002i2 = B25002002
B25002i3 = B25002003
B25003Ai1 = B25003A001
B25003Ai2 = B25003A002
B25003Ai3 = B25003A003
B25003Bi1 = B25003B001
B25003Bi2 = B25003B002
B25003Bi3 = B25003B003
B25003Ci1 = B25003C001
B25003Ci2 = B25003C002
B25003Ci3 = B25003C003
B25003Di1 = B25003D001
B25003Di2 = B25003D002
B25003Di3 = B25003D003
B25003Ei1 = B25003E001
B25003Ei2 = B25003E002
B25003Ei3 = B25003E003
B25003Fi1 = B25003F001
B25003Fi2 = B25003F002
B25003Fi3 = B25003F003
B25003Gi1 = B25003G001
B25003Gi2 = B25003G002
B25003Gi3 = B25003G003
B25003Hi1 = B25003H001
B25003Hi2 = B25003H002
B25003Hi3 = B25003H003
B25003Ii1 = B25003I001
B25003Ii2 = B25003I002
B25003Ii3 = B25003I003
B25003i1 = B25003001
B25003i2 = B25003002
B25003i3 = B25003003
B25004i1 = B25004001
B25004i2 = B25004002
B25004i3 = B25004003
B25004i4 = B25004004
B25004i5 = B25004005
B25004i6 = B25004006
B25004i7 = B25004007
B25004i8 = B25004008
B25006i1 = B25006001
B25006i2 = B25006002
B25006i3 = B25006003
B25006i4 = B25006004
B25006i5 = B25006005
B25006i6 = B25006006
B25006i7 = B25006007
B25006i8 = B25006008
B25006i9 = B25006009
B25006i10 = B25006010
B25007i1 = B25007001
B25007i2 = B25007002
B25007i3 = B25007003
B25007i4 = B25007004
B25007i5 = B25007005
B25007i6 = B25007006
B25007i7 = B25007007
B25007i8 = B25007008
B25007i9 = B25007009
B25007i10 = B25007010
B25007i11 = B25007011
B25007i12 = B25007012
B25007i13 = B25007013
B25007i14 = B25007014
B25007i15 = B25007015
B25007i16 = B25007016
B25007i17 = B25007017
B25007i18 = B25007018
B25007i19 = B25007019
B25007i20 = B25007020
B25007i21 = B25007021
B25008i1 = B25008001
B25008i2 = B25008002
B25008i3 = B25008003
B25009i1 = B25009001
B25009i2 = B25009002
B25009i3 = B25009003
B25009i4 = B25009004
B25009i5 = B25009005
B25009i6 = B25009006
B25009i7 = B25009007
B25009i8 = B25009008
B25009i9 = B25009009
B25009i10 = B25009010
B25009i11 = B25009011
B25009i12 = B25009012
B25009i13 = B25009013
B25009i14 = B25009014
B25009i15 = B25009015
B25009i16 = B25009016
B25009i17 = B25009017
B25010i1 = B25010001
B25010i2 = B25010002
B25010i3 = B25010003
B25014i1 = B25014001
B25014i2 = B25014002
B25014i3 = B25014003
B25014i4 = B25014004
B25014i5 = B25014005
B25014i6 = B25014006
B25014i7 = B25014007
B25014i8 = B25014008
B25014i9 = B25014009
B25014i10 = B25014010
B25014i11 = B25014011
B25014i12 = B25014012
B25014i13 = B25014013
B25015i1 = B25015001
B25015i2 = B25015002
B25015i3 = B25015003
B25015i4 = B25015004
B25015i5 = B25015005
B25015i6 = B25015006
B25015i7 = B25015007
B25015i8 = B25015008
B25015i9 = B25015009
B25015i10 = B25015010
B25015i11 = B25015011
B25015i12 = B25015012
B25015i13 = B25015013
B25015i14 = B25015014
B25015i15 = B25015015
B25015i16 = B25015016
B25015i17 = B25015017
B25015i18 = B25015018
B25015i19 = B25015019
B25015i20 = B25015020
B25015i21 = B25015021
B25015i22 = B25015022
B25015i23 = B25015023
B25015i24 = B25015024
B25015i25 = B25015025
B25015i26 = B25015026
B25015i27 = B25015027
B25016i1 = B25016001
B25016i2 = B25016002
B25016i3 = B25016003
B25016i4 = B25016004
B25016i5 = B25016005
B25016i6 = B25016006
B25016i7 = B25016007
B25016i8 = B25016008
B25016i9 = B25016009
B25016i10 = B25016010
B25016i11 = B25016011
B25016i12 = B25016012
B25016i13 = B25016013
B25016i14 = B25016014
B25016i15 = B25016015
B25016i16 = B25016016
B25016i17 = B25016017
B25016i18 = B25016018
B25016i19 = B25016019
B25017i1 = B25017001
B25017i2 = B25017002
B25017i3 = B25017003
B25017i4 = B25017004
B25017i5 = B25017005
B25017i6 = B25017006
B25017i7 = B25017007
B25017i8 = B25017008
B25017i9 = B25017009
B25017i10 = B25017010
B25018i1 = B25018001
B25019i1 = B25019001
B25020i1 = B25020001
B25020i2 = B25020002
B25020i3 = B25020003
B25020i4 = B25020004
B25020i5 = B25020005
B25020i6 = B25020006
B25020i7 = B25020007
B25020i8 = B25020008
B25020i9 = B25020009
B25020i10 = B25020010
B25020i11 = B25020011
B25020i12 = B25020012
B25020i13 = B25020013
B25020i14 = B25020014
B25020i15 = B25020015
B25020i16 = B25020016
B25020i17 = B25020017
B25020i18 = B25020018
B25020i19 = B25020019
B25020i20 = B25020020
B25020i21 = B25020021
B25021i1 = B25021001
B25021i2 = B25021002
B25021i3 = B25021003
B25022i1 = B25022001
B25022i2 = B25022002
B25022i3 = B25022003
B25024i1 = B25024001
B25024i2 = B25024002
B25024i3 = B25024003
B25024i4 = B25024004
B25024i5 = B25024005
B25024i6 = B25024006
B25024i7 = B25024007
B25024i8 = B25024008
B25024i9 = B25024009
B25024i10 = B25024010
B25024i11 = B25024011
B25032i1 = B25032001
B25032i2 = B25032002
B25032i3 = B25032003
B25032i4 = B25032004
B25032i5 = B25032005
B25032i6 = B25032006
B25032i7 = B25032007
B25032i8 = B25032008
B25032i9 = B25032009
B25032i10 = B25032010
B25032i11 = B25032011
B25032i12 = B25032012
B25032i13 = B25032013
B25032i14 = B25032014
B25032i15 = B25032015
B25032i16 = B25032016
B25032i17 = B25032017
B25032i18 = B25032018
B25032i19 = B25032019
B25032i20 = B25032020
B25032i21 = B25032021
B25032i22 = B25032022
B25032i23 = B25032023
B25033i1 = B25033001
B25033i2 = B25033002
B25033i3 = B25033003
B25033i4 = B25033004
B25033i5 = B25033005
B25033i6 = B25033006
B25033i7 = B25033007
B25033i8 = B25033008
B25033i9 = B25033009
B25033i10 = B25033010
B25033i11 = B25033011
B25033i12 = B25033012
B25033i13 = B25033013
B25034i1 = B25034001
B25034i2 = B25034002
B25034i3 = B25034003
B25034i4 = B25034004
B25034i5 = B25034005
B25034i6 = B25034006
B25034i7 = B25034007
B25034i8 = B25034008
B25034i9 = B25034009
B25034i10 = B25034010
B25034i11 = B25034011
B25035i1 = B25035001
B25036i1 = B25036001
B25036i2 = B25036002
B25036i3 = B25036003
B25036i4 = B25036004
B25036i5 = B25036005
B25036i6 = B25036006
B25036i7 = B25036007
B25036i8 = B25036008
B25036i9 = B25036009
B25036i10 = B25036010
B25036i11 = B25036011
B25036i12 = B25036012
B25036i13 = B25036013
B25036i14 = B25036014
B25036i15 = B25036015
B25036i16 = B25036016
B25036i17 = B25036017
B25036i18 = B25036018
B25036i19 = B25036019
B25036i20 = B25036020
B25036i21 = B25036021
B25036i22 = B25036022
B25036i23 = B25036023
B25037i1 = B25037001
B25037i2 = B25037002
B25037i3 = B25037003
B25038i1 = B25038001
B25038i2 = B25038002
B25038i3 = B25038003
B25038i4 = B25038004
B25038i5 = B25038005
B25038i6 = B25038006
B25038i7 = B25038007
B25038i8 = B25038008
B25038i9 = B25038009
B25038i10 = B25038010
B25038i11 = B25038011
B25038i12 = B25038012
B25038i13 = B25038013
B25038i14 = B25038014
B25038i15 = B25038015
B25039i1 = B25039001
B25039i2 = B25039002
B25039i3 = B25039003
B25040i1 = B25040001
B25040i2 = B25040002
B25040i3 = B25040003
B25040i4 = B25040004
B25040i5 = B25040005
B25040i6 = B25040006
B25040i7 = B25040007
B25040i8 = B25040008
B25040i9 = B25040009
B25040i10 = B25040010
B25041i1 = B25041001
B25041i2 = B25041002
B25041i3 = B25041003
B25041i4 = B25041004
B25041i5 = B25041005
B25041i6 = B25041006
B25041i7 = B25041007
B25042i1 = B25042001
B25042i2 = B25042002
B25042i3 = B25042003
B25042i4 = B25042004
B25042i5 = B25042005
B25042i6 = B25042006
B25042i7 = B25042007
B25042i8 = B25042008
B25042i9 = B25042009
B25042i10 = B25042010
B25042i11 = B25042011
B25042i12 = B25042012
B25042i13 = B25042013
B25042i14 = B25042014
B25042i15 = B25042015
B25043i1 = B25043001
B25043i2 = B25043002
B25043i3 = B25043003
B25043i4 = B25043004
B25043i5 = B25043005
B25043i6 = B25043006
B25043i7 = B25043007
B25043i8 = B25043008
B25043i9 = B25043009
B25043i10 = B25043010
B25043i11 = B25043011
B25043i12 = B25043012
B25043i13 = B25043013
B25043i14 = B25043014
B25043i15 = B25043015
B25043i16 = B25043016
B25043i17 = B25043017
B25043i18 = B25043018
B25043i19 = B25043019
B25044i1 = B25044001
B25044i2 = B25044002
B25044i3 = B25044003
B25044i4 = B25044004
B25044i5 = B25044005
B25044i6 = B25044006
B25044i7 = B25044007
B25044i8 = B25044008
B25044i9 = B25044009
B25044i10 = B25044010
B25044i11 = B25044011
B25044i12 = B25044012
B25044i13 = B25044013
B25044i14 = B25044014
B25044i15 = B25044015
B25045i1 = B25045001
B25045i2 = B25045002
B25045i3 = B25045003
B25045i4 = B25045004
B25045i5 = B25045005
B25045i6 = B25045006
B25045i7 = B25045007
B25045i8 = B25045008
B25045i9 = B25045009
B25045i10 = B25045010
B25045i11 = B25045011
B25045i12 = B25045012
B25045i13 = B25045013
B25045i14 = B25045014
B25045i15 = B25045015
B25045i16 = B25045016
B25045i17 = B25045017
B25045i18 = B25045018
B25045i19 = B25045019
B25046i1 = B25046001
B25046i2 = B25046002
B25046i3 = B25046003
B25047i1 = B25047001
B25047i2 = B25047002
B25047i3 = B25047003
B25049i1 = B25049001
B25049i2 = B25049002
B25049i3 = B25049003
B25049i4 = B25049004
B25049i5 = B25049005
B25049i6 = B25049006
B25049i7 = B25049007
B25050i1 = B25050001
B25050i2 = B25050002
B25050i3 = B25050003
B25050i4 = B25050004
B25050i5 = B25050005
B25050i6 = B25050006
B25050i7 = B25050007
B25050i8 = B25050008
B25050i9 = B25050009
B25050i10 = B25050010
B25050i11 = B25050011
B25050i12 = B25050012
B25050i13 = B25050013
B25050i14 = B25050014
B25050i15 = B25050015
B25050i16 = B25050016
B25050i17 = B25050017
B25050i18 = B25050018
B25050i19 = B25050019
B25051i1 = B25051001
B25051i2 = B25051002
B25051i3 = B25051003
B25053i1 = B25053001
B25053i2 = B25053002
B25053i3 = B25053003
B25053i4 = B25053004
B25053i5 = B25053005
B25053i6 = B25053006
B25053i7 = B25053007
B25054i1 = B25054001
B25054i2 = B25054002
B25054i3 = B25054003
B25054i4 = B25054004
B25054i5 = B25054005
B25054i6 = B25054006
B25054i7 = B25054007
B25055i1 = B25055001
B25055i2 = B25055002
B25055i3 = B25055003
B25055i4 = B25055004
B25055i5 = B25055005
B25055i6 = B25055006
B25055i7 = B25055007
B25055i8 = B25055008
B25055i9 = B25055009
B25055i10 = B25055010
B25055i11 = B25055011
B25055i12 = B25055012
B25055i13 = B25055013
B25056i1 = B25056001
B25056i2 = B25056002
B25056i3 = B25056003
B25056i4 = B25056004
B25056i5 = B25056005
B25056i6 = B25056006
B25056i7 = B25056007
B25056i8 = B25056008
B25056i9 = B25056009
B25056i10 = B25056010
B25056i11 = B25056011
B25056i12 = B25056012
B25056i13 = B25056013
B25056i14 = B25056014
B25056i15 = B25056015
B25056i16 = B25056016
B25056i17 = B25056017
B25056i18 = B25056018
B25056i19 = B25056019
B25056i20 = B25056020
B25056i21 = B25056021
B25056i22 = B25056022
B25056i23 = B25056023
B25056i24 = B25056024
B25056i25 = B25056025
B25056i26 = B25056026
B25056i27 = B25056027
B25057i1 = B25057001
B25058i1 = B25058001
B25059i1 = B25059001
B25060i1 = B25060001
B25061i1 = B25061001
B25061i2 = B25061002
B25061i3 = B25061003
B25061i4 = B25061004
B25061i5 = B25061005
B25061i6 = B25061006
B25061i7 = B25061007
B25061i8 = B25061008
B25061i9 = B25061009
B25061i10 = B25061010
B25061i11 = B25061011
B25061i12 = B25061012
B25061i13 = B25061013
B25061i14 = B25061014
B25061i15 = B25061015
B25061i16 = B25061016
B25061i17 = B25061017
B25061i18 = B25061018
B25061i19 = B25061019
B25061i20 = B25061020
B25061i21 = B25061021
B25061i22 = B25061022
B25061i23 = B25061023
B25061i24 = B25061024
B25061i25 = B25061025
B25062i1 = B25062001
B25063i1 = B25063001
B25063i2 = B25063002
B25063i3 = B25063003
B25063i4 = B25063004
B25063i5 = B25063005
B25063i6 = B25063006
B25063i7 = B25063007
B25063i8 = B25063008
B25063i9 = B25063009
B25063i10 = B25063010
B25063i11 = B25063011
B25063i12 = B25063012
B25063i13 = B25063013
B25063i14 = B25063014
B25063i15 = B25063015
B25063i16 = B25063016
B25063i17 = B25063017
B25063i18 = B25063018
B25063i19 = B25063019
B25063i20 = B25063020
B25063i21 = B25063021
B25063i22 = B25063022
B25063i23 = B25063023
B25063i24 = B25063024
B25063i25 = B25063025
B25063i26 = B25063026
B25063i27 = B25063027
B25064i1 = B25064001
B25065i1 = B25065001
B25066i1 = B25066001
B25066i2 = B25066002
B25066i3 = B25066003
B25066i4 = B25066004
B25066i5 = B25066005
B25066i6 = B25066006
B25066i7 = B25066007
B25066i8 = B25066008
B25067i1 = B25067001
B25067i2 = B25067002
B25067i3 = B25067003
B25068i1 = B25068001
B25068i2 = B25068002
B25068i3 = B25068003
B25068i4 = B25068004
B25068i5 = B25068005
B25068i6 = B25068006
B25068i7 = B25068007
B25068i8 = B25068008
B25068i9 = B25068009
B25068i10 = B25068010
B25068i11 = B25068011
B25068i12 = B25068012
B25068i13 = B25068013
B25068i14 = B25068014
B25068i15 = B25068015
B25068i16 = B25068016
B25068i17 = B25068017
B25068i18 = B25068018
B25068i19 = B25068019
B25068i20 = B25068020
B25068i21 = B25068021
B25068i22 = B25068022
B25068i23 = B25068023
B25068i24 = B25068024
B25068i25 = B25068025
B25068i26 = B25068026
B25068i27 = B25068027
B25068i28 = B25068028
B25068i29 = B25068029
B25068i30 = B25068030
B25068i31 = B25068031
B25068i32 = B25068032
B25068i33 = B25068033
B25068i34 = B25068034
B25068i35 = B25068035
B25068i36 = B25068036
B25068i37 = B25068037
B25069i1 = B25069001
B25069i2 = B25069002
B25069i3 = B25069003
B25070i1 = B25070001
B25070i2 = B25070002
B25070i3 = B25070003
B25070i4 = B25070004
B25070i5 = B25070005
B25070i6 = B25070006
B25070i7 = B25070007
B25070i8 = B25070008
B25070i9 = B25070009
B25070i10 = B25070010
B25070i11 = B25070011
B25071i1 = B25071001
B25072i1 = B25072001
B25072i2 = B25072002
B25072i3 = B25072003
B25072i4 = B25072004
B25072i5 = B25072005
B25072i6 = B25072006
B25072i7 = B25072007
B25072i8 = B25072008
B25072i9 = B25072009
B25072i10 = B25072010
B25072i11 = B25072011
B25072i12 = B25072012
B25072i13 = B25072013
B25072i14 = B25072014
B25072i15 = B25072015
B25072i16 = B25072016
B25072i17 = B25072017
B25072i18 = B25072018
B25072i19 = B25072019
B25072i20 = B25072020
B25072i21 = B25072021
B25072i22 = B25072022
B25072i23 = B25072023
B25072i24 = B25072024
B25072i25 = B25072025
B25072i26 = B25072026
B25072i27 = B25072027
B25072i28 = B25072028
B25072i29 = B25072029
B25074i1 = B25074001
B25074i2 = B25074002
B25074i3 = B25074003
B25074i4 = B25074004
B25074i5 = B25074005
B25074i6 = B25074006
B25074i7 = B25074007
B25074i8 = B25074008
B25074i9 = B25074009
B25074i10 = B25074010
B25074i11 = B25074011
B25074i12 = B25074012
B25074i13 = B25074013
B25074i14 = B25074014
B25074i15 = B25074015
B25074i16 = B25074016
B25074i17 = B25074017
B25074i18 = B25074018
B25074i19 = B25074019
B25074i20 = B25074020
B25074i21 = B25074021
B25074i22 = B25074022
B25074i23 = B25074023
B25074i24 = B25074024
B25074i25 = B25074025
B25074i26 = B25074026
B25074i27 = B25074027
B25074i28 = B25074028
B25074i29 = B25074029
B25074i30 = B25074030
B25074i31 = B25074031
B25074i32 = B25074032
B25074i33 = B25074033
B25074i34 = B25074034
B25074i35 = B25074035
B25074i36 = B25074036
B25074i37 = B25074037
B25074i38 = B25074038
B25074i39 = B25074039
B25074i40 = B25074040
B25074i41 = B25074041
B25074i42 = B25074042
B25074i43 = B25074043
B25074i44 = B25074044
B25074i45 = B25074045
B25074i46 = B25074046
B25074i47 = B25074047
B25074i48 = B25074048
B25074i49 = B25074049
B25074i50 = B25074050
B25074i51 = B25074051
B25074i52 = B25074052
B25074i53 = B25074053
B25074i54 = B25074054
B25074i55 = B25074055
B25074i56 = B25074056
B25074i57 = B25074057
B25074i58 = B25074058
B25074i59 = B25074059
B25074i60 = B25074060
B25074i61 = B25074061
B25074i62 = B25074062
B25074i63 = B25074063
B25074i64 = B25074064
B25075i1 = B25075001
B25075i2 = B25075002
B25075i3 = B25075003
B25075i4 = B25075004
B25075i5 = B25075005
B25075i6 = B25075006
B25075i7 = B25075007
B25075i8 = B25075008
B25075i9 = B25075009
B25075i10 = B25075010
B25075i11 = B25075011
B25075i12 = B25075012
B25075i13 = B25075013
B25075i14 = B25075014
B25075i15 = B25075015
B25075i16 = B25075016
B25075i17 = B25075017
B25075i18 = B25075018
B25075i19 = B25075019
B25075i20 = B25075020
B25075i21 = B25075021
B25075i22 = B25075022
B25075i23 = B25075023
B25075i24 = B25075024
B25075i25 = B25075025
B25075i26 = B25075026
B25075i27 = B25075027
B25076i1 = B25076001
B25077i1 = B25077001
B25078i1 = B25078001
B25079i1 = B25079001
B25079i2 = B25079002
B25079i3 = B25079003
B25079i4 = B25079004
B25079i5 = B25079005
B25080i1 = B25080001
B25080i2 = B25080002
B25080i3 = B25080003
B25080i4 = B25080004
B25080i5 = B25080005
B25080i6 = B25080006
B25080i7 = B25080007
B25080i8 = B25080008
B25081i1 = B25081001
B25081i2 = B25081002
B25081i3 = B25081003
B25081i4 = B25081004
B25081i5 = B25081005
B25081i6 = B25081006
B25081i7 = B25081007
B25081i8 = B25081008
B25082i1 = B25082001
B25082i2 = B25082002
B25082i3 = B25082003
B25083i1 = B25083001
B25085i1 = B25085001
B25085i2 = B25085002
B25085i3 = B25085003
B25085i4 = B25085004
B25085i5 = B25085005
B25085i6 = B25085006
B25085i7 = B25085007
B25085i8 = B25085008
B25085i9 = B25085009
B25085i10 = B25085010
B25085i11 = B25085011
B25085i12 = B25085012
B25085i13 = B25085013
B25085i14 = B25085014
B25085i15 = B25085015
B25085i16 = B25085016
B25085i17 = B25085017
B25085i18 = B25085018
B25085i19 = B25085019
B25085i20 = B25085020
B25085i21 = B25085021
B25085i22 = B25085022
B25085i23 = B25085023
B25085i24 = B25085024
B25085i25 = B25085025
B25085i26 = B25085026
B25085i27 = B25085027
B25087i1 = B25087001
B25087i2 = B25087002
B25087i3 = B25087003
B25087i4 = B25087004
B25087i5 = B25087005
B25087i6 = B25087006
B25087i7 = B25087007
B25087i8 = B25087008
B25087i9 = B25087009
B25087i10 = B25087010
B25087i11 = B25087011
B25087i12 = B25087012
B25087i13 = B25087013
B25087i14 = B25087014
B25087i15 = B25087015
B25087i16 = B25087016
B25087i17 = B25087017
B25087i18 = B25087018
B25087i19 = B25087019
B25087i20 = B25087020
B25087i21 = B25087021
B25087i22 = B25087022
B25087i23 = B25087023
B25087i24 = B25087024
B25087i25 = B25087025
B25087i26 = B25087026
B25087i27 = B25087027
B25087i28 = B25087028
B25087i29 = B25087029
B25087i30 = B25087030
B25087i31 = B25087031
B25087i32 = B25087032
B25087i33 = B25087033
B25087i34 = B25087034
B25087i35 = B25087035
B25087i36 = B25087036
B25087i37 = B25087037
B25087i38 = B25087038
B25087i39 = B25087039
B25088i1 = B25088001
B25088i2 = B25088002
B25088i3 = B25088003
B25089i1 = B25089001
B25089i2 = B25089002
B25089i3 = B25089003
B25091i1 = B25091001
B25091i2 = B25091002
B25091i3 = B25091003
B25091i4 = B25091004
B25091i5 = B25091005
B25091i6 = B25091006
B25091i7 = B25091007
B25091i8 = B25091008
B25091i9 = B25091009
B25091i10 = B25091010
B25091i11 = B25091011
B25091i12 = B25091012
B25091i13 = B25091013
B25091i14 = B25091014
B25091i15 = B25091015
B25091i16 = B25091016
B25091i17 = B25091017
B25091i18 = B25091018
B25091i19 = B25091019
B25091i20 = B25091020
B25091i21 = B25091021
B25091i22 = B25091022
B25091i23 = B25091023
B25092i1 = B25092001
B25092i2 = B25092002
B25092i3 = B25092003
B25093i1 = B25093001
B25093i2 = B25093002
B25093i3 = B25093003
B25093i4 = B25093004
B25093i5 = B25093005
B25093i6 = B25093006
B25093i7 = B25093007
B25093i8 = B25093008
B25093i9 = B25093009
B25093i10 = B25093010
B25093i11 = B25093011
B25093i12 = B25093012
B25093i13 = B25093013
B25093i14 = B25093014
B25093i15 = B25093015
B25093i16 = B25093016
B25093i17 = B25093017
B25093i18 = B25093018
B25093i19 = B25093019
B25093i20 = B25093020
B25093i21 = B25093021
B25093i22 = B25093022
B25093i23 = B25093023
B25093i24 = B25093024
B25093i25 = B25093025
B25093i26 = B25093026
B25093i27 = B25093027
B25093i28 = B25093028
B25093i29 = B25093029
B27010i1 = B27010001
B27010i2 = B27010002
B27010i3 = B27010003
B27010i4 = B27010004
B27010i5 = B27010005
B27010i6 = B27010006
B27010i7 = B27010007
B27010i8 = B27010008
B27010i9 = B27010009
B27010i10 = B27010010
B27010i11 = B27010011
B27010i12 = B27010012
B27010i13 = B27010013
B27010i14 = B27010014
B27010i15 = B27010015
B27010i16 = B27010016
B27010i17 = B27010017
B27010i18 = B27010018
B27010i19 = B27010019
B27010i20 = B27010020
B27010i21 = B27010021
B27010i22 = B27010022
B27010i23 = B27010023
B27010i24 = B27010024
B27010i25 = B27010025
B27010i26 = B27010026
B27010i27 = B27010027
B27010i28 = B27010028
B27010i29 = B27010029
B27010i30 = B27010030
B27010i31 = B27010031
B27010i32 = B27010032
B27010i33 = B27010033
B27010i34 = B27010034
B27010i35 = B27010035
B27010i36 = B27010036
B27010i37 = B27010037
B27010i38 = B27010038
B27010i39 = B27010039
B27010i40 = B27010040
B27010i41 = B27010041
B27010i42 = B27010042
B27010i43 = B27010043
B27010i44 = B27010044
B27010i45 = B27010045
B27010i46 = B27010046
B27010i47 = B27010047
B27010i48 = B27010048
B27010i49 = B27010049
B27010i50 = B27010050
B27010i51 = B27010051
B27010i52 = B27010052
B27010i53 = B27010053
B27010i54 = B27010054
B27010i55 = B27010055
B27010i56 = B27010056
B27010i57 = B27010057
B27010i58 = B27010058
B27010i59 = B27010059
B27010i60 = B27010060
B27010i61 = B27010061
B27010i62 = B27010062
B27010i63 = B27010063
B27010i64 = B27010064
B27010i65 = B27010065
B27010i66 = B27010066
B28001i1 = B28001001
B28001i2 = B28001002
B28001i3 = B28001003
B28001i4 = B28001004
B28001i5 = B28001005
B28001i6 = B28001006
B28001i7 = B28001007
B28001i8 = B28001008
B28001i9 = B28001009
B28001i10 = B28001010
B28001i11 = B28001011
B28002i1 = B28002001
B28002i2 = B28002002
B28002i3 = B28002003
B28002i4 = B28002004
B28002i5 = B28002005
B28002i6 = B28002006
B28002i7 = B28002007
B28002i8 = B28002008
B28002i9 = B28002009
B28002i10 = B28002010
B28002i11 = B28002011
B28002i12 = B28002012
B28002i13 = B28002013
B28003i1 = B28003001
B28003i2 = B28003002
B28003i3 = B28003003
B28003i4 = B28003004
B28003i5 = B28003005
B28003i6 = B28003006
B28004i1 = B28004001
B28004i2 = B28004002
B28004i3 = B28004003
B28004i4 = B28004004
B28004i5 = B28004005
B28004i6 = B28004006
B28004i7 = B28004007
B28004i8 = B28004008
B28004i9 = B28004009
B28004i10 = B28004010
B28004i11 = B28004011
B28004i12 = B28004012
B28004i13 = B28004013
B28004i14 = B28004014
B28004i15 = B28004015
B28004i16 = B28004016
B28004i17 = B28004017
B28004i18 = B28004018
B28004i19 = B28004019
B28004i20 = B28004020
B28004i21 = B28004021
B28004i22 = B28004022
B28004i23 = B28004023
B28004i24 = B28004024
B28004i25 = B28004025
B28005i1 = B28005001
B28005i2 = B28005002
B28005i3 = B28005003
B28005i4 = B28005004
B28005i5 = B28005005
B28005i6 = B28005006
B28005i7 = B28005007
B28005i8 = B28005008
B28005i9 = B28005009
B28005i10 = B28005010
B28005i11 = B28005011
B28005i12 = B28005012
B28005i13 = B28005013
B28005i14 = B28005014
B28005i15 = B28005015
B28005i16 = B28005016
B28005i17 = B28005017
B28005i18 = B28005018
B28005i19 = B28005019
B28006i1 = B28006001
B28006i2 = B28006002
B28006i3 = B28006003
B28006i4 = B28006004
B28006i5 = B28006005
B28006i6 = B28006006
B28006i7 = B28006007
B28006i8 = B28006008
B28006i9 = B28006009
B28006i10 = B28006010
B28006i11 = B28006011
B28006i12 = B28006012
B28006i13 = B28006013
B28006i14 = B28006014
B28006i15 = B28006015
B28006i16 = B28006016
B28006i17 = B28006017
B28006i18 = B28006018
B28006i19 = B28006019
B28007i1 = B28007001
B28007i2 = B28007002
B28007i3 = B28007003
B28007i4 = B28007004
B28007i5 = B28007005
B28007i6 = B28007006
B28007i7 = B28007007
B28007i8 = B28007008
B28007i9 = B28007009
B28007i10 = B28007010
B28007i11 = B28007011
B28007i12 = B28007012
B28007i13 = B28007013
B28007i14 = B28007014
B28007i15 = B28007015
B28007i16 = B28007016
B28007i17 = B28007017
B28007i18 = B28007018
B28007i19 = B28007019
B28007i20 = B28007020
B28008i1 = B28008001
B28008i2 = B28008002
B28008i3 = B28008003
B28008i4 = B28008004
B28008i5 = B28008005
B28008i6 = B28008006
B28008i7 = B28008007
B28008i8 = B28008008
B28008i9 = B28008009
B28008i10 = B28008010
B28009Ai1 = B28009A001
B28009Ai2 = B28009A002
B28009Ai3 = B28009A003
B28009Ai4 = B28009A004
B28009Ai5 = B28009A005
B28009Ai6 = B28009A006
B28009Bi1 = B28009B001
B28009Bi2 = B28009B002
B28009Bi3 = B28009B003
B28009Bi4 = B28009B004
B28009Bi5 = B28009B005
B28009Bi6 = B28009B006
B28009Ci1 = B28009C001
B28009Ci2 = B28009C002
B28009Ci3 = B28009C003
B28009Ci4 = B28009C004
B28009Ci5 = B28009C005
B28009Ci6 = B28009C006
B28009Di1 = B28009D001
B28009Di2 = B28009D002
B28009Di3 = B28009D003
B28009Di4 = B28009D004
B28009Di5 = B28009D005
B28009Di6 = B28009D006
B28009Ei1 = B28009E001
B28009Ei2 = B28009E002
B28009Ei3 = B28009E003
B28009Ei4 = B28009E004
B28009Ei5 = B28009E005
B28009Ei6 = B28009E006
B28009Fi1 = B28009F001
B28009Fi2 = B28009F002
B28009Fi3 = B28009F003
B28009Fi4 = B28009F004
B28009Fi5 = B28009F005
B28009Fi6 = B28009F006
B28009Gi1 = B28009G001
B28009Gi2 = B28009G002
B28009Gi3 = B28009G003
B28009Gi4 = B28009G004
B28009Gi5 = B28009G005
B28009Gi6 = B28009G006
B28009Hi1 = B28009H001
B28009Hi2 = B28009H002
B28009Hi3 = B28009H003
B28009Hi4 = B28009H004
B28009Hi5 = B28009H005
B28009Hi6 = B28009H006
B28009Ii1 = B28009I001
B28009Ii2 = B28009I002
B28009Ii3 = B28009I003
B28009Ii4 = B28009I004
B28009Ii5 = B28009I005
B28009Ii6 = B28009I006
B28010i1 = B28010001
B28010i2 = B28010002
B28010i3 = B28010003
B28010i4 = B28010004
B28010i5 = B28010005
B28010i6 = B28010006
B28010i7 = B28010007
B28011i1 = B28011001
B28011i2 = B28011002
B28011i3 = B28011003
B28011i4 = B28011004
B28011i5 = B28011005
B28011i6 = B28011006
B28011i7 = B28011007
B28011i8 = B28011008
B19083m1 = B19083001s
B07003m1 = B07003001s
B07003m4 = B07003004s
B01001m1 = B01001001s
B01001m2 = B01001002s
B01001m3 = B01001003s
B01001m4 = B01001004s
B01001m5 = B01001005s
B01001m6 = B01001006s
B01001m7 = B01001007s
B01001m8 = B01001008s
B01001m9 = B01001009s
B01001m10 = B01001010s
B01001m11 = B01001011s
B01001m12 = B01001012s
B01001m13 = B01001013s
B01001m14 = B01001014s
B01001m15 = B01001015s
B01001m16 = B01001016s
B01001m17 = B01001017s
B01001m18 = B01001018s
B01001m19 = B01001019s
B01001m20 = B01001020s
B01001m21 = B01001021s
B01001m22 = B01001022s
B01001m23 = B01001023s
B01001m24 = B01001024s
B01001m25 = B01001025s
B01001m26 = B01001026s
B01001m27 = B01001027s
B01001m28 = B01001028s
B01001m29 = B01001029s
B01001m30 = B01001030s
B01001m31 = B01001031s
B01001m32 = B01001032s
B01001m33 = B01001033s
B01001m34 = B01001034s
B01001m35 = B01001035s
B01001m36 = B01001036s
B01001m37 = B01001037s
B01001m38 = B01001038s
B01001m39 = B01001039s
B01001m40 = B01001040s
B01001m41 = B01001041s
B01001m42 = B01001042s
B01001m43 = B01001043s
B01001m44 = B01001044s
B01001m45 = B01001045s
B01001m46 = B01001046s
B01001m47 = B01001047s
B01001m48 = B01001048s
B01001m49 = B01001049s
B01002Am1 = B01002A001s
B01002Am2 = B01002A002s
B01002Am3 = B01002A003s
B01002Bm1 = B01002B001s
B01002Bm2 = B01002B002s
B01002Bm3 = B01002B003s
B01002Cm1 = B01002C001s
B01002Cm2 = B01002C002s
B01002Cm3 = B01002C003s
B01002Dm1 = B01002D001s
B01002Dm2 = B01002D002s
B01002Dm3 = B01002D003s
B01002Fm1 = B01002F001s
B01002Fm2 = B01002F002s
B01002Fm3 = B01002F003s
B01002Gm1 = B01002G001s
B01002Gm2 = B01002G002s
B01002Gm3 = B01002G003s
B01002Hm1 = B01002H001s
B01002Hm2 = B01002H002s
B01002Hm3 = B01002H003s
B01002Im1 = B01002I001s
B01002Im2 = B01002I002s
B01002Im3 = B01002I003s
B01002m1 = B01002001s
B01002m2 = B01002002s
B01002m3 = B01002003s
B01003m1 = B01003001s
B02001m1 = B02001001s
B02001m2 = B02001002s
B02001m3 = B02001003s
B02001m4 = B02001004s
B02001m5 = B02001005s
B02001m6 = B02001006s
B02001m7 = B02001007s
B02001m8 = B02001008s
B02001m9 = B02001009s
B02001m10 = B02001010s
B02008m1 = B02008001s
B02009m1 = B02009001s
B02010m1 = B02010001s
B02011m1 = B02011001s
B02012m1 = B02012001s
B02013m1 = B02013001s
B03002m1 = B03002001s
B03002m2 = B03002002s
B03002m3 = B03002003s
B03002m4 = B03002004s
B03002m5 = B03002005s
B03002m6 = B03002006s
B03002m7 = B03002007s
B03002m8 = B03002008s
B03002m9 = B03002009s
B03002m10 = B03002010s
B03002m11 = B03002011s
B03002m12 = B03002012s
B03002m13 = B03002013s
B03002m14 = B03002014s
B03002m15 = B03002015s
B03002m16 = B03002016s
B03002m17 = B03002017s
B03002m18 = B03002018s
B03002m19 = B03002019s
B03002m20 = B03002020s
B03002m21 = B03002021s
B03003m1 = B03003001s
B03003m2 = B03003002s
B03003m3 = B03003003s
B07201m1 = B07201001s
B07201m2 = B07201002s
B07201m3 = B07201003s
B07201m4 = B07201004s
B07201m5 = B07201005s
B07201m6 = B07201006s
B07201m7 = B07201007s
B07201m8 = B07201008s
B07201m9 = B07201009s
B07201m10 = B07201010s
B07201m11 = B07201011s
B07201m12 = B07201012s
B07201m13 = B07201013s
B07201m14 = B07201014s
B07202m1 = B07202001s
B07202m2 = B07202002s
B07202m3 = B07202003s
B07202m4 = B07202004s
B07202m5 = B07202005s
B07202m6 = B07202006s
B07202m7 = B07202007s
B07202m8 = B07202008s
B07202m9 = B07202009s
B07202m10 = B07202010s
B07202m11 = B07202011s
B07202m12 = B07202012s
B07202m13 = B07202013s
B07202m14 = B07202014s
B07203m1 = B07203001s
B07203m2 = B07203002s
B07203m3 = B07203003s
B07203m4 = B07203004s
B07203m5 = B07203005s
B07203m6 = B07203006s
B07203m7 = B07203007s
B07203m8 = B07203008s
B07203m9 = B07203009s
B07203m10 = B07203010s
B07203m11 = B07203011s
C02003m1 = C02003001s
C02003m2 = C02003002s
C02003m3 = C02003003s
C02003m4 = C02003004s
C02003m5 = C02003005s
C02003m6 = C02003006s
C02003m7 = C02003007s
C02003m8 = C02003008s
C02003m9 = C02003009s
C02003m10 = C02003010s
C02003m11 = C02003011s
C02003m12 = C02003012s
C02003m13 = C02003013s
C02003m14 = C02003014s
C02003m15 = C02003015s
C02003m16 = C02003016s
C02003m17 = C02003017s
C02003m18 = C02003018s
C02003m19 = C02003019s
B08007m1 = B08007001s
B08007m2 = B08007002s
B08007m3 = B08007003s
B08007m4 = B08007004s
B08007m5 = B08007005s
B08007m6 = B08007006s
B08007m7 = B08007007s
B08007m8 = B08007008s
B08007m9 = B08007009s
B08007m10 = B08007010s
B08007m11 = B08007011s
B08007m12 = B08007012s
B08007m13 = B08007013s
B08007m14 = B08007014s
B08007m15 = B08007015s
B08008m1 = B08008001s
B08008m2 = B08008002s
B08008m3 = B08008003s
B08008m4 = B08008004s
B08008m5 = B08008005s
B08008m6 = B08008006s
B08008m7 = B08008007s
B08008m8 = B08008008s
B08008m9 = B08008009s
B08008m10 = B08008010s
B08008m11 = B08008011s
B08008m12 = B08008012s
B08008m13 = B08008013s
B08008m14 = B08008014s
B08008m15 = B08008015s
B08009m1 = B08009001s
B08009m2 = B08009002s
B08009m3 = B08009003s
B08009m4 = B08009004s
B08009m5 = B08009005s
B08009m6 = B08009006s
B08009m7 = B08009007s
B08009m8 = B08009008s
B08009m9 = B08009009s
B08009m10 = B08009010s
B08009m11 = B08009011s
B08009m12 = B08009012s
B08009m13 = B08009013s
B08009m14 = B08009014s
B08009m15 = B08009015s
B08016m1 = B08016001s
B08016m2 = B08016002s
B08016m3 = B08016003s
B08016m4 = B08016004s
B08016m5 = B08016005s
B08016m6 = B08016006s
B08016m7 = B08016007s
B08016m8 = B08016008s
B08016m9 = B08016009s
B08016m10 = B08016010s
B08016m11 = B08016011s
B08016m12 = B08016012s
B08016m13 = B08016013s
B08016m14 = B08016014s
B08016m15 = B08016015s
B08016m16 = B08016016s
B08016m17 = B08016017s
B08016m18 = B08016018s
B08016m19 = B08016019s
B08016m20 = B08016020s
B08016m21 = B08016021s
B08016m22 = B08016022s
B08016m23 = B08016023s
B08017m1 = B08017001s
B08017m2 = B08017002s
B08017m3 = B08017003s
B08017m4 = B08017004s
B08017m5 = B08017005s
B08017m6 = B08017006s
B08017m7 = B08017007s
B08017m8 = B08017008s
B08017m9 = B08017009s
B08017m10 = B08017010s
B08017m11 = B08017011s
B08017m12 = B08017012s
B08017m13 = B08017013s
B08017m14 = B08017014s
B08017m15 = B08017015s
B08017m16 = B08017016s
B08017m17 = B08017017s
B08017m18 = B08017018s
B08017m19 = B08017019s
B08017m20 = B08017020s
B08017m21 = B08017021s
B08017m22 = B08017022s
B08017m23 = B08017023s
B08018m1 = B08018001s
B08018m2 = B08018002s
B08018m3 = B08018003s
B08018m4 = B08018004s
B08018m5 = B08018005s
B08018m6 = B08018006s
B08018m7 = B08018007s
B08018m8 = B08018008s
B08134m1 = B08134001s
B08134m2 = B08134002s
B08134m3 = B08134003s
B08134m4 = B08134004s
B08134m5 = B08134005s
B08134m6 = B08134006s
B08134m7 = B08134007s
B08134m8 = B08134008s
B08134m9 = B08134009s
B08134m10 = B08134010s
B08134m11 = B08134011s
B08134m12 = B08134012s
B08134m13 = B08134013s
B08134m14 = B08134014s
B08134m15 = B08134015s
B08134m16 = B08134016s
B08134m17 = B08134017s
B08134m18 = B08134018s
B08134m19 = B08134019s
B08134m20 = B08134020s
B08134m21 = B08134021s
B08134m22 = B08134022s
B08134m23 = B08134023s
B08134m24 = B08134024s
B08134m25 = B08134025s
B08134m26 = B08134026s
B08134m27 = B08134027s
B08134m28 = B08134028s
B08134m29 = B08134029s
B08134m30 = B08134030s
B08134m31 = B08134031s
B08134m32 = B08134032s
B08134m33 = B08134033s
B08134m34 = B08134034s
B08134m35 = B08134035s
B08134m36 = B08134036s
B08134m37 = B08134037s
B08134m38 = B08134038s
B08134m39 = B08134039s
B08134m40 = B08134040s
B08134m41 = B08134041s
B08134m42 = B08134042s
B08134m43 = B08134043s
B08134m44 = B08134044s
B08134m45 = B08134045s
B08134m46 = B08134046s
B08134m47 = B08134047s
B08134m48 = B08134048s
B08134m49 = B08134049s
B08134m50 = B08134050s
B08134m51 = B08134051s
B08134m52 = B08134052s
B08134m53 = B08134053s
B08134m54 = B08134054s
B08134m55 = B08134055s
B08134m56 = B08134056s
B08134m57 = B08134057s
B08134m58 = B08134058s
B08134m59 = B08134059s
B08134m60 = B08134060s
B08134m61 = B08134061s
B08134m62 = B08134062s
B08134m63 = B08134063s
B08134m64 = B08134064s
B08134m65 = B08134065s
B08134m66 = B08134066s
B08134m67 = B08134067s
B08134m68 = B08134068s
B08134m69 = B08134069s
B08134m70 = B08134070s
B08134m71 = B08134071s
B08134m72 = B08134072s
B08134m73 = B08134073s
B08134m74 = B08134074s
B08134m75 = B08134075s
B08134m76 = B08134076s
B08134m77 = B08134077s
B08134m78 = B08134078s
B08134m79 = B08134079s
B08134m80 = B08134080s
B08134m81 = B08134081s
B08134m82 = B08134082s
B08134m83 = B08134083s
B08134m84 = B08134084s
B08134m85 = B08134085s
B08134m86 = B08134086s
B08134m87 = B08134087s
B08134m88 = B08134088s
B08134m89 = B08134089s
B08134m90 = B08134090s
B08134m91 = B08134091s
B08134m92 = B08134092s
B08134m93 = B08134093s
B08134m94 = B08134094s
B08134m95 = B08134095s
B08134m96 = B08134096s
B08134m97 = B08134097s
B08134m98 = B08134098s
B08134m99 = B08134099s
B08134m100 = B081340100s
B08134m101 = B081340101s
B08134m102 = B081340102s
B08134m103 = B081340103s
B08134m104 = B081340104s
B08134m105 = B081340105s
B08134m106 = B081340106s
B08134m107 = B081340107s
B08134m108 = B081340108s
B08134m109 = B081340109s
B08134m110 = B081340110s
B08134m111 = B081340111s
B08134m112 = B081340112s
B08134m113 = B081340113s
B08134m114 = B081340114s
B08134m115 = B081340115s
B08134m116 = B081340116s
B08134m117 = B081340117s
B08134m118 = B081340118s
B08134m119 = B081340119s
B08134m120 = B081340120s
B08135m1 = B08135001s
B08135m2 = B08135002s
B08135m3 = B08135003s
B08135m4 = B08135004s
B08135m5 = B08135005s
B08135m6 = B08135006s
B08135m7 = B08135007s
B08135m8 = B08135008s
B08135m9 = B08135009s
B08135m10 = B08135010s
B08136m1 = B08136001s
B08136m2 = B08136002s
B08136m3 = B08136003s
B08136m4 = B08136004s
B08136m5 = B08136005s
B08136m6 = B08136006s
B08136m7 = B08136007s
B08136m8 = B08136008s
B08136m9 = B08136009s
B08136m10 = B08136010s
B08136m11 = B08136011s
B08136m12 = B08136012s
B08301m1 = B08301001s
B08301m2 = B08301002s
B08301m3 = B08301003s
B08301m4 = B08301004s
B08301m5 = B08301005s
B08301m6 = B08301006s
B08301m7 = B08301007s
B08301m8 = B08301008s
B08301m9 = B08301009s
B08301m10 = B08301010s
B08301m11 = B08301011s
B08301m12 = B08301012s
B08301m13 = B08301013s
B08301m14 = B08301014s
B08301m15 = B08301015s
B08301m16 = B08301016s
B08301m17 = B08301017s
B08301m18 = B08301018s
B08301m19 = B08301019s
B08301m20 = B08301020s
B08301m21 = B08301021s
B08302m1 = B08302001s
B08302m2 = B08302002s
B08302m3 = B08302003s
B08302m4 = B08302004s
B08302m5 = B08302005s
B08302m6 = B08302006s
B08302m7 = B08302007s
B08302m8 = B08302008s
B08302m9 = B08302009s
B08302m10 = B08302010s
B08302m11 = B08302011s
B08302m12 = B08302012s
B08302m13 = B08302013s
B08302m14 = B08302014s
B08302m15 = B08302015s
B08303m1 = B08303001s
B08303m2 = B08303002s
B08303m3 = B08303003s
B08303m4 = B08303004s
B08303m5 = B08303005s
B08303m6 = B08303006s
B08303m7 = B08303007s
B08303m8 = B08303008s
B08303m9 = B08303009s
B08303m10 = B08303010s
B08303m11 = B08303011s
B08303m12 = B08303012s
B08303m13 = B08303013s
B09002m1 = B09002001s
B09002m2 = B09002002s
B09002m3 = B09002003s
B09002m4 = B09002004s
B09002m5 = B09002005s
B09002m6 = B09002006s
B09002m7 = B09002007s
B09002m8 = B09002008s
B09002m9 = B09002009s
B09002m10 = B09002010s
B09002m11 = B09002011s
B09002m12 = B09002012s
B09002m13 = B09002013s
B09002m14 = B09002014s
B09002m15 = B09002015s
B09002m16 = B09002016s
B09002m17 = B09002017s
B09002m18 = B09002018s
B09002m19 = B09002019s
B09002m20 = B09002020s
B09018m1 = B09018001s
B09018m2 = B09018002s
B09018m3 = B09018003s
B09018m4 = B09018004s
B09018m5 = B09018005s
B09018m6 = B09018006s
B09018m7 = B09018007s
B09018m8 = B09018008s
B09019m1 = B09019001s
B09019m2 = B09019002s
B09019m3 = B09019003s
B09019m4 = B09019004s
B09019m5 = B09019005s
B09019m6 = B09019006s
B09019m7 = B09019007s
B09019m8 = B09019008s
B09019m9 = B09019009s
B09019m10 = B09019010s
B09019m11 = B09019011s
B09019m12 = B09019012s
B09019m13 = B09019013s
B09019m14 = B09019014s
B09019m15 = B09019015s
B09019m16 = B09019016s
B09019m17 = B09019017s
B09019m18 = B09019018s
B09019m19 = B09019019s
B09019m20 = B09019020s
B09019m21 = B09019021s
B09019m22 = B09019022s
B09019m23 = B09019023s
B09019m24 = B09019024s
B09019m25 = B09019025s
B09019m26 = B09019026s
B09020m1 = B09020001s
B09020m2 = B09020002s
B09020m3 = B09020003s
B09020m4 = B09020004s
B09020m5 = B09020005s
B09020m6 = B09020006s
B09020m7 = B09020007s
B09020m8 = B09020008s
B09020m9 = B09020009s
B09020m10 = B09020010s
B09020m11 = B09020011s
B09020m12 = B09020012s
B09020m13 = B09020013s
B09020m14 = B09020014s
B09020m15 = B09020015s
B09020m16 = B09020016s
B09020m17 = B09020017s
B09020m18 = B09020018s
B09020m19 = B09020019s
B09020m20 = B09020020s
B09020m21 = B09020021s
B09021m1 = B09021001s
B09021m2 = B09021002s
B09021m3 = B09021003s
B09021m4 = B09021004s
B09021m5 = B09021005s
B09021m6 = B09021006s
B09021m7 = B09021007s
B09021m8 = B09021008s
B09021m9 = B09021009s
B09021m10 = B09021010s
B09021m11 = B09021011s
B09021m12 = B09021012s
B09021m13 = B09021013s
B09021m14 = B09021014s
B09021m15 = B09021015s
B09021m16 = B09021016s
B09021m17 = B09021017s
B09021m18 = B09021018s
B09021m19 = B09021019s
B09021m20 = B09021020s
B09021m21 = B09021021s
B09021m22 = B09021022s
B09021m23 = B09021023s
B09021m24 = B09021024s
B09021m25 = B09021025s
B09021m26 = B09021026s
B09021m27 = B09021027s
B09021m28 = B09021028s
B11001Am1 = B11001A001s
B11001Am2 = B11001A002s
B11001Am3 = B11001A003s
B11001Am4 = B11001A004s
B11001Am5 = B11001A005s
B11001Am6 = B11001A006s
B11001Am7 = B11001A007s
B11001Am8 = B11001A008s
B11001Am9 = B11001A009s
B11001Bm1 = B11001B001s
B11001Bm2 = B11001B002s
B11001Bm3 = B11001B003s
B11001Bm4 = B11001B004s
B11001Bm5 = B11001B005s
B11001Bm6 = B11001B006s
B11001Bm7 = B11001B007s
B11001Bm8 = B11001B008s
B11001Bm9 = B11001B009s
B11001Cm1 = B11001C001s
B11001Cm2 = B11001C002s
B11001Cm3 = B11001C003s
B11001Cm4 = B11001C004s
B11001Cm5 = B11001C005s
B11001Cm6 = B11001C006s
B11001Cm7 = B11001C007s
B11001Cm8 = B11001C008s
B11001Cm9 = B11001C009s
B11001Dm1 = B11001D001s
B11001Dm2 = B11001D002s
B11001Dm3 = B11001D003s
B11001Dm4 = B11001D004s
B11001Dm5 = B11001D005s
B11001Dm6 = B11001D006s
B11001Dm7 = B11001D007s
B11001Dm8 = B11001D008s
B11001Dm9 = B11001D009s
B11001Em1 = B11001E001s
B11001Em2 = B11001E002s
B11001Em3 = B11001E003s
B11001Em4 = B11001E004s
B11001Em5 = B11001E005s
B11001Em6 = B11001E006s
B11001Em7 = B11001E007s
B11001Em8 = B11001E008s
B11001Em9 = B11001E009s
B11001Fm1 = B11001F001s
B11001Fm2 = B11001F002s
B11001Fm3 = B11001F003s
B11001Fm4 = B11001F004s
B11001Fm5 = B11001F005s
B11001Fm6 = B11001F006s
B11001Fm7 = B11001F007s
B11001Fm8 = B11001F008s
B11001Fm9 = B11001F009s
B11001Gm1 = B11001G001s
B11001Gm2 = B11001G002s
B11001Gm3 = B11001G003s
B11001Gm4 = B11001G004s
B11001Gm5 = B11001G005s
B11001Gm6 = B11001G006s
B11001Gm7 = B11001G007s
B11001Gm8 = B11001G008s
B11001Gm9 = B11001G009s
B11001Hm1 = B11001H001s
B11001Hm2 = B11001H002s
B11001Hm3 = B11001H003s
B11001Hm4 = B11001H004s
B11001Hm5 = B11001H005s
B11001Hm6 = B11001H006s
B11001Hm7 = B11001H007s
B11001Hm8 = B11001H008s
B11001Hm9 = B11001H009s
B11001Im1 = B11001I001s
B11001Im2 = B11001I002s
B11001Im3 = B11001I003s
B11001Im4 = B11001I004s
B11001Im5 = B11001I005s
B11001Im6 = B11001I006s
B11001Im7 = B11001I007s
B11001Im8 = B11001I008s
B11001Im9 = B11001I009s
B11001m1 = B11001001s
B11001m2 = B11001002s
B11001m3 = B11001003s
B11001m4 = B11001004s
B11001m5 = B11001005s
B11001m6 = B11001006s
B11001m7 = B11001007s
B11001m8 = B11001008s
B11001m9 = B11001009s
B11002Am1 = B11002A001s
B11002Am2 = B11002A002s
B11002Am3 = B11002A003s
B11002Am4 = B11002A004s
B11002Am5 = B11002A005s
B11002Am6 = B11002A006s
B11002Am7 = B11002A007s
B11002Am8 = B11002A008s
B11002Am9 = B11002A009s
B11002Am10 = B11002A010s
B11002Am11 = B11002A011s
B11002Am12 = B11002A012s
B11002Bm1 = B11002B001s
B11002Bm2 = B11002B002s
B11002Bm3 = B11002B003s
B11002Bm4 = B11002B004s
B11002Bm5 = B11002B005s
B11002Bm6 = B11002B006s
B11002Bm7 = B11002B007s
B11002Bm8 = B11002B008s
B11002Bm9 = B11002B009s
B11002Bm10 = B11002B010s
B11002Bm11 = B11002B011s
B11002Bm12 = B11002B012s
B11002Cm1 = B11002C001s
B11002Cm2 = B11002C002s
B11002Cm3 = B11002C003s
B11002Cm4 = B11002C004s
B11002Cm5 = B11002C005s
B11002Cm6 = B11002C006s
B11002Cm7 = B11002C007s
B11002Cm8 = B11002C008s
B11002Cm9 = B11002C009s
B11002Cm10 = B11002C010s
B11002Cm11 = B11002C011s
B11002Cm12 = B11002C012s
B11002Dm1 = B11002D001s
B11002Dm2 = B11002D002s
B11002Dm3 = B11002D003s
B11002Dm4 = B11002D004s
B11002Dm5 = B11002D005s
B11002Dm6 = B11002D006s
B11002Dm7 = B11002D007s
B11002Dm8 = B11002D008s
B11002Dm9 = B11002D009s
B11002Dm10 = B11002D010s
B11002Dm11 = B11002D011s
B11002Dm12 = B11002D012s
B11002Em1 = B11002E001s
B11002Em2 = B11002E002s
B11002Em3 = B11002E003s
B11002Em4 = B11002E004s
B11002Em5 = B11002E005s
B11002Em6 = B11002E006s
B11002Em7 = B11002E007s
B11002Em8 = B11002E008s
B11002Em9 = B11002E009s
B11002Em10 = B11002E010s
B11002Em11 = B11002E011s
B11002Em12 = B11002E012s
B11002Fm1 = B11002F001s
B11002Fm2 = B11002F002s
B11002Fm3 = B11002F003s
B11002Fm4 = B11002F004s
B11002Fm5 = B11002F005s
B11002Fm6 = B11002F006s
B11002Fm7 = B11002F007s
B11002Fm8 = B11002F008s
B11002Fm9 = B11002F009s
B11002Fm10 = B11002F010s
B11002Fm11 = B11002F011s
B11002Fm12 = B11002F012s
B11002Gm1 = B11002G001s
B11002Gm2 = B11002G002s
B11002Gm3 = B11002G003s
B11002Gm4 = B11002G004s
B11002Gm5 = B11002G005s
B11002Gm6 = B11002G006s
B11002Gm7 = B11002G007s
B11002Gm8 = B11002G008s
B11002Gm9 = B11002G009s
B11002Gm10 = B11002G010s
B11002Gm11 = B11002G011s
B11002Gm12 = B11002G012s
B11002Hm1 = B11002H001s
B11002Hm2 = B11002H002s
B11002Hm3 = B11002H003s
B11002Hm4 = B11002H004s
B11002Hm5 = B11002H005s
B11002Hm6 = B11002H006s
B11002Hm7 = B11002H007s
B11002Hm8 = B11002H008s
B11002Hm9 = B11002H009s
B11002Hm10 = B11002H010s
B11002Hm11 = B11002H011s
B11002Hm12 = B11002H012s
B11002Im1 = B11002I001s
B11002Im2 = B11002I002s
B11002Im3 = B11002I003s
B11002Im4 = B11002I004s
B11002Im5 = B11002I005s
B11002Im6 = B11002I006s
B11002Im7 = B11002I007s
B11002Im8 = B11002I008s
B11002Im9 = B11002I009s
B11002Im10 = B11002I010s
B11002Im11 = B11002I011s
B11002Im12 = B11002I012s
B11002m1 = B11002001s
B11002m2 = B11002002s
B11002m3 = B11002003s
B11002m4 = B11002004s
B11002m5 = B11002005s
B11002m6 = B11002006s
B11002m7 = B11002007s
B11002m8 = B11002008s
B11002m9 = B11002009s
B11002m10 = B11002010s
B11002m11 = B11002011s
B11002m12 = B11002012s
B11003m1 = B11003001s
B11003m2 = B11003002s
B11003m3 = B11003003s
B11003m4 = B11003004s
B11003m5 = B11003005s
B11003m6 = B11003006s
B11003m7 = B11003007s
B11003m8 = B11003008s
B11003m9 = B11003009s
B11003m10 = B11003010s
B11003m11 = B11003011s
B11003m12 = B11003012s
B11003m13 = B11003013s
B11003m14 = B11003014s
B11003m15 = B11003015s
B11003m16 = B11003016s
B11003m17 = B11003017s
B11003m18 = B11003018s
B11003m19 = B11003019s
B11003m20 = B11003020s
B11004m1 = B11004001s
B11004m2 = B11004002s
B11004m3 = B11004003s
B11004m4 = B11004004s
B11004m5 = B11004005s
B11004m6 = B11004006s
B11004m7 = B11004007s
B11004m8 = B11004008s
B11004m9 = B11004009s
B11004m10 = B11004010s
B11004m11 = B11004011s
B11004m12 = B11004012s
B11004m13 = B11004013s
B11004m14 = B11004014s
B11004m15 = B11004015s
B11004m16 = B11004016s
B11004m17 = B11004017s
B11004m18 = B11004018s
B11004m19 = B11004019s
B11004m20 = B11004020s
B11005m1 = B11005001s
B11005m2 = B11005002s
B11005m3 = B11005003s
B11005m4 = B11005004s
B11005m5 = B11005005s
B11005m6 = B11005006s
B11005m7 = B11005007s
B11005m8 = B11005008s
B11005m9 = B11005009s
B11005m10 = B11005010s
B11005m11 = B11005011s
B11005m12 = B11005012s
B11005m13 = B11005013s
B11005m14 = B11005014s
B11005m15 = B11005015s
B11005m16 = B11005016s
B11005m17 = B11005017s
B11005m18 = B11005018s
B11005m19 = B11005019s
B11006m1 = B11006001s
B11006m2 = B11006002s
B11006m3 = B11006003s
B11006m4 = B11006004s
B11006m5 = B11006005s
B11006m6 = B11006006s
B11006m7 = B11006007s
B11006m8 = B11006008s
B11006m9 = B11006009s
B11006m10 = B11006010s
B11006m11 = B11006011s
B11006m12 = B11006012s
B11006m13 = B11006013s
B11006m14 = B11006014s
B11006m15 = B11006015s
B11007m1 = B11007001s
B11007m2 = B11007002s
B11007m3 = B11007003s
B11007m4 = B11007004s
B11007m5 = B11007005s
B11007m6 = B11007006s
B11007m7 = B11007007s
B11007m8 = B11007008s
B11007m9 = B11007009s
B11007m10 = B11007010s
B11007m11 = B11007011s
B11008m1 = B11008001s
B11008m2 = B11008002s
B11008m3 = B11008003s
B11008m4 = B11008004s
B11008m5 = B11008005s
B11008m6 = B11008006s
B11008m7 = B11008007s
B11008m8 = B11008008s
B11012m1 = B11012001s
B11012m2 = B11012002s
B11012m3 = B11012003s
B11012m4 = B11012004s
B11012m5 = B11012005s
B11012m6 = B11012006s
B11012m7 = B11012007s
B11012m8 = B11012008s
B11012m9 = B11012009s
B11012m10 = B11012010s
B11012m11 = B11012011s
B11012m12 = B11012012s
B11012m13 = B11012013s
B11012m14 = B11012014s
B11012m15 = B11012015s
B11012m16 = B11012016s
B11012m17 = B11012017s
B11015m1 = B11015001s
B11015m2 = B11015002s
B11015m3 = B11015003s
B11016m1 = B11016001s
B11016m2 = B11016002s
B11016m3 = B11016003s
B11016m4 = B11016004s
B11016m5 = B11016005s
B11016m6 = B11016006s
B11016m7 = B11016007s
B11016m8 = B11016008s
B11016m9 = B11016009s
B11016m10 = B11016010s
B11016m11 = B11016011s
B11016m12 = B11016012s
B11016m13 = B11016013s
B11016m14 = B11016014s
B11016m15 = B11016015s
B11016m16 = B11016016s
B12001m1 = B12001001s
B12001m2 = B12001002s
B12001m3 = B12001003s
B12001m4 = B12001004s
B12001m5 = B12001005s
B12001m6 = B12001006s
B12001m7 = B12001007s
B12001m8 = B12001008s
B12001m9 = B12001009s
B12001m10 = B12001010s
B12001m11 = B12001011s
B12001m12 = B12001012s
B12001m13 = B12001013s
B12001m14 = B12001014s
B12001m15 = B12001015s
B12001m16 = B12001016s
B12001m17 = B12001017s
B12001m18 = B12001018s
B12001m19 = B12001019s
B14002m1 = B14002001s
B14002m2 = B14002002s
B14002m3 = B14002003s
B14002m4 = B14002004s
B14002m5 = B14002005s
B14002m6 = B14002006s
B14002m7 = B14002007s
B14002m8 = B14002008s
B14002m9 = B14002009s
B14002m10 = B14002010s
B14002m11 = B14002011s
B14002m12 = B14002012s
B14002m13 = B14002013s
B14002m14 = B14002014s
B14002m15 = B14002015s
B14002m16 = B14002016s
B14002m17 = B14002017s
B14002m18 = B14002018s
B14002m19 = B14002019s
B14002m20 = B14002020s
B14002m21 = B14002021s
B14002m22 = B14002022s
B14002m23 = B14002023s
B14002m24 = B14002024s
B14002m25 = B14002025s
B14002m26 = B14002026s
B14002m27 = B14002027s
B14002m28 = B14002028s
B14002m29 = B14002029s
B14002m30 = B14002030s
B14002m31 = B14002031s
B14002m32 = B14002032s
B14002m33 = B14002033s
B14002m34 = B14002034s
B14002m35 = B14002035s
B14002m36 = B14002036s
B14002m37 = B14002037s
B14002m38 = B14002038s
B14002m39 = B14002039s
B14002m40 = B14002040s
B14002m41 = B14002041s
B14002m42 = B14002042s
B14002m43 = B14002043s
B14002m44 = B14002044s
B14002m45 = B14002045s
B14002m46 = B14002046s
B14002m47 = B14002047s
B14002m48 = B14002048s
B14002m49 = B14002049s
B14005m1 = B14005001s
B14005m2 = B14005002s
B14005m3 = B14005003s
B14005m4 = B14005004s
B14005m5 = B14005005s
B14005m6 = B14005006s
B14005m7 = B14005007s
B14005m8 = B14005008s
B14005m9 = B14005009s
B14005m10 = B14005010s
B14005m11 = B14005011s
B14005m12 = B14005012s
B14005m13 = B14005013s
B14005m14 = B14005014s
B14005m15 = B14005015s
B14005m16 = B14005016s
B14005m17 = B14005017s
B14005m18 = B14005018s
B14005m19 = B14005019s
B14005m20 = B14005020s
B14005m21 = B14005021s
B14005m22 = B14005022s
B14005m23 = B14005023s
B14005m24 = B14005024s
B14005m25 = B14005025s
B14005m26 = B14005026s
B14005m27 = B14005027s
B14005m28 = B14005028s
B14005m29 = B14005029s
B14007Am1 = B14007A001s
B14007Am2 = B14007A002s
B14007Am3 = B14007A003s
B14007Am4 = B14007A004s
B14007Am5 = B14007A005s
B14007Am6 = B14007A006s
B14007Am7 = B14007A007s
B14007Am8 = B14007A008s
B14007Am9 = B14007A009s
B14007Am10 = B14007A010s
B14007Am11 = B14007A011s
B14007Am12 = B14007A012s
B14007Am13 = B14007A013s
B14007Am14 = B14007A014s
B14007Am15 = B14007A015s
B14007Am16 = B14007A016s
B14007Am17 = B14007A017s
B14007Am18 = B14007A018s
B14007Am19 = B14007A019s
B14007Bm1 = B14007B001s
B14007Bm2 = B14007B002s
B14007Bm3 = B14007B003s
B14007Bm4 = B14007B004s
B14007Bm5 = B14007B005s
B14007Bm6 = B14007B006s
B14007Bm7 = B14007B007s
B14007Bm8 = B14007B008s
B14007Bm9 = B14007B009s
B14007Bm10 = B14007B010s
B14007Bm11 = B14007B011s
B14007Bm12 = B14007B012s
B14007Bm13 = B14007B013s
B14007Bm14 = B14007B014s
B14007Bm15 = B14007B015s
B14007Bm16 = B14007B016s
B14007Bm17 = B14007B017s
B14007Bm18 = B14007B018s
B14007Bm19 = B14007B019s
B14007Cm1 = B14007C001s
B14007Cm2 = B14007C002s
B14007Cm3 = B14007C003s
B14007Cm4 = B14007C004s
B14007Cm5 = B14007C005s
B14007Cm6 = B14007C006s
B14007Cm7 = B14007C007s
B14007Cm8 = B14007C008s
B14007Cm9 = B14007C009s
B14007Cm10 = B14007C010s
B14007Cm11 = B14007C011s
B14007Cm12 = B14007C012s
B14007Cm13 = B14007C013s
B14007Cm14 = B14007C014s
B14007Cm15 = B14007C015s
B14007Cm16 = B14007C016s
B14007Cm17 = B14007C017s
B14007Cm18 = B14007C018s
B14007Cm19 = B14007C019s
B14007Dm1 = B14007D001s
B14007Dm2 = B14007D002s
B14007Dm3 = B14007D003s
B14007Dm4 = B14007D004s
B14007Dm5 = B14007D005s
B14007Dm6 = B14007D006s
B14007Dm7 = B14007D007s
B14007Dm8 = B14007D008s
B14007Dm9 = B14007D009s
B14007Dm10 = B14007D010s
B14007Dm11 = B14007D011s
B14007Dm12 = B14007D012s
B14007Dm13 = B14007D013s
B14007Dm14 = B14007D014s
B14007Dm15 = B14007D015s
B14007Dm16 = B14007D016s
B14007Dm17 = B14007D017s
B14007Dm18 = B14007D018s
B14007Dm19 = B14007D019s
B14007Em1 = B14007E001s
B14007Em2 = B14007E002s
B14007Em3 = B14007E003s
B14007Em4 = B14007E004s
B14007Em5 = B14007E005s
B14007Em6 = B14007E006s
B14007Em7 = B14007E007s
B14007Em8 = B14007E008s
B14007Em9 = B14007E009s
B14007Em10 = B14007E010s
B14007Em11 = B14007E011s
B14007Em12 = B14007E012s
B14007Em13 = B14007E013s
B14007Em14 = B14007E014s
B14007Em15 = B14007E015s
B14007Em16 = B14007E016s
B14007Em17 = B14007E017s
B14007Em18 = B14007E018s
B14007Em19 = B14007E019s
B14007Fm1 = B14007F001s
B14007Fm2 = B14007F002s
B14007Fm3 = B14007F003s
B14007Fm4 = B14007F004s
B14007Fm5 = B14007F005s
B14007Fm6 = B14007F006s
B14007Fm7 = B14007F007s
B14007Fm8 = B14007F008s
B14007Fm9 = B14007F009s
B14007Fm10 = B14007F010s
B14007Fm11 = B14007F011s
B14007Fm12 = B14007F012s
B14007Fm13 = B14007F013s
B14007Fm14 = B14007F014s
B14007Fm15 = B14007F015s
B14007Fm16 = B14007F016s
B14007Fm17 = B14007F017s
B14007Fm18 = B14007F018s
B14007Fm19 = B14007F019s
B14007Gm1 = B14007G001s
B14007Gm2 = B14007G002s
B14007Gm3 = B14007G003s
B14007Gm4 = B14007G004s
B14007Gm5 = B14007G005s
B14007Gm6 = B14007G006s
B14007Gm7 = B14007G007s
B14007Gm8 = B14007G008s
B14007Gm9 = B14007G009s
B14007Gm10 = B14007G010s
B14007Gm11 = B14007G011s
B14007Gm12 = B14007G012s
B14007Gm13 = B14007G013s
B14007Gm14 = B14007G014s
B14007Gm15 = B14007G015s
B14007Gm16 = B14007G016s
B14007Gm17 = B14007G017s
B14007Gm18 = B14007G018s
B14007Gm19 = B14007G019s
B14007Hm1 = B14007H001s
B14007Hm2 = B14007H002s
B14007Hm3 = B14007H003s
B14007Hm4 = B14007H004s
B14007Hm5 = B14007H005s
B14007Hm6 = B14007H006s
B14007Hm7 = B14007H007s
B14007Hm8 = B14007H008s
B14007Hm9 = B14007H009s
B14007Hm10 = B14007H010s
B14007Hm11 = B14007H011s
B14007Hm12 = B14007H012s
B14007Hm13 = B14007H013s
B14007Hm14 = B14007H014s
B14007Hm15 = B14007H015s
B14007Hm16 = B14007H016s
B14007Hm17 = B14007H017s
B14007Hm18 = B14007H018s
B14007Hm19 = B14007H019s
B14007Im1 = B14007I001s
B14007Im2 = B14007I002s
B14007Im3 = B14007I003s
B14007Im4 = B14007I004s
B14007Im5 = B14007I005s
B14007Im6 = B14007I006s
B14007Im7 = B14007I007s
B14007Im8 = B14007I008s
B14007Im9 = B14007I009s
B14007Im10 = B14007I010s
B14007Im11 = B14007I011s
B14007Im12 = B14007I012s
B14007Im13 = B14007I013s
B14007Im14 = B14007I014s
B14007Im15 = B14007I015s
B14007Im16 = B14007I016s
B14007Im17 = B14007I017s
B14007Im18 = B14007I018s
B14007Im19 = B14007I019s
B14007m1 = B14007001s
B14007m2 = B14007002s
B14007m3 = B14007003s
B14007m4 = B14007004s
B14007m5 = B14007005s
B14007m6 = B14007006s
B14007m7 = B14007007s
B14007m8 = B14007008s
B14007m9 = B14007009s
B14007m10 = B14007010s
B14007m11 = B14007011s
B14007m12 = B14007012s
B14007m13 = B14007013s
B14007m14 = B14007014s
B14007m15 = B14007015s
B14007m16 = B14007016s
B14007m17 = B14007017s
B14007m18 = B14007018s
B14007m19 = B14007019s
B15002m1 = B15002001s
B15002m2 = B15002002s
B15002m3 = B15002003s
B15002m4 = B15002004s
B15002m5 = B15002005s
B15002m6 = B15002006s
B15002m7 = B15002007s
B15002m8 = B15002008s
B15002m9 = B15002009s
B15002m10 = B15002010s
B15002m11 = B15002011s
B15002m12 = B15002012s
B15002m13 = B15002013s
B15002m14 = B15002014s
B15002m15 = B15002015s
B15002m16 = B15002016s
B15002m17 = B15002017s
B15002m18 = B15002018s
B15002m19 = B15002019s
B15002m20 = B15002020s
B15002m21 = B15002021s
B15002m22 = B15002022s
B15002m23 = B15002023s
B15002m24 = B15002024s
B15002m25 = B15002025s
B15002m26 = B15002026s
B15002m27 = B15002027s
B15002m28 = B15002028s
B15002m29 = B15002029s
B15002m30 = B15002030s
B15002m31 = B15002031s
B15002m32 = B15002032s
B15002m33 = B15002033s
B15002m34 = B15002034s
B15002m35 = B15002035s
B15003m1 = B15003001s
B15003m2 = B15003002s
B15003m3 = B15003003s
B15003m4 = B15003004s
B15003m5 = B15003005s
B15003m6 = B15003006s
B15003m7 = B15003007s
B15003m8 = B15003008s
B15003m9 = B15003009s
B15003m10 = B15003010s
B15003m11 = B15003011s
B15003m12 = B15003012s
B15003m13 = B15003013s
B15003m14 = B15003014s
B15003m15 = B15003015s
B15003m16 = B15003016s
B15003m17 = B15003017s
B15003m18 = B15003018s
B15003m19 = B15003019s
B15003m20 = B15003020s
B15003m21 = B15003021s
B15003m22 = B15003022s
B15003m23 = B15003023s
B15003m24 = B15003024s
B15003m25 = B15003025s
B15011m1 = B15011001s
B15011m2 = B15011002s
B15011m3 = B15011003s
B15011m4 = B15011004s
B15011m5 = B15011005s
B15011m6 = B15011006s
B15011m7 = B15011007s
B15011m8 = B15011008s
B15011m9 = B15011009s
B15011m10 = B15011010s
B15011m11 = B15011011s
B15011m12 = B15011012s
B15011m13 = B15011013s
B15011m14 = B15011014s
B15011m15 = B15011015s
B15011m16 = B15011016s
B15011m17 = B15011017s
B15011m18 = B15011018s
B15011m19 = B15011019s
B15011m20 = B15011020s
B15011m21 = B15011021s
B15011m22 = B15011022s
B15011m23 = B15011023s
B15011m24 = B15011024s
B15011m25 = B15011025s
B15011m26 = B15011026s
B15011m27 = B15011027s
B15011m28 = B15011028s
B15011m29 = B15011029s
B15011m30 = B15011030s
B15011m31 = B15011031s
B15011m32 = B15011032s
B15011m33 = B15011033s
B15011m34 = B15011034s
B15011m35 = B15011035s
B15011m36 = B15011036s
B15011m37 = B15011037s
B15011m38 = B15011038s
B15011m39 = B15011039s
B15012m1 = B15012001s
B15012m2 = B15012002s
B15012m3 = B15012003s
B15012m4 = B15012004s
B15012m5 = B15012005s
B15012m6 = B15012006s
B15012m7 = B15012007s
B15012m8 = B15012008s
B15012m9 = B15012009s
B15012m10 = B15012010s
B15012m11 = B15012011s
B15012m12 = B15012012s
B15012m13 = B15012013s
B15012m14 = B15012014s
B15012m15 = B15012015s
B15012m16 = B15012016s
B16004m1 = B16004001s
B16004m2 = B16004002s
B16004m3 = B16004003s
B16004m4 = B16004004s
B16004m5 = B16004005s
B16004m6 = B16004006s
B16004m7 = B16004007s
B16004m8 = B16004008s
B16004m9 = B16004009s
B16004m10 = B16004010s
B16004m11 = B16004011s
B16004m12 = B16004012s
B16004m13 = B16004013s
B16004m14 = B16004014s
B16004m15 = B16004015s
B16004m16 = B16004016s
B16004m17 = B16004017s
B16004m18 = B16004018s
B16004m19 = B16004019s
B16004m20 = B16004020s
B16004m21 = B16004021s
B16004m22 = B16004022s
B16004m23 = B16004023s
B16004m24 = B16004024s
B16004m25 = B16004025s
B16004m26 = B16004026s
B16004m27 = B16004027s
B16004m28 = B16004028s
B16004m29 = B16004029s
B16004m30 = B16004030s
B16004m31 = B16004031s
B16004m32 = B16004032s
B16004m33 = B16004033s
B16004m34 = B16004034s
B16004m35 = B16004035s
B16004m36 = B16004036s
B16004m37 = B16004037s
B16004m38 = B16004038s
B16004m39 = B16004039s
B16004m40 = B16004040s
B16004m41 = B16004041s
B16004m42 = B16004042s
B16004m43 = B16004043s
B16004m44 = B16004044s
B16004m45 = B16004045s
B16004m46 = B16004046s
B16004m47 = B16004047s
B16004m48 = B16004048s
B16004m49 = B16004049s
B16004m50 = B16004050s
B16004m51 = B16004051s
B16004m52 = B16004052s
B16004m53 = B16004053s
B16004m54 = B16004054s
B16004m55 = B16004055s
B16004m56 = B16004056s
B16004m57 = B16004057s
B16004m58 = B16004058s
B16004m59 = B16004059s
B16004m60 = B16004060s
B16004m61 = B16004061s
B16004m62 = B16004062s
B16004m63 = B16004063s
B16004m64 = B16004064s
B16004m65 = B16004065s
B16004m66 = B16004066s
B16004m67 = B16004067s
C15010Am1 = C15010A001s
C15010Am2 = C15010A002s
C15010Am3 = C15010A003s
C15010Am4 = C15010A004s
C15010Am5 = C15010A005s
C15010Am6 = C15010A006s
C15010Bm1 = C15010B001s
C15010Bm2 = C15010B002s
C15010Bm3 = C15010B003s
C15010Bm4 = C15010B004s
C15010Bm5 = C15010B005s
C15010Bm6 = C15010B006s
C15010Cm1 = C15010C001s
C15010Cm2 = C15010C002s
C15010Cm3 = C15010C003s
C15010Cm4 = C15010C004s
C15010Cm5 = C15010C005s
C15010Cm6 = C15010C006s
C15010Dm1 = C15010D001s
C15010Dm2 = C15010D002s
C15010Dm3 = C15010D003s
C15010Dm4 = C15010D004s
C15010Dm5 = C15010D005s
C15010Dm6 = C15010D006s
C15010Em1 = C15010E001s
C15010Em2 = C15010E002s
C15010Em3 = C15010E003s
C15010Em4 = C15010E004s
C15010Em5 = C15010E005s
C15010Em6 = C15010E006s
C15010Fm1 = C15010F001s
C15010Fm2 = C15010F002s
C15010Fm3 = C15010F003s
C15010Fm4 = C15010F004s
C15010Fm5 = C15010F005s
C15010Fm6 = C15010F006s
C15010Gm1 = C15010G001s
C15010Gm2 = C15010G002s
C15010Gm3 = C15010G003s
C15010Gm4 = C15010G004s
C15010Gm5 = C15010G005s
C15010Gm6 = C15010G006s
C15010Hm1 = C15010H001s
C15010Hm2 = C15010H002s
C15010Hm3 = C15010H003s
C15010Hm4 = C15010H004s
C15010Hm5 = C15010H005s
C15010Hm6 = C15010H006s
C15010Im1 = C15010I001s
C15010Im2 = C15010I002s
C15010Im3 = C15010I003s
C15010Im4 = C15010I004s
C15010Im5 = C15010I005s
C15010Im6 = C15010I006s
C15010m1 = C15010001s
C15010m2 = C15010002s
C15010m3 = C15010003s
C15010m4 = C15010004s
C15010m5 = C15010005s
C15010m6 = C15010006s
C16002m1 = C16002001s
C16002m2 = C16002002s
C16002m3 = C16002003s
C16002m4 = C16002004s
C16002m5 = C16002005s
C16002m6 = C16002006s
C16002m7 = C16002007s
C16002m8 = C16002008s
C16002m9 = C16002009s
C16002m10 = C16002010s
C16002m11 = C16002011s
C16002m12 = C16002012s
C16002m13 = C16002013s
C16002m14 = C16002014s
B17010m1 = B17010001s
B17010m2 = B17010002s
B17010m3 = B17010003s
B17010m4 = B17010004s
B17010m5 = B17010005s
B17010m6 = B17010006s
B17010m7 = B17010007s
B17010m8 = B17010008s
B17010m9 = B17010009s
B17010m10 = B17010010s
B17010m11 = B17010011s
B17010m12 = B17010012s
B17010m13 = B17010013s
B17010m14 = B17010014s
B17010m15 = B17010015s
B17010m16 = B17010016s
B17010m17 = B17010017s
B17010m18 = B17010018s
B17010m19 = B17010019s
B17010m20 = B17010020s
B17010m21 = B17010021s
B17010m22 = B17010022s
B17010m23 = B17010023s
B17010m24 = B17010024s
B17010m25 = B17010025s
B17010m26 = B17010026s
B17010m27 = B17010027s
B17010m28 = B17010028s
B17010m29 = B17010029s
B17010m30 = B17010030s
B17010m31 = B17010031s
B17010m32 = B17010032s
B17010m33 = B17010033s
B17010m34 = B17010034s
B17010m35 = B17010035s
B17010m36 = B17010036s
B17010m37 = B17010037s
B17010m38 = B17010038s
B17010m39 = B17010039s
B17010m40 = B17010040s
B17010m41 = B17010041s
B17017m1 = B17017001s
B17017m2 = B17017002s
B17017m3 = B17017003s
B17017m4 = B17017004s
B17017m5 = B17017005s
B17017m6 = B17017006s
B17017m7 = B17017007s
B17017m8 = B17017008s
B17017m9 = B17017009s
B17017m10 = B17017010s
B17017m11 = B17017011s
B17017m12 = B17017012s
B17017m13 = B17017013s
B17017m14 = B17017014s
B17017m15 = B17017015s
B17017m16 = B17017016s
B17017m17 = B17017017s
B17017m18 = B17017018s
B17017m19 = B17017019s
B17017m20 = B17017020s
B17017m21 = B17017021s
B17017m22 = B17017022s
B17017m23 = B17017023s
B17017m24 = B17017024s
B17017m25 = B17017025s
B17017m26 = B17017026s
B17017m27 = B17017027s
B17017m28 = B17017028s
B17017m29 = B17017029s
B17017m30 = B17017030s
B17017m31 = B17017031s
B17017m32 = B17017032s
B17017m33 = B17017033s
B17017m34 = B17017034s
B17017m35 = B17017035s
B17017m36 = B17017036s
B17017m37 = B17017037s
B17017m38 = B17017038s
B17017m39 = B17017039s
B17017m40 = B17017040s
B17017m41 = B17017041s
B17017m42 = B17017042s
B17017m43 = B17017043s
B17017m44 = B17017044s
B17017m45 = B17017045s
B17017m46 = B17017046s
B17017m47 = B17017047s
B17017m48 = B17017048s
B17017m49 = B17017049s
B17017m50 = B17017050s
B17017m51 = B17017051s
B17017m52 = B17017052s
B17017m53 = B17017053s
B17017m54 = B17017054s
B17017m55 = B17017055s
B17017m56 = B17017056s
B17017m57 = B17017057s
B17017m58 = B17017058s
B17017m59 = B17017059s
B17021m1 = B17021001s
B17021m2 = B17021002s
B17021m3 = B17021003s
B17021m4 = B17021004s
B17021m5 = B17021005s
B17021m6 = B17021006s
B17021m7 = B17021007s
B17021m8 = B17021008s
B17021m9 = B17021009s
B17021m10 = B17021010s
B17021m11 = B17021011s
B17021m12 = B17021012s
B17021m13 = B17021013s
B17021m14 = B17021014s
B17021m15 = B17021015s
B17021m16 = B17021016s
B17021m17 = B17021017s
B17021m18 = B17021018s
B17021m19 = B17021019s
B17021m20 = B17021020s
B17021m21 = B17021021s
B17021m22 = B17021022s
B17021m23 = B17021023s
B17021m24 = B17021024s
B17021m25 = B17021025s
B17021m26 = B17021026s
B17021m27 = B17021027s
B17021m28 = B17021028s
B17021m29 = B17021029s
B17021m30 = B17021030s
B17021m31 = B17021031s
B17021m32 = B17021032s
B17021m33 = B17021033s
B17021m34 = B17021034s
B17021m35 = B17021035s
B19001m1 = B19001001s
B19001m2 = B19001002s
B19001m3 = B19001003s
B19001m4 = B19001004s
B19001m5 = B19001005s
B19001m6 = B19001006s
B19001m7 = B19001007s
B19001m8 = B19001008s
B19001m9 = B19001009s
B19001m10 = B19001010s
B19001m11 = B19001011s
B19001m12 = B19001012s
B19001m13 = B19001013s
B19001m14 = B19001014s
B19001m15 = B19001015s
B19001m16 = B19001016s
B19001m17 = B19001017s
B19013m1 = B19013001s
B19025Am1 = B19025A001s
B19025Bm1 = B19025B001s
B19025Hm1 = B19025H001s
B19025m1 = B19025001s
B19037m1 = B19037001s
B19037m2 = B19037002s
B19037m3 = B19037003s
B19037m4 = B19037004s
B19037m5 = B19037005s
B19037m6 = B19037006s
B19037m7 = B19037007s
B19037m8 = B19037008s
B19037m9 = B19037009s
B19037m10 = B19037010s
B19037m11 = B19037011s
B19037m12 = B19037012s
B19037m13 = B19037013s
B19037m14 = B19037014s
B19037m15 = B19037015s
B19037m16 = B19037016s
B19037m17 = B19037017s
B19037m18 = B19037018s
B19037m19 = B19037019s
B19037m20 = B19037020s
B19037m21 = B19037021s
B19037m22 = B19037022s
B19037m23 = B19037023s
B19037m24 = B19037024s
B19037m25 = B19037025s
B19037m26 = B19037026s
B19037m27 = B19037027s
B19037m28 = B19037028s
B19037m29 = B19037029s
B19037m30 = B19037030s
B19037m31 = B19037031s
B19037m32 = B19037032s
B19037m33 = B19037033s
B19037m34 = B19037034s
B19037m35 = B19037035s
B19037m36 = B19037036s
B19037m37 = B19037037s
B19037m38 = B19037038s
B19037m39 = B19037039s
B19037m40 = B19037040s
B19037m41 = B19037041s
B19037m42 = B19037042s
B19037m43 = B19037043s
B19037m44 = B19037044s
B19037m45 = B19037045s
B19037m46 = B19037046s
B19037m47 = B19037047s
B19037m48 = B19037048s
B19037m49 = B19037049s
B19037m50 = B19037050s
B19037m51 = B19037051s
B19037m52 = B19037052s
B19037m53 = B19037053s
B19037m54 = B19037054s
B19037m55 = B19037055s
B19037m56 = B19037056s
B19037m57 = B19037057s
B19037m58 = B19037058s
B19037m59 = B19037059s
B19037m60 = B19037060s
B19037m61 = B19037061s
B19037m62 = B19037062s
B19037m63 = B19037063s
B19037m64 = B19037064s
B19037m65 = B19037065s
B19037m66 = B19037066s
B19037m67 = B19037067s
B19037m68 = B19037068s
B19037m69 = B19037069s
B19049m1 = B19049001s
B19049m2 = B19049002s
B19049m3 = B19049003s
B19049m4 = B19049004s
B19049m5 = B19049005s
B19050m1 = B19050001s
B19050m2 = B19050002s
B19050m3 = B19050003s
B19050m4 = B19050004s
B19050m5 = B19050005s
B19051m1 = B19051001s
B19051m2 = B19051002s
B19051m3 = B19051003s
B19052m1 = B19052001s
B19052m2 = B19052002s
B19052m3 = B19052003s
B19053m1 = B19053001s
B19053m2 = B19053002s
B19053m3 = B19053003s
B19054m1 = B19054001s
B19054m2 = B19054002s
B19054m3 = B19054003s
B19055m1 = B19055001s
B19055m2 = B19055002s
B19055m3 = B19055003s
B19056m1 = B19056001s
B19056m2 = B19056002s
B19056m3 = B19056003s
B19057m1 = B19057001s
B19057m2 = B19057002s
B19057m3 = B19057003s
B19058m1 = B19058001s
B19058m2 = B19058002s
B19058m3 = B19058003s
B19059m1 = B19059001s
B19059m2 = B19059002s
B19059m3 = B19059003s
B19060m1 = B19060001s
B19060m2 = B19060002s
B19060m3 = B19060003s
B19061m1 = B19061001s
B19062m1 = B19062001s
B19063m1 = B19063001s
B19064m1 = B19064001s
B19065m1 = B19065001s
B19066m1 = B19066001s
B19069m1 = B19069001s
B19070m1 = B19070001s
B19101m1 = B19101001s
B19101m2 = B19101002s
B19101m3 = B19101003s
B19101m4 = B19101004s
B19101m5 = B19101005s
B19101m6 = B19101006s
B19101m7 = B19101007s
B19101m8 = B19101008s
B19101m9 = B19101009s
B19101m10 = B19101010s
B19101m11 = B19101011s
B19101m12 = B19101012s
B19101m13 = B19101013s
B19101m14 = B19101014s
B19101m15 = B19101015s
B19101m16 = B19101016s
B19101m17 = B19101017s
B19113m1 = B19113001s
B19123m1 = B19123001s
B19123m2 = B19123002s
B19123m3 = B19123003s
B19123m4 = B19123004s
B19123m5 = B19123005s
B19123m6 = B19123006s
B19123m7 = B19123007s
B19123m8 = B19123008s
B19123m9 = B19123009s
B19123m10 = B19123010s
B19123m11 = B19123011s
B19123m12 = B19123012s
B19123m13 = B19123013s
B19123m14 = B19123014s
B19123m15 = B19123015s
B19123m16 = B19123016s
B19123m17 = B19123017s
B19123m18 = B19123018s
B19123m19 = B19123019s
B19123m20 = B19123020s
B19123m21 = B19123021s
B19127m1 = B19127001s
B19201m1 = B19201001s
B19201m2 = B19201002s
B19201m3 = B19201003s
B19201m4 = B19201004s
B19201m5 = B19201005s
B19201m6 = B19201006s
B19201m7 = B19201007s
B19201m8 = B19201008s
B19201m9 = B19201009s
B19201m10 = B19201010s
B19201m11 = B19201011s
B19201m12 = B19201012s
B19201m13 = B19201013s
B19201m14 = B19201014s
B19201m15 = B19201015s
B19201m16 = B19201016s
B19201m17 = B19201017s
B19202m1 = B19202001s
B19214m1 = B19214001s
B19301Am1 = B19301A001s
B19301Bm1 = B19301B001s
B19301Cm1 = B19301C001s
B19301Fm1 = B19301F001s
B19301Gm1 = B19301G001s
B19301Hm1 = B19301H001s
B19301Im1 = B19301I001s
B19301m1 = B19301001s
B19313Am1 = B19313A001s
B19313Bm1 = B19313B001s
B19313Cm1 = B19313C001s
B19313Fm1 = B19313F001s
B19313Gm1 = B19313G001s
B19313Hm1 = B19313H001s
B19313Im1 = B19313I001s
B19313m1 = B19313001s
B20001m1 = B20001001s
B20001m2 = B20001002s
B20001m3 = B20001003s
B20001m4 = B20001004s
B20001m5 = B20001005s
B20001m6 = B20001006s
B20001m7 = B20001007s
B20001m8 = B20001008s
B20001m9 = B20001009s
B20001m10 = B20001010s
B20001m11 = B20001011s
B20001m12 = B20001012s
B20001m13 = B20001013s
B20001m14 = B20001014s
B20001m15 = B20001015s
B20001m16 = B20001016s
B20001m17 = B20001017s
B20001m18 = B20001018s
B20001m19 = B20001019s
B20001m20 = B20001020s
B20001m21 = B20001021s
B20001m22 = B20001022s
B20001m23 = B20001023s
B20001m24 = B20001024s
B20001m25 = B20001025s
B20001m26 = B20001026s
B20001m27 = B20001027s
B20001m28 = B20001028s
B20001m29 = B20001029s
B20001m30 = B20001030s
B20001m31 = B20001031s
B20001m32 = B20001032s
B20001m33 = B20001033s
B20001m34 = B20001034s
B20001m35 = B20001035s
B20001m36 = B20001036s
B20001m37 = B20001037s
B20001m38 = B20001038s
B20001m39 = B20001039s
B20001m40 = B20001040s
B20001m41 = B20001041s
B20001m42 = B20001042s
B20001m43 = B20001043s
B20002m1 = B20002001s
B20002m2 = B20002002s
B20002m3 = B20002003s
B20003m1 = B20003001s
B20003m2 = B20003002s
B20003m3 = B20003003s
B20003m4 = B20003004s
B20003m5 = B20003005s
B20003m6 = B20003006s
B20003m7 = B20003007s
B20017m1 = B20017001s
B20017m2 = B20017002s
B20017m3 = B20017003s
B20017m4 = B20017004s
B20017m5 = B20017005s
B20017m6 = B20017006s
B20017m7 = B20017007s
C17002m1 = C17002001s
C17002m2 = C17002002s
C17002m3 = C17002003s
C17002m4 = C17002004s
C17002m5 = C17002005s
C17002m6 = C17002006s
C17002m7 = C17002007s
C17002m8 = C17002008s
B21001m1 = B21001001s
B21001m2 = B21001002s
B21001m3 = B21001003s
B21001m4 = B21001004s
B21001m5 = B21001005s
B21001m6 = B21001006s
B21001m7 = B21001007s
B21001m8 = B21001008s
B21001m9 = B21001009s
B21001m10 = B21001010s
B21001m11 = B21001011s
B21001m12 = B21001012s
B21001m13 = B21001013s
B21001m14 = B21001014s
B21001m15 = B21001015s
B21001m16 = B21001016s
B21001m17 = B21001017s
B21001m18 = B21001018s
B21001m19 = B21001019s
B21001m20 = B21001020s
B21001m21 = B21001021s
B21001m22 = B21001022s
B21001m23 = B21001023s
B21001m24 = B21001024s
B21001m25 = B21001025s
B21001m26 = B21001026s
B21001m27 = B21001027s
B21001m28 = B21001028s
B21001m29 = B21001029s
B21001m30 = B21001030s
B21001m31 = B21001031s
B21001m32 = B21001032s
B21001m33 = B21001033s
B21001m34 = B21001034s
B21001m35 = B21001035s
B21001m36 = B21001036s
B21001m37 = B21001037s
B21001m38 = B21001038s
B21001m39 = B21001039s
B21002m1 = B21002001s
B21002m2 = B21002002s
B21002m3 = B21002003s
B21002m4 = B21002004s
B21002m5 = B21002005s
B21002m6 = B21002006s
B21002m7 = B21002007s
B21002m8 = B21002008s
B21002m9 = B21002009s
B21002m10 = B21002010s
B21002m11 = B21002011s
B21002m12 = B21002012s
B21002m13 = B21002013s
B21002m14 = B21002014s
B21002m15 = B21002015s
B21002m16 = B21002016s
B22010m1 = B22010001s
B22010m2 = B22010002s
B22010m3 = B22010003s
B22010m4 = B22010004s
B22010m5 = B22010005s
B22010m6 = B22010006s
B22010m7 = B22010007s
B23003m1 = B23003001s
B23003m2 = B23003002s
B23003m3 = B23003003s
B23003m4 = B23003004s
B23003m5 = B23003005s
B23003m6 = B23003006s
B23003m7 = B23003007s
B23003m8 = B23003008s
B23003m9 = B23003009s
B23003m10 = B23003010s
B23003m11 = B23003011s
B23003m12 = B23003012s
B23003m13 = B23003013s
B23003m14 = B23003014s
B23003m15 = B23003015s
B23003m16 = B23003016s
B23003m17 = B23003017s
B23003m18 = B23003018s
B23003m19 = B23003019s
B23003m20 = B23003020s
B23003m21 = B23003021s
B23003m22 = B23003022s
B23003m23 = B23003023s
B23003m24 = B23003024s
B23003m25 = B23003025s
B23003m26 = B23003026s
B23003m27 = B23003027s
B23003m28 = B23003028s
B23003m29 = B23003029s
B23003m30 = B23003030s
B23007m1 = B23007001s
B23007m2 = B23007002s
B23007m3 = B23007003s
B23007m4 = B23007004s
B23007m5 = B23007005s
B23007m6 = B23007006s
B23007m7 = B23007007s
B23007m8 = B23007008s
B23007m9 = B23007009s
B23007m10 = B23007010s
B23007m11 = B23007011s
B23007m12 = B23007012s
B23007m13 = B23007013s
B23007m14 = B23007014s
B23007m15 = B23007015s
B23007m16 = B23007016s
B23007m17 = B23007017s
B23007m18 = B23007018s
B23007m19 = B23007019s
B23007m20 = B23007020s
B23007m21 = B23007021s
B23007m22 = B23007022s
B23007m23 = B23007023s
B23007m24 = B23007024s
B23007m25 = B23007025s
B23007m26 = B23007026s
B23007m27 = B23007027s
B23007m28 = B23007028s
B23007m29 = B23007029s
B23007m30 = B23007030s
B23007m31 = B23007031s
B23007m32 = B23007032s
B23007m33 = B23007033s
B23007m34 = B23007034s
B23007m35 = B23007035s
B23007m36 = B23007036s
B23007m37 = B23007037s
B23007m38 = B23007038s
B23007m39 = B23007039s
B23007m40 = B23007040s
B23007m41 = B23007041s
B23007m42 = B23007042s
B23007m43 = B23007043s
B23007m44 = B23007044s
B23007m45 = B23007045s
B23007m46 = B23007046s
B23007m47 = B23007047s
B23007m48 = B23007048s
B23007m49 = B23007049s
B23007m50 = B23007050s
B23007m51 = B23007051s
B23007m52 = B23007052s
B23007m53 = B23007053s
B23007m54 = B23007054s
B23007m55 = B23007055s
B23007m56 = B23007056s
B23007m57 = B23007057s
B23007m58 = B23007058s
B23007m59 = B23007059s
B23008m1 = B23008001s
B23008m2 = B23008002s
B23008m3 = B23008003s
B23008m4 = B23008004s
B23008m5 = B23008005s
B23008m6 = B23008006s
B23008m7 = B23008007s
B23008m8 = B23008008s
B23008m9 = B23008009s
B23008m10 = B23008010s
B23008m11 = B23008011s
B23008m12 = B23008012s
B23008m13 = B23008013s
B23008m14 = B23008014s
B23008m15 = B23008015s
B23008m16 = B23008016s
B23008m17 = B23008017s
B23008m18 = B23008018s
B23008m19 = B23008019s
B23008m20 = B23008020s
B23008m21 = B23008021s
B23008m22 = B23008022s
B23008m23 = B23008023s
B23008m24 = B23008024s
B23008m25 = B23008025s
B23008m26 = B23008026s
B23008m27 = B23008027s
B23009m1 = B23009001s
B23009m2 = B23009002s
B23009m3 = B23009003s
B23009m4 = B23009004s
B23009m5 = B23009005s
B23009m6 = B23009006s
B23009m7 = B23009007s
B23009m8 = B23009008s
B23009m9 = B23009009s
B23009m10 = B23009010s
B23009m11 = B23009011s
B23009m12 = B23009012s
B23009m13 = B23009013s
B23009m14 = B23009014s
B23009m15 = B23009015s
B23009m16 = B23009016s
B23009m17 = B23009017s
B23009m18 = B23009018s
B23009m19 = B23009019s
B23009m20 = B23009020s
B23009m21 = B23009021s
B23009m22 = B23009022s
B23009m23 = B23009023s
B23009m24 = B23009024s
B23009m25 = B23009025s
B23009m26 = B23009026s
B23009m27 = B23009027s
B23009m28 = B23009028s
B23009m29 = B23009029s
B23009m30 = B23009030s
B23009m31 = B23009031s
B23009m32 = B23009032s
B23009m33 = B23009033s
B23009m34 = B23009034s
B23009m35 = B23009035s
B23009m36 = B23009036s
B23009m37 = B23009037s
B23009m38 = B23009038s
B23009m39 = B23009039s
B23009m40 = B23009040s
B23009m41 = B23009041s
B23009m42 = B23009042s
B23009m43 = B23009043s
B23022m1 = B23022001s
B23022m2 = B23022002s
B23022m3 = B23022003s
B23022m4 = B23022004s
B23022m5 = B23022005s
B23022m6 = B23022006s
B23022m7 = B23022007s
B23022m8 = B23022008s
B23022m9 = B23022009s
B23022m10 = B23022010s
B23022m11 = B23022011s
B23022m12 = B23022012s
B23022m13 = B23022013s
B23022m14 = B23022014s
B23022m15 = B23022015s
B23022m16 = B23022016s
B23022m17 = B23022017s
B23022m18 = B23022018s
B23022m19 = B23022019s
B23022m20 = B23022020s
B23022m21 = B23022021s
B23022m22 = B23022022s
B23022m23 = B23022023s
B23022m24 = B23022024s
B23022m25 = B23022025s
B23022m26 = B23022026s
B23022m27 = B23022027s
B23022m28 = B23022028s
B23022m29 = B23022029s
B23022m30 = B23022030s
B23022m31 = B23022031s
B23022m32 = B23022032s
B23022m33 = B23022033s
B23022m34 = B23022034s
B23022m35 = B23022035s
B23022m36 = B23022036s
B23022m37 = B23022037s
B23022m38 = B23022038s
B23022m39 = B23022039s
B23022m40 = B23022040s
B23022m41 = B23022041s
B23022m42 = B23022042s
B23022m43 = B23022043s
B23022m44 = B23022044s
B23022m45 = B23022045s
B23022m46 = B23022046s
B23022m47 = B23022047s
B23022m48 = B23022048s
B23022m49 = B23022049s
B23024m1 = B23024001s
B23024m2 = B23024002s
B23024m3 = B23024003s
B23024m4 = B23024004s
B23024m5 = B23024005s
B23024m6 = B23024006s
B23024m7 = B23024007s
B23024m8 = B23024008s
B23024m9 = B23024009s
B23024m10 = B23024010s
B23024m11 = B23024011s
B23024m12 = B23024012s
B23024m13 = B23024013s
B23024m14 = B23024014s
B23024m15 = B23024015s
B23024m16 = B23024016s
B23024m17 = B23024017s
B23024m18 = B23024018s
B23024m19 = B23024019s
B23024m20 = B23024020s
B23024m21 = B23024021s
B23024m22 = B23024022s
B23024m23 = B23024023s
B23024m24 = B23024024s
B23024m25 = B23024025s
B23024m26 = B23024026s
B23024m27 = B23024027s
B23024m28 = B23024028s
B23024m29 = B23024029s
B23024m30 = B23024030s
B23024m31 = B23024031s
B23025m1 = B23025001s
B23025m2 = B23025002s
B23025m3 = B23025003s
B23025m4 = B23025004s
B23025m5 = B23025005s
B23025m6 = B23025006s
B23025m7 = B23025007s
B23026m1 = B23026001s
B23026m2 = B23026002s
B23026m3 = B23026003s
B23026m4 = B23026004s
B23026m5 = B23026005s
B23026m6 = B23026006s
B23026m7 = B23026007s
B23026m8 = B23026008s
B23026m9 = B23026009s
B23026m10 = B23026010s
B23026m11 = B23026011s
B23026m12 = B23026012s
B23026m13 = B23026013s
B23026m14 = B23026014s
B23026m15 = B23026015s
B23026m16 = B23026016s
B23026m17 = B23026017s
B23026m18 = B23026018s
B23026m19 = B23026019s
B23026m20 = B23026020s
B23026m21 = B23026021s
B23026m22 = B23026022s
B23026m23 = B23026023s
B23026m24 = B23026024s
B23026m25 = B23026025s
B23026m26 = B23026026s
B23026m27 = B23026027s
B23026m28 = B23026028s
B23026m29 = B23026029s
B23026m30 = B23026030s
B23026m31 = B23026031s
B23026m32 = B23026032s
B23026m33 = B23026033s
B23026m34 = B23026034s
B23026m35 = B23026035s
B23026m36 = B23026036s
B23026m37 = B23026037s
B23026m38 = B23026038s
B23026m39 = B23026039s
B23026m40 = B23026040s
B23026m41 = B23026041s
B23026m42 = B23026042s
B23026m43 = B23026043s
B23026m44 = B23026044s
B23026m45 = B23026045s
B23026m46 = B23026046s
B23026m47 = B23026047s
B23026m48 = B23026048s
B23026m49 = B23026049s
B23027m1 = B23027001s
B23027m2 = B23027002s
B23027m3 = B23027003s
B23027m4 = B23027004s
B23027m5 = B23027005s
B23027m6 = B23027006s
B23027m7 = B23027007s
B23027m8 = B23027008s
B23027m9 = B23027009s
B23027m10 = B23027010s
B23027m11 = B23027011s
B23027m12 = B23027012s
B23027m13 = B23027013s
B23027m14 = B23027014s
B23027m15 = B23027015s
B23027m16 = B23027016s
B23027m17 = B23027017s
B23027m18 = B23027018s
B23027m19 = B23027019s
B23027m20 = B23027020s
B23027m21 = B23027021s
B23027m22 = B23027022s
B23027m23 = B23027023s
B23027m24 = B23027024s
B23027m25 = B23027025s
B23027m26 = B23027026s
B23027m27 = B23027027s
B23027m28 = B23027028s
B23027m29 = B23027029s
B23027m30 = B23027030s
B23027m31 = B23027031s
B23027m32 = B23027032s
B23027m33 = B23027033s
B23027m34 = B23027034s
B23027m35 = B23027035s
B23027m36 = B23027036s
B24080m1 = B24080001s
B24080m2 = B24080002s
B24080m3 = B24080003s
B24080m4 = B24080004s
B24080m5 = B24080005s
B24080m6 = B24080006s
B24080m7 = B24080007s
B24080m8 = B24080008s
B24080m9 = B24080009s
B24080m10 = B24080010s
B24080m11 = B24080011s
B24080m12 = B24080012s
B24080m13 = B24080013s
B24080m14 = B24080014s
B24080m15 = B24080015s
B24080m16 = B24080016s
B24080m17 = B24080017s
B24080m18 = B24080018s
B24080m19 = B24080019s
B24080m20 = B24080020s
B24080m21 = B24080021s
C21007m1 = C21007001s
C21007m2 = C21007002s
C21007m3 = C21007003s
C21007m4 = C21007004s
C21007m5 = C21007005s
C21007m6 = C21007006s
C21007m7 = C21007007s
C21007m8 = C21007008s
C21007m9 = C21007009s
C21007m10 = C21007010s
C21007m11 = C21007011s
C21007m12 = C21007012s
C21007m13 = C21007013s
C21007m14 = C21007014s
C21007m15 = C21007015s
C21007m16 = C21007016s
C21007m17 = C21007017s
C21007m18 = C21007018s
C21007m19 = C21007019s
C21007m20 = C21007020s
C21007m21 = C21007021s
C21007m22 = C21007022s
C21007m23 = C21007023s
C21007m24 = C21007024s
C21007m25 = C21007025s
C21007m26 = C21007026s
C21007m27 = C21007027s
C21007m28 = C21007028s
C21007m29 = C21007029s
C21007m30 = C21007030s
C21007m31 = C21007031s
C24010Am1 = C24010A001s
C24010Am2 = C24010A002s
C24010Am3 = C24010A003s
C24010Am4 = C24010A004s
C24010Am5 = C24010A005s
C24010Am6 = C24010A006s
C24010Am7 = C24010A007s
C24010Am8 = C24010A008s
C24010Am9 = C24010A009s
C24010Am10 = C24010A010s
C24010Am11 = C24010A011s
C24010Am12 = C24010A012s
C24010Am13 = C24010A013s
C24010Bm1 = C24010B001s
C24010Bm2 = C24010B002s
C24010Bm3 = C24010B003s
C24010Bm4 = C24010B004s
C24010Bm5 = C24010B005s
C24010Bm6 = C24010B006s
C24010Bm7 = C24010B007s
C24010Bm8 = C24010B008s
C24010Bm9 = C24010B009s
C24010Bm10 = C24010B010s
C24010Bm11 = C24010B011s
C24010Bm12 = C24010B012s
C24010Bm13 = C24010B013s
C24010Cm1 = C24010C001s
C24010Cm2 = C24010C002s
C24010Cm3 = C24010C003s
C24010Cm4 = C24010C004s
C24010Cm5 = C24010C005s
C24010Cm6 = C24010C006s
C24010Cm7 = C24010C007s
C24010Cm8 = C24010C008s
C24010Cm9 = C24010C009s
C24010Cm10 = C24010C010s
C24010Cm11 = C24010C011s
C24010Cm12 = C24010C012s
C24010Cm13 = C24010C013s
C24010Dm1 = C24010D001s
C24010Dm2 = C24010D002s
C24010Dm3 = C24010D003s
C24010Dm4 = C24010D004s
C24010Dm5 = C24010D005s
C24010Dm6 = C24010D006s
C24010Dm7 = C24010D007s
C24010Dm8 = C24010D008s
C24010Dm9 = C24010D009s
C24010Dm10 = C24010D010s
C24010Dm11 = C24010D011s
C24010Dm12 = C24010D012s
C24010Dm13 = C24010D013s
C24010Em1 = C24010E001s
C24010Em2 = C24010E002s
C24010Em3 = C24010E003s
C24010Em4 = C24010E004s
C24010Em5 = C24010E005s
C24010Em6 = C24010E006s
C24010Em7 = C24010E007s
C24010Em8 = C24010E008s
C24010Em9 = C24010E009s
C24010Em10 = C24010E010s
C24010Em11 = C24010E011s
C24010Em12 = C24010E012s
C24010Em13 = C24010E013s
C24010Fm1 = C24010F001s
C24010Fm2 = C24010F002s
C24010Fm3 = C24010F003s
C24010Fm4 = C24010F004s
C24010Fm5 = C24010F005s
C24010Fm6 = C24010F006s
C24010Fm7 = C24010F007s
C24010Fm8 = C24010F008s
C24010Fm9 = C24010F009s
C24010Fm10 = C24010F010s
C24010Fm11 = C24010F011s
C24010Fm12 = C24010F012s
C24010Fm13 = C24010F013s
C24010Gm1 = C24010G001s
C24010Gm2 = C24010G002s
C24010Gm3 = C24010G003s
C24010Gm4 = C24010G004s
C24010Gm5 = C24010G005s
C24010Gm6 = C24010G006s
C24010Gm7 = C24010G007s
C24010Gm8 = C24010G008s
C24010Gm9 = C24010G009s
C24010Gm10 = C24010G010s
C24010Gm11 = C24010G011s
C24010Gm12 = C24010G012s
C24010Gm13 = C24010G013s
C24010Hm1 = C24010H001s
C24010Hm2 = C24010H002s
C24010Hm3 = C24010H003s
C24010Hm4 = C24010H004s
C24010Hm5 = C24010H005s
C24010Hm6 = C24010H006s
C24010Hm7 = C24010H007s
C24010Hm8 = C24010H008s
C24010Hm9 = C24010H009s
C24010Hm10 = C24010H010s
C24010Hm11 = C24010H011s
C24010Hm12 = C24010H012s
C24010Hm13 = C24010H013s
C24010Im1 = C24010I001s
C24010Im2 = C24010I002s
C24010Im3 = C24010I003s
C24010Im4 = C24010I004s
C24010Im5 = C24010I005s
C24010Im6 = C24010I006s
C24010Im7 = C24010I007s
C24010Im8 = C24010I008s
C24010Im9 = C24010I009s
C24010Im10 = C24010I010s
C24010Im11 = C24010I011s
C24010Im12 = C24010I012s
C24010Im13 = C24010I013s
C24010m1 = C24010001s
C24010m2 = C24010002s
C24010m3 = C24010003s
C24010m4 = C24010004s
C24010m5 = C24010005s
C24010m6 = C24010006s
C24010m7 = C24010007s
C24010m8 = C24010008s
C24010m9 = C24010009s
C24010m10 = C24010010s
C24010m11 = C24010011s
C24010m12 = C24010012s
C24010m13 = C24010013s
C24010m14 = C24010014s
C24010m15 = C24010015s
C24010m16 = C24010016s
C24010m17 = C24010017s
C24010m18 = C24010018s
C24010m19 = C24010019s
C24010m20 = C24010020s
C24010m21 = C24010021s
C24010m22 = C24010022s
C24010m23 = C24010023s
C24010m24 = C24010024s
C24010m25 = C24010025s
C24010m26 = C24010026s
C24010m27 = C24010027s
C24010m28 = C24010028s
C24010m29 = C24010029s
C24010m30 = C24010030s
C24010m31 = C24010031s
C24010m32 = C24010032s
C24010m33 = C24010033s
C24010m34 = C24010034s
C24010m35 = C24010035s
C24010m36 = C24010036s
C24010m37 = C24010037s
C24010m38 = C24010038s
C24010m39 = C24010039s
C24010m40 = C24010040s
C24010m41 = C24010041s
C24010m42 = C24010042s
C24010m43 = C24010043s
C24010m44 = C24010044s
C24010m45 = C24010045s
C24010m46 = C24010046s
C24010m47 = C24010047s
C24010m48 = C24010048s
C24010m49 = C24010049s
C24010m50 = C24010050s
C24010m51 = C24010051s
C24010m52 = C24010052s
C24010m53 = C24010053s
C24010m54 = C24010054s
C24010m55 = C24010055s
C24010m56 = C24010056s
C24010m57 = C24010057s
C24010m58 = C24010058s
C24010m59 = C24010059s
C24010m60 = C24010060s
C24010m61 = C24010061s
C24010m62 = C24010062s
C24010m63 = C24010063s
C24010m64 = C24010064s
C24010m65 = C24010065s
C24010m66 = C24010066s
C24010m67 = C24010067s
C24010m68 = C24010068s
C24010m69 = C24010069s
C24010m70 = C24010070s
C24010m71 = C24010071s
C24010m72 = C24010072s
C24010m73 = C24010073s
C24020m1 = C24020001s
C24020m2 = C24020002s
C24020m3 = C24020003s
C24020m4 = C24020004s
C24020m5 = C24020005s
C24020m6 = C24020006s
C24020m7 = C24020007s
C24020m8 = C24020008s
C24020m9 = C24020009s
C24020m10 = C24020010s
C24020m11 = C24020011s
C24020m12 = C24020012s
C24020m13 = C24020013s
C24020m14 = C24020014s
C24020m15 = C24020015s
C24020m16 = C24020016s
C24020m17 = C24020017s
C24020m18 = C24020018s
C24020m19 = C24020019s
C24020m20 = C24020020s
C24020m21 = C24020021s
C24020m22 = C24020022s
C24020m23 = C24020023s
C24020m24 = C24020024s
C24020m25 = C24020025s
C24020m26 = C24020026s
C24020m27 = C24020027s
C24020m28 = C24020028s
C24020m29 = C24020029s
C24020m30 = C24020030s
C24020m31 = C24020031s
C24020m32 = C24020032s
C24020m33 = C24020033s
C24020m34 = C24020034s
C24020m35 = C24020035s
C24020m36 = C24020036s
C24020m37 = C24020037s
C24020m38 = C24020038s
C24020m39 = C24020039s
C24020m40 = C24020040s
C24020m41 = C24020041s
C24020m42 = C24020042s
C24020m43 = C24020043s
C24020m44 = C24020044s
C24020m45 = C24020045s
C24020m46 = C24020046s
C24020m47 = C24020047s
C24020m48 = C24020048s
C24020m49 = C24020049s
C24020m50 = C24020050s
C24020m51 = C24020051s
C24020m52 = C24020052s
C24020m53 = C24020053s
C24020m54 = C24020054s
C24020m55 = C24020055s
C24020m56 = C24020056s
C24020m57 = C24020057s
C24020m58 = C24020058s
C24020m59 = C24020059s
C24020m60 = C24020060s
C24020m61 = C24020061s
C24020m62 = C24020062s
C24020m63 = C24020063s
C24020m64 = C24020064s
C24020m65 = C24020065s
C24020m66 = C24020066s
C24020m67 = C24020067s
C24020m68 = C24020068s
C24020m69 = C24020069s
C24020m70 = C24020070s
C24020m71 = C24020071s
C24020m72 = C24020072s
C24020m73 = C24020073s
C24030m1 = C24030001s
C24030m2 = C24030002s
C24030m3 = C24030003s
C24030m4 = C24030004s
C24030m5 = C24030005s
C24030m6 = C24030006s
C24030m7 = C24030007s
C24030m8 = C24030008s
C24030m9 = C24030009s
C24030m10 = C24030010s
C24030m11 = C24030011s
C24030m12 = C24030012s
C24030m13 = C24030013s
C24030m14 = C24030014s
C24030m15 = C24030015s
C24030m16 = C24030016s
C24030m17 = C24030017s
C24030m18 = C24030018s
C24030m19 = C24030019s
C24030m20 = C24030020s
C24030m21 = C24030021s
C24030m22 = C24030022s
C24030m23 = C24030023s
C24030m24 = C24030024s
C24030m25 = C24030025s
C24030m26 = C24030026s
C24030m27 = C24030027s
C24030m28 = C24030028s
C24030m29 = C24030029s
C24030m30 = C24030030s
C24030m31 = C24030031s
C24030m32 = C24030032s
C24030m33 = C24030033s
C24030m34 = C24030034s
C24030m35 = C24030035s
C24030m36 = C24030036s
C24030m37 = C24030037s
C24030m38 = C24030038s
C24030m39 = C24030039s
C24030m40 = C24030040s
C24030m41 = C24030041s
C24030m42 = C24030042s
C24030m43 = C24030043s
C24030m44 = C24030044s
C24030m45 = C24030045s
C24030m46 = C24030046s
C24030m47 = C24030047s
C24030m48 = C24030048s
C24030m49 = C24030049s
C24030m50 = C24030050s
C24030m51 = C24030051s
C24030m52 = C24030052s
C24030m53 = C24030053s
C24030m54 = C24030054s
C24030m55 = C24030055s
B25001m1 = B25001001s
B25002m1 = B25002001s
B25002m2 = B25002002s
B25002m3 = B25002003s
B25003Am1 = B25003A001s
B25003Am2 = B25003A002s
B25003Am3 = B25003A003s
B25003Bm1 = B25003B001s
B25003Bm2 = B25003B002s
B25003Bm3 = B25003B003s
B25003Cm1 = B25003C001s
B25003Cm2 = B25003C002s
B25003Cm3 = B25003C003s
B25003Dm1 = B25003D001s
B25003Dm2 = B25003D002s
B25003Dm3 = B25003D003s
B25003Em1 = B25003E001s
B25003Em2 = B25003E002s
B25003Em3 = B25003E003s
B25003Fm1 = B25003F001s
B25003Fm2 = B25003F002s
B25003Fm3 = B25003F003s
B25003Gm1 = B25003G001s
B25003Gm2 = B25003G002s
B25003Gm3 = B25003G003s
B25003Hm1 = B25003H001s
B25003Hm2 = B25003H002s
B25003Hm3 = B25003H003s
B25003Im1 = B25003I001s
B25003Im2 = B25003I002s
B25003Im3 = B25003I003s
B25003m1 = B25003001s
B25003m2 = B25003002s
B25003m3 = B25003003s
B25004m1 = B25004001s
B25004m2 = B25004002s
B25004m3 = B25004003s
B25004m4 = B25004004s
B25004m5 = B25004005s
B25004m6 = B25004006s
B25004m7 = B25004007s
B25004m8 = B25004008s
B25006m1 = B25006001s
B25006m2 = B25006002s
B25006m3 = B25006003s
B25006m4 = B25006004s
B25006m5 = B25006005s
B25006m6 = B25006006s
B25006m7 = B25006007s
B25006m8 = B25006008s
B25006m9 = B25006009s
B25006m10 = B25006010s
B25007m1 = B25007001s
B25007m2 = B25007002s
B25007m3 = B25007003s
B25007m4 = B25007004s
B25007m5 = B25007005s
B25007m6 = B25007006s
B25007m7 = B25007007s
B25007m8 = B25007008s
B25007m9 = B25007009s
B25007m10 = B25007010s
B25007m11 = B25007011s
B25007m12 = B25007012s
B25007m13 = B25007013s
B25007m14 = B25007014s
B25007m15 = B25007015s
B25007m16 = B25007016s
B25007m17 = B25007017s
B25007m18 = B25007018s
B25007m19 = B25007019s
B25007m20 = B25007020s
B25007m21 = B25007021s
B25008m1 = B25008001s
B25008m2 = B25008002s
B25008m3 = B25008003s
B25009m1 = B25009001s
B25009m2 = B25009002s
B25009m3 = B25009003s
B25009m4 = B25009004s
B25009m5 = B25009005s
B25009m6 = B25009006s
B25009m7 = B25009007s
B25009m8 = B25009008s
B25009m9 = B25009009s
B25009m10 = B25009010s
B25009m11 = B25009011s
B25009m12 = B25009012s
B25009m13 = B25009013s
B25009m14 = B25009014s
B25009m15 = B25009015s
B25009m16 = B25009016s
B25009m17 = B25009017s
B25010m1 = B25010001s
B25010m2 = B25010002s
B25010m3 = B25010003s
B25014m1 = B25014001s
B25014m2 = B25014002s
B25014m3 = B25014003s
B25014m4 = B25014004s
B25014m5 = B25014005s
B25014m6 = B25014006s
B25014m7 = B25014007s
B25014m8 = B25014008s
B25014m9 = B25014009s
B25014m10 = B25014010s
B25014m11 = B25014011s
B25014m12 = B25014012s
B25014m13 = B25014013s
B25015m1 = B25015001s
B25015m2 = B25015002s
B25015m3 = B25015003s
B25015m4 = B25015004s
B25015m5 = B25015005s
B25015m6 = B25015006s
B25015m7 = B25015007s
B25015m8 = B25015008s
B25015m9 = B25015009s
B25015m10 = B25015010s
B25015m11 = B25015011s
B25015m12 = B25015012s
B25015m13 = B25015013s
B25015m14 = B25015014s
B25015m15 = B25015015s
B25015m16 = B25015016s
B25015m17 = B25015017s
B25015m18 = B25015018s
B25015m19 = B25015019s
B25015m20 = B25015020s
B25015m21 = B25015021s
B25015m22 = B25015022s
B25015m23 = B25015023s
B25015m24 = B25015024s
B25015m25 = B25015025s
B25015m26 = B25015026s
B25015m27 = B25015027s
B25016m1 = B25016001s
B25016m2 = B25016002s
B25016m3 = B25016003s
B25016m4 = B25016004s
B25016m5 = B25016005s
B25016m6 = B25016006s
B25016m7 = B25016007s
B25016m8 = B25016008s
B25016m9 = B25016009s
B25016m10 = B25016010s
B25016m11 = B25016011s
B25016m12 = B25016012s
B25016m13 = B25016013s
B25016m14 = B25016014s
B25016m15 = B25016015s
B25016m16 = B25016016s
B25016m17 = B25016017s
B25016m18 = B25016018s
B25016m19 = B25016019s
B25017m1 = B25017001s
B25017m2 = B25017002s
B25017m3 = B25017003s
B25017m4 = B25017004s
B25017m5 = B25017005s
B25017m6 = B25017006s
B25017m7 = B25017007s
B25017m8 = B25017008s
B25017m9 = B25017009s
B25017m10 = B25017010s
B25018m1 = B25018001s
B25019m1 = B25019001s
B25020m1 = B25020001s
B25020m2 = B25020002s
B25020m3 = B25020003s
B25020m4 = B25020004s
B25020m5 = B25020005s
B25020m6 = B25020006s
B25020m7 = B25020007s
B25020m8 = B25020008s
B25020m9 = B25020009s
B25020m10 = B25020010s
B25020m11 = B25020011s
B25020m12 = B25020012s
B25020m13 = B25020013s
B25020m14 = B25020014s
B25020m15 = B25020015s
B25020m16 = B25020016s
B25020m17 = B25020017s
B25020m18 = B25020018s
B25020m19 = B25020019s
B25020m20 = B25020020s
B25020m21 = B25020021s
B25021m1 = B25021001s
B25021m2 = B25021002s
B25021m3 = B25021003s
B25022m1 = B25022001s
B25022m2 = B25022002s
B25022m3 = B25022003s
B25024m1 = B25024001s
B25024m2 = B25024002s
B25024m3 = B25024003s
B25024m4 = B25024004s
B25024m5 = B25024005s
B25024m6 = B25024006s
B25024m7 = B25024007s
B25024m8 = B25024008s
B25024m9 = B25024009s
B25024m10 = B25024010s
B25024m11 = B25024011s
B25032m1 = B25032001s
B25032m2 = B25032002s
B25032m3 = B25032003s
B25032m4 = B25032004s
B25032m5 = B25032005s
B25032m6 = B25032006s
B25032m7 = B25032007s
B25032m8 = B25032008s
B25032m9 = B25032009s
B25032m10 = B25032010s
B25032m11 = B25032011s
B25032m12 = B25032012s
B25032m13 = B25032013s
B25032m14 = B25032014s
B25032m15 = B25032015s
B25032m16 = B25032016s
B25032m17 = B25032017s
B25032m18 = B25032018s
B25032m19 = B25032019s
B25032m20 = B25032020s
B25032m21 = B25032021s
B25032m22 = B25032022s
B25032m23 = B25032023s
B25033m1 = B25033001s
B25033m2 = B25033002s
B25033m3 = B25033003s
B25033m4 = B25033004s
B25033m5 = B25033005s
B25033m6 = B25033006s
B25033m7 = B25033007s
B25033m8 = B25033008s
B25033m9 = B25033009s
B25033m10 = B25033010s
B25033m11 = B25033011s
B25033m12 = B25033012s
B25033m13 = B25033013s
B25034m1 = B25034001s
B25034m2 = B25034002s
B25034m3 = B25034003s
B25034m4 = B25034004s
B25034m5 = B25034005s
B25034m6 = B25034006s
B25034m7 = B25034007s
B25034m8 = B25034008s
B25034m9 = B25034009s
B25034m10 = B25034010s
B25034m11 = B25034011s
B25035m1 = B25035001s
B25036m1 = B25036001s
B25036m2 = B25036002s
B25036m3 = B25036003s
B25036m4 = B25036004s
B25036m5 = B25036005s
B25036m6 = B25036006s
B25036m7 = B25036007s
B25036m8 = B25036008s
B25036m9 = B25036009s
B25036m10 = B25036010s
B25036m11 = B25036011s
B25036m12 = B25036012s
B25036m13 = B25036013s
B25036m14 = B25036014s
B25036m15 = B25036015s
B25036m16 = B25036016s
B25036m17 = B25036017s
B25036m18 = B25036018s
B25036m19 = B25036019s
B25036m20 = B25036020s
B25036m21 = B25036021s
B25036m22 = B25036022s
B25036m23 = B25036023s
B25037m1 = B25037001s
B25037m2 = B25037002s
B25037m3 = B25037003s
B25038m1 = B25038001s
B25038m2 = B25038002s
B25038m3 = B25038003s
B25038m4 = B25038004s
B25038m5 = B25038005s
B25038m6 = B25038006s
B25038m7 = B25038007s
B25038m8 = B25038008s
B25038m9 = B25038009s
B25038m10 = B25038010s
B25038m11 = B25038011s
B25038m12 = B25038012s
B25038m13 = B25038013s
B25038m14 = B25038014s
B25038m15 = B25038015s
B25039m1 = B25039001s
B25039m2 = B25039002s
B25039m3 = B25039003s
B25040m1 = B25040001s
B25040m2 = B25040002s
B25040m3 = B25040003s
B25040m4 = B25040004s
B25040m5 = B25040005s
B25040m6 = B25040006s
B25040m7 = B25040007s
B25040m8 = B25040008s
B25040m9 = B25040009s
B25040m10 = B25040010s
B25041m1 = B25041001s
B25041m2 = B25041002s
B25041m3 = B25041003s
B25041m4 = B25041004s
B25041m5 = B25041005s
B25041m6 = B25041006s
B25041m7 = B25041007s
B25042m1 = B25042001s
B25042m2 = B25042002s
B25042m3 = B25042003s
B25042m4 = B25042004s
B25042m5 = B25042005s
B25042m6 = B25042006s
B25042m7 = B25042007s
B25042m8 = B25042008s
B25042m9 = B25042009s
B25042m10 = B25042010s
B25042m11 = B25042011s
B25042m12 = B25042012s
B25042m13 = B25042013s
B25042m14 = B25042014s
B25042m15 = B25042015s
B25043m1 = B25043001s
B25043m2 = B25043002s
B25043m3 = B25043003s
B25043m4 = B25043004s
B25043m5 = B25043005s
B25043m6 = B25043006s
B25043m7 = B25043007s
B25043m8 = B25043008s
B25043m9 = B25043009s
B25043m10 = B25043010s
B25043m11 = B25043011s
B25043m12 = B25043012s
B25043m13 = B25043013s
B25043m14 = B25043014s
B25043m15 = B25043015s
B25043m16 = B25043016s
B25043m17 = B25043017s
B25043m18 = B25043018s
B25043m19 = B25043019s
B25044m1 = B25044001s
B25044m2 = B25044002s
B25044m3 = B25044003s
B25044m4 = B25044004s
B25044m5 = B25044005s
B25044m6 = B25044006s
B25044m7 = B25044007s
B25044m8 = B25044008s
B25044m9 = B25044009s
B25044m10 = B25044010s
B25044m11 = B25044011s
B25044m12 = B25044012s
B25044m13 = B25044013s
B25044m14 = B25044014s
B25044m15 = B25044015s
B25045m1 = B25045001s
B25045m2 = B25045002s
B25045m3 = B25045003s
B25045m4 = B25045004s
B25045m5 = B25045005s
B25045m6 = B25045006s
B25045m7 = B25045007s
B25045m8 = B25045008s
B25045m9 = B25045009s
B25045m10 = B25045010s
B25045m11 = B25045011s
B25045m12 = B25045012s
B25045m13 = B25045013s
B25045m14 = B25045014s
B25045m15 = B25045015s
B25045m16 = B25045016s
B25045m17 = B25045017s
B25045m18 = B25045018s
B25045m19 = B25045019s
B25046m1 = B25046001s
B25046m2 = B25046002s
B25046m3 = B25046003s
B25047m1 = B25047001s
B25047m2 = B25047002s
B25047m3 = B25047003s
B25049m1 = B25049001s
B25049m2 = B25049002s
B25049m3 = B25049003s
B25049m4 = B25049004s
B25049m5 = B25049005s
B25049m6 = B25049006s
B25049m7 = B25049007s
B25050m1 = B25050001s
B25050m2 = B25050002s
B25050m3 = B25050003s
B25050m4 = B25050004s
B25050m5 = B25050005s
B25050m6 = B25050006s
B25050m7 = B25050007s
B25050m8 = B25050008s
B25050m9 = B25050009s
B25050m10 = B25050010s
B25050m11 = B25050011s
B25050m12 = B25050012s
B25050m13 = B25050013s
B25050m14 = B25050014s
B25050m15 = B25050015s
B25050m16 = B25050016s
B25050m17 = B25050017s
B25050m18 = B25050018s
B25050m19 = B25050019s
B25051m1 = B25051001s
B25051m2 = B25051002s
B25051m3 = B25051003s
B25053m1 = B25053001s
B25053m2 = B25053002s
B25053m3 = B25053003s
B25053m4 = B25053004s
B25053m5 = B25053005s
B25053m6 = B25053006s
B25053m7 = B25053007s
B25054m1 = B25054001s
B25054m2 = B25054002s
B25054m3 = B25054003s
B25054m4 = B25054004s
B25054m5 = B25054005s
B25054m6 = B25054006s
B25054m7 = B25054007s
B25055m1 = B25055001s
B25055m2 = B25055002s
B25055m3 = B25055003s
B25055m4 = B25055004s
B25055m5 = B25055005s
B25055m6 = B25055006s
B25055m7 = B25055007s
B25055m8 = B25055008s
B25055m9 = B25055009s
B25055m10 = B25055010s
B25055m11 = B25055011s
B25055m12 = B25055012s
B25055m13 = B25055013s
B25056m1 = B25056001s
B25056m2 = B25056002s
B25056m3 = B25056003s
B25056m4 = B25056004s
B25056m5 = B25056005s
B25056m6 = B25056006s
B25056m7 = B25056007s
B25056m8 = B25056008s
B25056m9 = B25056009s
B25056m10 = B25056010s
B25056m11 = B25056011s
B25056m12 = B25056012s
B25056m13 = B25056013s
B25056m14 = B25056014s
B25056m15 = B25056015s
B25056m16 = B25056016s
B25056m17 = B25056017s
B25056m18 = B25056018s
B25056m19 = B25056019s
B25056m20 = B25056020s
B25056m21 = B25056021s
B25056m22 = B25056022s
B25056m23 = B25056023s
B25056m24 = B25056024s
B25056m25 = B25056025s
B25056m26 = B25056026s
B25056m27 = B25056027s
B25057m1 = B25057001s
B25058m1 = B25058001s
B25059m1 = B25059001s
B25060m1 = B25060001s
B25061m1 = B25061001s
B25061m2 = B25061002s
B25061m3 = B25061003s
B25061m4 = B25061004s
B25061m5 = B25061005s
B25061m6 = B25061006s
B25061m7 = B25061007s
B25061m8 = B25061008s
B25061m9 = B25061009s
B25061m10 = B25061010s
B25061m11 = B25061011s
B25061m12 = B25061012s
B25061m13 = B25061013s
B25061m14 = B25061014s
B25061m15 = B25061015s
B25061m16 = B25061016s
B25061m17 = B25061017s
B25061m18 = B25061018s
B25061m19 = B25061019s
B25061m20 = B25061020s
B25061m21 = B25061021s
B25061m22 = B25061022s
B25061m23 = B25061023s
B25061m24 = B25061024s
B25061m25 = B25061025s
B25062m1 = B25062001s
B25063m1 = B25063001s
B25063m2 = B25063002s
B25063m3 = B25063003s
B25063m4 = B25063004s
B25063m5 = B25063005s
B25063m6 = B25063006s
B25063m7 = B25063007s
B25063m8 = B25063008s
B25063m9 = B25063009s
B25063m10 = B25063010s
B25063m11 = B25063011s
B25063m12 = B25063012s
B25063m13 = B25063013s
B25063m14 = B25063014s
B25063m15 = B25063015s
B25063m16 = B25063016s
B25063m17 = B25063017s
B25063m18 = B25063018s
B25063m19 = B25063019s
B25063m20 = B25063020s
B25063m21 = B25063021s
B25063m22 = B25063022s
B25063m23 = B25063023s
B25063m24 = B25063024s
B25063m25 = B25063025s
B25063m26 = B25063026s
B25063m27 = B25063027s
B25064m1 = B25064001s
B25065m1 = B25065001s
B25066m1 = B25066001s
B25066m2 = B25066002s
B25066m3 = B25066003s
B25066m4 = B25066004s
B25066m5 = B25066005s
B25066m6 = B25066006s
B25066m7 = B25066007s
B25066m8 = B25066008s
B25067m1 = B25067001s
B25067m2 = B25067002s
B25067m3 = B25067003s
B25068m1 = B25068001s
B25068m2 = B25068002s
B25068m3 = B25068003s
B25068m4 = B25068004s
B25068m5 = B25068005s
B25068m6 = B25068006s
B25068m7 = B25068007s
B25068m8 = B25068008s
B25068m9 = B25068009s
B25068m10 = B25068010s
B25068m11 = B25068011s
B25068m12 = B25068012s
B25068m13 = B25068013s
B25068m14 = B25068014s
B25068m15 = B25068015s
B25068m16 = B25068016s
B25068m17 = B25068017s
B25068m18 = B25068018s
B25068m19 = B25068019s
B25068m20 = B25068020s
B25068m21 = B25068021s
B25068m22 = B25068022s
B25068m23 = B25068023s
B25068m24 = B25068024s
B25068m25 = B25068025s
B25068m26 = B25068026s
B25068m27 = B25068027s
B25068m28 = B25068028s
B25068m29 = B25068029s
B25068m30 = B25068030s
B25068m31 = B25068031s
B25068m32 = B25068032s
B25068m33 = B25068033s
B25068m34 = B25068034s
B25068m35 = B25068035s
B25068m36 = B25068036s
B25068m37 = B25068037s
B25069m1 = B25069001s
B25069m2 = B25069002s
B25069m3 = B25069003s
B25070m1 = B25070001s
B25070m2 = B25070002s
B25070m3 = B25070003s
B25070m4 = B25070004s
B25070m5 = B25070005s
B25070m6 = B25070006s
B25070m7 = B25070007s
B25070m8 = B25070008s
B25070m9 = B25070009s
B25070m10 = B25070010s
B25070m11 = B25070011s
B25071m1 = B25071001s
B25072m1 = B25072001s
B25072m2 = B25072002s
B25072m3 = B25072003s
B25072m4 = B25072004s
B25072m5 = B25072005s
B25072m6 = B25072006s
B25072m7 = B25072007s
B25072m8 = B25072008s
B25072m9 = B25072009s
B25072m10 = B25072010s
B25072m11 = B25072011s
B25072m12 = B25072012s
B25072m13 = B25072013s
B25072m14 = B25072014s
B25072m15 = B25072015s
B25072m16 = B25072016s
B25072m17 = B25072017s
B25072m18 = B25072018s
B25072m19 = B25072019s
B25072m20 = B25072020s
B25072m21 = B25072021s
B25072m22 = B25072022s
B25072m23 = B25072023s
B25072m24 = B25072024s
B25072m25 = B25072025s
B25072m26 = B25072026s
B25072m27 = B25072027s
B25072m28 = B25072028s
B25072m29 = B25072029s
B25074m1 = B25074001s
B25074m2 = B25074002s
B25074m3 = B25074003s
B25074m4 = B25074004s
B25074m5 = B25074005s
B25074m6 = B25074006s
B25074m7 = B25074007s
B25074m8 = B25074008s
B25074m9 = B25074009s
B25074m10 = B25074010s
B25074m11 = B25074011s
B25074m12 = B25074012s
B25074m13 = B25074013s
B25074m14 = B25074014s
B25074m15 = B25074015s
B25074m16 = B25074016s
B25074m17 = B25074017s
B25074m18 = B25074018s
B25074m19 = B25074019s
B25074m20 = B25074020s
B25074m21 = B25074021s
B25074m22 = B25074022s
B25074m23 = B25074023s
B25074m24 = B25074024s
B25074m25 = B25074025s
B25074m26 = B25074026s
B25074m27 = B25074027s
B25074m28 = B25074028s
B25074m29 = B25074029s
B25074m30 = B25074030s
B25074m31 = B25074031s
B25074m32 = B25074032s
B25074m33 = B25074033s
B25074m34 = B25074034s
B25074m35 = B25074035s
B25074m36 = B25074036s
B25074m37 = B25074037s
B25074m38 = B25074038s
B25074m39 = B25074039s
B25074m40 = B25074040s
B25074m41 = B25074041s
B25074m42 = B25074042s
B25074m43 = B25074043s
B25074m44 = B25074044s
B25074m45 = B25074045s
B25074m46 = B25074046s
B25074m47 = B25074047s
B25074m48 = B25074048s
B25074m49 = B25074049s
B25074m50 = B25074050s
B25074m51 = B25074051s
B25074m52 = B25074052s
B25074m53 = B25074053s
B25074m54 = B25074054s
B25074m55 = B25074055s
B25074m56 = B25074056s
B25074m57 = B25074057s
B25074m58 = B25074058s
B25074m59 = B25074059s
B25074m60 = B25074060s
B25074m61 = B25074061s
B25074m62 = B25074062s
B25074m63 = B25074063s
B25074m64 = B25074064s
B25075m1 = B25075001s
B25075m2 = B25075002s
B25075m3 = B25075003s
B25075m4 = B25075004s
B25075m5 = B25075005s
B25075m6 = B25075006s
B25075m7 = B25075007s
B25075m8 = B25075008s
B25075m9 = B25075009s
B25075m10 = B25075010s
B25075m11 = B25075011s
B25075m12 = B25075012s
B25075m13 = B25075013s
B25075m14 = B25075014s
B25075m15 = B25075015s
B25075m16 = B25075016s
B25075m17 = B25075017s
B25075m18 = B25075018s
B25075m19 = B25075019s
B25075m20 = B25075020s
B25075m21 = B25075021s
B25075m22 = B25075022s
B25075m23 = B25075023s
B25075m24 = B25075024s
B25075m25 = B25075025s
B25075m26 = B25075026s
B25075m27 = B25075027s
B25076m1 = B25076001s
B25077m1 = B25077001s
B25078m1 = B25078001s
B25079m1 = B25079001s
B25079m2 = B25079002s
B25079m3 = B25079003s
B25079m4 = B25079004s
B25079m5 = B25079005s
B25080m1 = B25080001s
B25080m2 = B25080002s
B25080m3 = B25080003s
B25080m4 = B25080004s
B25080m5 = B25080005s
B25080m6 = B25080006s
B25080m7 = B25080007s
B25080m8 = B25080008s
B25081m1 = B25081001s
B25081m2 = B25081002s
B25081m3 = B25081003s
B25081m4 = B25081004s
B25081m5 = B25081005s
B25081m6 = B25081006s
B25081m7 = B25081007s
B25081m8 = B25081008s
B25082m1 = B25082001s
B25082m2 = B25082002s
B25082m3 = B25082003s
B25083m1 = B25083001s
B25085m1 = B25085001s
B25085m2 = B25085002s
B25085m3 = B25085003s
B25085m4 = B25085004s
B25085m5 = B25085005s
B25085m6 = B25085006s
B25085m7 = B25085007s
B25085m8 = B25085008s
B25085m9 = B25085009s
B25085m10 = B25085010s
B25085m11 = B25085011s
B25085m12 = B25085012s
B25085m13 = B25085013s
B25085m14 = B25085014s
B25085m15 = B25085015s
B25085m16 = B25085016s
B25085m17 = B25085017s
B25085m18 = B25085018s
B25085m19 = B25085019s
B25085m20 = B25085020s
B25085m21 = B25085021s
B25085m22 = B25085022s
B25085m23 = B25085023s
B25085m24 = B25085024s
B25085m25 = B25085025s
B25085m26 = B25085026s
B25085m27 = B25085027s
B25087m1 = B25087001s
B25087m2 = B25087002s
B25087m3 = B25087003s
B25087m4 = B25087004s
B25087m5 = B25087005s
B25087m6 = B25087006s
B25087m7 = B25087007s
B25087m8 = B25087008s
B25087m9 = B25087009s
B25087m10 = B25087010s
B25087m11 = B25087011s
B25087m12 = B25087012s
B25087m13 = B25087013s
B25087m14 = B25087014s
B25087m15 = B25087015s
B25087m16 = B25087016s
B25087m17 = B25087017s
B25087m18 = B25087018s
B25087m19 = B25087019s
B25087m20 = B25087020s
B25087m21 = B25087021s
B25087m22 = B25087022s
B25087m23 = B25087023s
B25087m24 = B25087024s
B25087m25 = B25087025s
B25087m26 = B25087026s
B25087m27 = B25087027s
B25087m28 = B25087028s
B25087m29 = B25087029s
B25087m30 = B25087030s
B25087m31 = B25087031s
B25087m32 = B25087032s
B25087m33 = B25087033s
B25087m34 = B25087034s
B25087m35 = B25087035s
B25087m36 = B25087036s
B25087m37 = B25087037s
B25087m38 = B25087038s
B25087m39 = B25087039s
B25088m1 = B25088001s
B25088m2 = B25088002s
B25088m3 = B25088003s
B25089m1 = B25089001s
B25089m2 = B25089002s
B25089m3 = B25089003s
B25091m1 = B25091001s
B25091m2 = B25091002s
B25091m3 = B25091003s
B25091m4 = B25091004s
B25091m5 = B25091005s
B25091m6 = B25091006s
B25091m7 = B25091007s
B25091m8 = B25091008s
B25091m9 = B25091009s
B25091m10 = B25091010s
B25091m11 = B25091011s
B25091m12 = B25091012s
B25091m13 = B25091013s
B25091m14 = B25091014s
B25091m15 = B25091015s
B25091m16 = B25091016s
B25091m17 = B25091017s
B25091m18 = B25091018s
B25091m19 = B25091019s
B25091m20 = B25091020s
B25091m21 = B25091021s
B25091m22 = B25091022s
B25091m23 = B25091023s
B25092m1 = B25092001s
B25092m2 = B25092002s
B25092m3 = B25092003s
B25093m1 = B25093001s
B25093m2 = B25093002s
B25093m3 = B25093003s
B25093m4 = B25093004s
B25093m5 = B25093005s
B25093m6 = B25093006s
B25093m7 = B25093007s
B25093m8 = B25093008s
B25093m9 = B25093009s
B25093m10 = B25093010s
B25093m11 = B25093011s
B25093m12 = B25093012s
B25093m13 = B25093013s
B25093m14 = B25093014s
B25093m15 = B25093015s
B25093m16 = B25093016s
B25093m17 = B25093017s
B25093m18 = B25093018s
B25093m19 = B25093019s
B25093m20 = B25093020s
B25093m21 = B25093021s
B25093m22 = B25093022s
B25093m23 = B25093023s
B25093m24 = B25093024s
B25093m25 = B25093025s
B25093m26 = B25093026s
B25093m27 = B25093027s
B25093m28 = B25093028s
B25093m29 = B25093029s
B27010m1 = B27010001s
B27010m2 = B27010002s
B27010m3 = B27010003s
B27010m4 = B27010004s
B27010m5 = B27010005s
B27010m6 = B27010006s
B27010m7 = B27010007s
B27010m8 = B27010008s
B27010m9 = B27010009s
B27010m10 = B27010010s
B27010m11 = B27010011s
B27010m12 = B27010012s
B27010m13 = B27010013s
B27010m14 = B27010014s
B27010m15 = B27010015s
B27010m16 = B27010016s
B27010m17 = B27010017s
B27010m18 = B27010018s
B27010m19 = B27010019s
B27010m20 = B27010020s
B27010m21 = B27010021s
B27010m22 = B27010022s
B27010m23 = B27010023s
B27010m24 = B27010024s
B27010m25 = B27010025s
B27010m26 = B27010026s
B27010m27 = B27010027s
B27010m28 = B27010028s
B27010m29 = B27010029s
B27010m30 = B27010030s
B27010m31 = B27010031s
B27010m32 = B27010032s
B27010m33 = B27010033s
B27010m34 = B27010034s
B27010m35 = B27010035s
B27010m36 = B27010036s
B27010m37 = B27010037s
B27010m38 = B27010038s
B27010m39 = B27010039s
B27010m40 = B27010040s
B27010m41 = B27010041s
B27010m42 = B27010042s
B27010m43 = B27010043s
B27010m44 = B27010044s
B27010m45 = B27010045s
B27010m46 = B27010046s
B27010m47 = B27010047s
B27010m48 = B27010048s
B27010m49 = B27010049s
B27010m50 = B27010050s
B27010m51 = B27010051s
B27010m52 = B27010052s
B27010m53 = B27010053s
B27010m54 = B27010054s
B27010m55 = B27010055s
B27010m56 = B27010056s
B27010m57 = B27010057s
B27010m58 = B27010058s
B27010m59 = B27010059s
B27010m60 = B27010060s
B27010m61 = B27010061s
B27010m62 = B27010062s
B27010m63 = B27010063s
B27010m64 = B27010064s
B27010m65 = B27010065s
B27010m66 = B27010066s
B28001m1 = B28001001s
B28001m2 = B28001002s
B28001m3 = B28001003s
B28001m4 = B28001004s
B28001m5 = B28001005s
B28001m6 = B28001006s
B28001m7 = B28001007s
B28001m8 = B28001008s
B28001m9 = B28001009s
B28001m10 = B28001010s
B28001m11 = B28001011s
B28002m1 = B28002001s
B28002m2 = B28002002s
B28002m3 = B28002003s
B28002m4 = B28002004s
B28002m5 = B28002005s
B28002m6 = B28002006s
B28002m7 = B28002007s
B28002m8 = B28002008s
B28002m9 = B28002009s
B28002m10 = B28002010s
B28002m11 = B28002011s
B28002m12 = B28002012s
B28002m13 = B28002013s
B28003m1 = B28003001s
B28003m2 = B28003002s
B28003m3 = B28003003s
B28003m4 = B28003004s
B28003m5 = B28003005s
B28003m6 = B28003006s
B28004m1 = B28004001s
B28004m2 = B28004002s
B28004m3 = B28004003s
B28004m4 = B28004004s
B28004m5 = B28004005s
B28004m6 = B28004006s
B28004m7 = B28004007s
B28004m8 = B28004008s
B28004m9 = B28004009s
B28004m10 = B28004010s
B28004m11 = B28004011s
B28004m12 = B28004012s
B28004m13 = B28004013s
B28004m14 = B28004014s
B28004m15 = B28004015s
B28004m16 = B28004016s
B28004m17 = B28004017s
B28004m18 = B28004018s
B28004m19 = B28004019s
B28004m20 = B28004020s
B28004m21 = B28004021s
B28004m22 = B28004022s
B28004m23 = B28004023s
B28004m24 = B28004024s
B28004m25 = B28004025s
B28005m1 = B28005001s
B28005m2 = B28005002s
B28005m3 = B28005003s
B28005m4 = B28005004s
B28005m5 = B28005005s
B28005m6 = B28005006s
B28005m7 = B28005007s
B28005m8 = B28005008s
B28005m9 = B28005009s
B28005m10 = B28005010s
B28005m11 = B28005011s
B28005m12 = B28005012s
B28005m13 = B28005013s
B28005m14 = B28005014s
B28005m15 = B28005015s
B28005m16 = B28005016s
B28005m17 = B28005017s
B28005m18 = B28005018s
B28005m19 = B28005019s
B28006m1 = B28006001s
B28006m2 = B28006002s
B28006m3 = B28006003s
B28006m4 = B28006004s
B28006m5 = B28006005s
B28006m6 = B28006006s
B28006m7 = B28006007s
B28006m8 = B28006008s
B28006m9 = B28006009s
B28006m10 = B28006010s
B28006m11 = B28006011s
B28006m12 = B28006012s
B28006m13 = B28006013s
B28006m14 = B28006014s
B28006m15 = B28006015s
B28006m16 = B28006016s
B28006m17 = B28006017s
B28006m18 = B28006018s
B28006m19 = B28006019s
B28007m1 = B28007001s
B28007m2 = B28007002s
B28007m3 = B28007003s
B28007m4 = B28007004s
B28007m5 = B28007005s
B28007m6 = B28007006s
B28007m7 = B28007007s
B28007m8 = B28007008s
B28007m9 = B28007009s
B28007m10 = B28007010s
B28007m11 = B28007011s
B28007m12 = B28007012s
B28007m13 = B28007013s
B28007m14 = B28007014s
B28007m15 = B28007015s
B28007m16 = B28007016s
B28007m17 = B28007017s
B28007m18 = B28007018s
B28007m19 = B28007019s
B28007m20 = B28007020s
B28008m1 = B28008001s
B28008m2 = B28008002s
B28008m3 = B28008003s
B28008m4 = B28008004s
B28008m5 = B28008005s
B28008m6 = B28008006s
B28008m7 = B28008007s
B28008m8 = B28008008s
B28008m9 = B28008009s
B28008m10 = B28008010s
B28009Am1 = B28009A001s
B28009Am2 = B28009A002s
B28009Am3 = B28009A003s
B28009Am4 = B28009A004s
B28009Am5 = B28009A005s
B28009Am6 = B28009A006s
B28009Bm1 = B28009B001s
B28009Bm2 = B28009B002s
B28009Bm3 = B28009B003s
B28009Bm4 = B28009B004s
B28009Bm5 = B28009B005s
B28009Bm6 = B28009B006s
B28009Cm1 = B28009C001s
B28009Cm2 = B28009C002s
B28009Cm3 = B28009C003s
B28009Cm4 = B28009C004s
B28009Cm5 = B28009C005s
B28009Cm6 = B28009C006s
B28009Dm1 = B28009D001s
B28009Dm2 = B28009D002s
B28009Dm3 = B28009D003s
B28009Dm4 = B28009D004s
B28009Dm5 = B28009D005s
B28009Dm6 = B28009D006s
B28009Em1 = B28009E001s
B28009Em2 = B28009E002s
B28009Em3 = B28009E003s
B28009Em4 = B28009E004s
B28009Em5 = B28009E005s
B28009Em6 = B28009E006s
B28009Fm1 = B28009F001s
B28009Fm2 = B28009F002s
B28009Fm3 = B28009F003s
B28009Fm4 = B28009F004s
B28009Fm5 = B28009F005s
B28009Fm6 = B28009F006s
B28009Gm1 = B28009G001s
B28009Gm2 = B28009G002s
B28009Gm3 = B28009G003s
B28009Gm4 = B28009G004s
B28009Gm5 = B28009G005s
B28009Gm6 = B28009G006s
B28009Hm1 = B28009H001s
B28009Hm2 = B28009H002s
B28009Hm3 = B28009H003s
B28009Hm4 = B28009H004s
B28009Hm5 = B28009H005s
B28009Hm6 = B28009H006s
B28009Im1 = B28009I001s
B28009Im2 = B28009I002s
B28009Im3 = B28009I003s
B28009Im4 = B28009I004s
B28009Im5 = B28009I005s
B28009Im6 = B28009I006s
B28010m1 = B28010001s
B28010m2 = B28010002s
B28010m3 = B28010003s
B28010m4 = B28010004s
B28010m5 = B28010005s
B28010m6 = B28010006s
B28010m7 = B28010007s
B28011m1 = B28011001s
B28011m2 = B28011002s
B28011m3 = B28011003s
B28011m4 = B28011004s
B28011m5 = B28011005s
B28011m6 = B28011006s
B28011m7 = B28011007s
B28011m8 = B28011008s
;
%mend;












































%macro rename2;
rename
B19083i1 = B19083001 
B07003i1 = B07003001
B07003i4 = B07003004
B01001i1 = B01001001
B01001i2 = B01001002
B01001i3 = B01001003
B01001i4 = B01001004
B01001i5 = B01001005
B01001i6 = B01001006
B01001i7 = B01001007
B01001i8 = B01001008
B01001i9 = B01001009
B01001i10 = B01001010
B01001i11 = B01001011
B01001i12 = B01001012
B01001i13 = B01001013
B01001i14 = B01001014
B01001i15 = B01001015
B01001i16 = B01001016
B01001i17 = B01001017
B01001i18 = B01001018
B01001i19 = B01001019
B01001i20 = B01001020
B01001i21 = B01001021
B01001i22 = B01001022
B01001i23 = B01001023
B01001i24 = B01001024
B01001i25 = B01001025
B01001i26 = B01001026
B01001i27 = B01001027
B01001i28 = B01001028
B01001i29 = B01001029
B01001i30 = B01001030
B01001i31 = B01001031
B01001i32 = B01001032
B01001i33 = B01001033
B01001i34 = B01001034
B01001i35 = B01001035
B01001i36 = B01001036
B01001i37 = B01001037
B01001i38 = B01001038
B01001i39 = B01001039
B01001i40 = B01001040
B01001i41 = B01001041
B01001i42 = B01001042
B01001i43 = B01001043
B01001i44 = B01001044
B01001i45 = B01001045
B01001i46 = B01001046
B01001i47 = B01001047
B01001i48 = B01001048
B01001i49 = B01001049
B01002Ai1 = B01002A001
B01002Ai2 = B01002A002
B01002Ai3 = B01002A003
B01002Bi1 = B01002B001
B01002Bi2 = B01002B002
B01002Bi3 = B01002B003
B01002Ci1 = B01002C001
B01002Ci2 = B01002C002
B01002Ci3 = B01002C003
B01002Di1 = B01002D001
B01002Di2 = B01002D002
B01002Di3 = B01002D003
B01002Fi1 = B01002F001
B01002Fi2 = B01002F002
B01002Fi3 = B01002F003
B01002Gi1 = B01002G001
B01002Gi2 = B01002G002
B01002Gi3 = B01002G003
B01002Hi1 = B01002H001
B01002Hi2 = B01002H002
B01002Hi3 = B01002H003
B01002Ii1 = B01002I001
B01002Ii2 = B01002I002
B01002Ii3 = B01002I003
B01002i1 = B01002001
B01002i2 = B01002002
B01002i3 = B01002003
B01003i1 = B01003001
B02001i1 = B02001001
B02001i2 = B02001002
B02001i3 = B02001003
B02001i4 = B02001004
B02001i5 = B02001005
B02001i6 = B02001006
B02001i7 = B02001007
B02001i8 = B02001008
B02001i9 = B02001009
B02001i10 = B02001010
B02008i1 = B02008001
B02009i1 = B02009001
B02010i1 = B02010001
B02011i1 = B02011001
B02012i1 = B02012001
B02013i1 = B02013001
B03002i1 = B03002001
B03002i2 = B03002002
B03002i3 = B03002003
B03002i4 = B03002004
B03002i5 = B03002005
B03002i6 = B03002006
B03002i7 = B03002007
B03002i8 = B03002008
B03002i9 = B03002009
B03002i10 = B03002010
B03002i11 = B03002011
B03002i12 = B03002012
B03002i13 = B03002013
B03002i14 = B03002014
B03002i15 = B03002015
B03002i16 = B03002016
B03002i17 = B03002017
B03002i18 = B03002018
B03002i19 = B03002019
B03002i20 = B03002020
B03002i21 = B03002021
B03003i1 = B03003001
B03003i2 = B03003002
B03003i3 = B03003003
B07201i1 = B07201001
B07201i2 = B07201002
B07201i3 = B07201003
B07201i4 = B07201004
B07201i5 = B07201005
B07201i6 = B07201006
B07201i7 = B07201007
B07201i8 = B07201008
B07201i9 = B07201009
B07201i10 = B07201010
B07201i11 = B07201011
B07201i12 = B07201012
B07201i13 = B07201013
B07201i14 = B07201014
B07202i1 = B07202001
B07202i2 = B07202002
B07202i3 = B07202003
B07202i4 = B07202004
B07202i5 = B07202005
B07202i6 = B07202006
B07202i7 = B07202007
B07202i8 = B07202008
B07202i9 = B07202009
B07202i10 = B07202010
B07202i11 = B07202011
B07202i12 = B07202012
B07202i13 = B07202013
B07202i14 = B07202014
B07203i1 = B07203001
B07203i2 = B07203002
B07203i3 = B07203003
B07203i4 = B07203004
B07203i5 = B07203005
B07203i6 = B07203006
B07203i7 = B07203007
B07203i8 = B07203008
B07203i9 = B07203009
B07203i10 = B07203010
B07203i11 = B07203011
C02003i1 = C02003001
C02003i2 = C02003002
C02003i3 = C02003003
C02003i4 = C02003004
C02003i5 = C02003005
C02003i6 = C02003006
C02003i7 = C02003007
C02003i8 = C02003008
C02003i9 = C02003009
C02003i10 = C02003010
C02003i11 = C02003011
C02003i12 = C02003012
C02003i13 = C02003013
C02003i14 = C02003014
C02003i15 = C02003015
C02003i16 = C02003016
C02003i17 = C02003017
C02003i18 = C02003018
C02003i19 = C02003019
B08007i1 = B08007001
B08007i2 = B08007002
B08007i3 = B08007003
B08007i4 = B08007004
B08007i5 = B08007005
B08007i6 = B08007006
B08007i7 = B08007007
B08007i8 = B08007008
B08007i9 = B08007009
B08007i10 = B08007010
B08007i11 = B08007011
B08007i12 = B08007012
B08007i13 = B08007013
B08007i14 = B08007014
B08007i15 = B08007015
B08008i1 = B08008001
B08008i2 = B08008002
B08008i3 = B08008003
B08008i4 = B08008004
B08008i5 = B08008005
B08008i6 = B08008006
B08008i7 = B08008007
B08008i8 = B08008008
B08008i9 = B08008009
B08008i10 = B08008010
B08008i11 = B08008011
B08008i12 = B08008012
B08008i13 = B08008013
B08008i14 = B08008014
B08008i15 = B08008015
B08009i1 = B08009001
B08009i2 = B08009002
B08009i3 = B08009003
B08009i4 = B08009004
B08009i5 = B08009005
B08009i6 = B08009006
B08009i7 = B08009007
B08009i8 = B08009008
B08009i9 = B08009009
B08009i10 = B08009010
B08009i11 = B08009011
B08009i12 = B08009012
B08009i13 = B08009013
B08009i14 = B08009014
B08009i15 = B08009015
B08016i1 = B08016001
B08016i2 = B08016002
B08016i3 = B08016003
B08016i4 = B08016004
B08016i5 = B08016005
B08016i6 = B08016006
B08016i7 = B08016007
B08016i8 = B08016008
B08016i9 = B08016009
B08016i10 = B08016010
B08016i11 = B08016011
B08016i12 = B08016012
B08016i13 = B08016013
B08016i14 = B08016014
B08016i15 = B08016015
B08016i16 = B08016016
B08016i17 = B08016017
B08016i18 = B08016018
B08016i19 = B08016019
B08016i20 = B08016020
B08016i21 = B08016021
B08016i22 = B08016022
B08016i23 = B08016023
B08017i1 = B08017001
B08017i2 = B08017002
B08017i3 = B08017003
B08017i4 = B08017004
B08017i5 = B08017005
B08017i6 = B08017006
B08017i7 = B08017007
B08017i8 = B08017008
B08017i9 = B08017009
B08017i10 = B08017010
B08017i11 = B08017011
B08017i12 = B08017012
B08017i13 = B08017013
B08017i14 = B08017014
B08017i15 = B08017015
B08017i16 = B08017016
B08017i17 = B08017017
B08017i18 = B08017018
B08017i19 = B08017019
B08017i20 = B08017020
B08017i21 = B08017021
B08017i22 = B08017022
B08017i23 = B08017023
B08018i1 = B08018001
B08018i2 = B08018002
B08018i3 = B08018003
B08018i4 = B08018004
B08018i5 = B08018005
B08018i6 = B08018006
B08018i7 = B08018007
B08018i8 = B08018008
B08134i1 = B08134001
B08134i2 = B08134002
B08134i3 = B08134003
B08134i4 = B08134004
B08134i5 = B08134005
B08134i6 = B08134006
B08134i7 = B08134007
B08134i8 = B08134008
B08134i9 = B08134009
B08134i10 = B08134010
B08134i11 = B08134011
B08134i12 = B08134012
B08134i13 = B08134013
B08134i14 = B08134014
B08134i15 = B08134015
B08134i16 = B08134016
B08134i17 = B08134017
B08134i18 = B08134018
B08134i19 = B08134019
B08134i20 = B08134020
B08134i21 = B08134021
B08134i22 = B08134022
B08134i23 = B08134023
B08134i24 = B08134024
B08134i25 = B08134025
B08134i26 = B08134026
B08134i27 = B08134027
B08134i28 = B08134028
B08134i29 = B08134029
B08134i30 = B08134030
B08134i31 = B08134031
B08134i32 = B08134032
B08134i33 = B08134033
B08134i34 = B08134034
B08134i35 = B08134035
B08134i36 = B08134036
B08134i37 = B08134037
B08134i38 = B08134038
B08134i39 = B08134039
B08134i40 = B08134040
B08134i41 = B08134041
B08134i42 = B08134042
B08134i43 = B08134043
B08134i44 = B08134044
B08134i45 = B08134045
B08134i46 = B08134046
B08134i47 = B08134047
B08134i48 = B08134048
B08134i49 = B08134049
B08134i50 = B08134050
B08134i51 = B08134051
B08134i52 = B08134052
B08134i53 = B08134053
B08134i54 = B08134054
B08134i55 = B08134055
B08134i56 = B08134056
B08134i57 = B08134057
B08134i58 = B08134058
B08134i59 = B08134059
B08134i60 = B08134060
B08134i61 = B08134061
B08134i62 = B08134062
B08134i63 = B08134063
B08134i64 = B08134064
B08134i65 = B08134065
B08134i66 = B08134066
B08134i67 = B08134067
B08134i68 = B08134068
B08134i69 = B08134069
B08134i70 = B08134070
B08134i71 = B08134071
B08134i72 = B08134072
B08134i73 = B08134073
B08134i74 = B08134074
B08134i75 = B08134075
B08134i76 = B08134076
B08134i77 = B08134077
B08134i78 = B08134078
B08134i79 = B08134079
B08134i80 = B08134080
B08134i81 = B08134081
B08134i82 = B08134082
B08134i83 = B08134083
B08134i84 = B08134084
B08134i85 = B08134085
B08134i86 = B08134086
B08134i87 = B08134087
B08134i88 = B08134088
B08134i89 = B08134089
B08134i90 = B08134090
B08134i91 = B08134091
B08134i92 = B08134092
B08134i93 = B08134093
B08134i94 = B08134094
B08134i95 = B08134095
B08134i96 = B08134096
B08134i97 = B08134097
B08134i98 = B08134098
B08134i99 = B08134099
B08134i100 = B081340100
B08134i101 = B081340101
B08134i102 = B081340102
B08134i103 = B081340103
B08134i104 = B081340104
B08134i105 = B081340105
B08134i106 = B081340106
B08134i107 = B081340107
B08134i108 = B081340108
B08134i109 = B081340109
B08134i110 = B081340110
B08134i111 = B081340111
B08134i112 = B081340112
B08134i113 = B081340113
B08134i114 = B081340114
B08134i115 = B081340115
B08134i116 = B081340116
B08134i117 = B081340117
B08134i118 = B081340118
B08134i119 = B081340119
B08134i120 = B081340120
B08135i1 = B08135001
B08135i2 = B08135002
B08135i3 = B08135003
B08135i4 = B08135004
B08135i5 = B08135005
B08135i6 = B08135006
B08135i7 = B08135007
B08135i8 = B08135008
B08135i9 = B08135009
B08135i10 = B08135010
B08136i1 = B08136001
B08136i2 = B08136002
B08136i3 = B08136003
B08136i4 = B08136004
B08136i5 = B08136005
B08136i6 = B08136006
B08136i7 = B08136007
B08136i8 = B08136008
B08136i9 = B08136009
B08136i10 = B08136010
B08136i11 = B08136011
B08136i12 = B08136012
B08301i1 = B08301001
B08301i2 = B08301002
B08301i3 = B08301003
B08301i4 = B08301004
B08301i5 = B08301005
B08301i6 = B08301006
B08301i7 = B08301007
B08301i8 = B08301008
B08301i9 = B08301009
B08301i10 = B08301010
B08301i11 = B08301011
B08301i12 = B08301012
B08301i13 = B08301013
B08301i14 = B08301014
B08301i15 = B08301015
B08301i16 = B08301016
B08301i17 = B08301017
B08301i18 = B08301018
B08301i19 = B08301019
B08301i20 = B08301020
B08301i21 = B08301021
B08302i1 = B08302001
B08302i2 = B08302002
B08302i3 = B08302003
B08302i4 = B08302004
B08302i5 = B08302005
B08302i6 = B08302006
B08302i7 = B08302007
B08302i8 = B08302008
B08302i9 = B08302009
B08302i10 = B08302010
B08302i11 = B08302011
B08302i12 = B08302012
B08302i13 = B08302013
B08302i14 = B08302014
B08302i15 = B08302015
B08303i1 = B08303001
B08303i2 = B08303002
B08303i3 = B08303003
B08303i4 = B08303004
B08303i5 = B08303005
B08303i6 = B08303006
B08303i7 = B08303007
B08303i8 = B08303008
B08303i9 = B08303009
B08303i10 = B08303010
B08303i11 = B08303011
B08303i12 = B08303012
B08303i13 = B08303013
B09002i1 = B09002001
B09002i2 = B09002002
B09002i3 = B09002003
B09002i4 = B09002004
B09002i5 = B09002005
B09002i6 = B09002006
B09002i7 = B09002007
B09002i8 = B09002008
B09002i9 = B09002009
B09002i10 = B09002010
B09002i11 = B09002011
B09002i12 = B09002012
B09002i13 = B09002013
B09002i14 = B09002014
B09002i15 = B09002015
B09002i16 = B09002016
B09002i17 = B09002017
B09002i18 = B09002018
B09002i19 = B09002019
B09002i20 = B09002020
B09018i1 = B09018001
B09018i2 = B09018002
B09018i3 = B09018003
B09018i4 = B09018004
B09018i5 = B09018005
B09018i6 = B09018006
B09018i7 = B09018007
B09018i8 = B09018008
B09019i1 = B09019001
B09019i2 = B09019002
B09019i3 = B09019003
B09019i4 = B09019004
B09019i5 = B09019005
B09019i6 = B09019006
B09019i7 = B09019007
B09019i8 = B09019008
B09019i9 = B09019009
B09019i10 = B09019010
B09019i11 = B09019011
B09019i12 = B09019012
B09019i13 = B09019013
B09019i14 = B09019014
B09019i15 = B09019015
B09019i16 = B09019016
B09019i17 = B09019017
B09019i18 = B09019018
B09019i19 = B09019019
B09019i20 = B09019020
B09019i21 = B09019021
B09019i22 = B09019022
B09019i23 = B09019023
B09019i24 = B09019024
B09019i25 = B09019025
B09019i26 = B09019026
B09020i1 = B09020001
B09020i2 = B09020002
B09020i3 = B09020003
B09020i4 = B09020004
B09020i5 = B09020005
B09020i6 = B09020006
B09020i7 = B09020007
B09020i8 = B09020008
B09020i9 = B09020009
B09020i10 = B09020010
B09020i11 = B09020011
B09020i12 = B09020012
B09020i13 = B09020013
B09020i14 = B09020014
B09020i15 = B09020015
B09020i16 = B09020016
B09020i17 = B09020017
B09020i18 = B09020018
B09020i19 = B09020019
B09020i20 = B09020020
B09020i21 = B09020021
B09021i1 = B09021001
B09021i2 = B09021002
B09021i3 = B09021003
B09021i4 = B09021004
B09021i5 = B09021005
B09021i6 = B09021006
B09021i7 = B09021007
B09021i8 = B09021008
B09021i9 = B09021009
B09021i10 = B09021010
B09021i11 = B09021011
B09021i12 = B09021012
B09021i13 = B09021013
B09021i14 = B09021014
B09021i15 = B09021015
B09021i16 = B09021016
B09021i17 = B09021017
B09021i18 = B09021018
B09021i19 = B09021019
B09021i20 = B09021020
B09021i21 = B09021021
B09021i22 = B09021022
B09021i23 = B09021023
B09021i24 = B09021024
B09021i25 = B09021025
B09021i26 = B09021026
B09021i27 = B09021027
B09021i28 = B09021028
B11001Ai1 = B11001A001
B11001Ai2 = B11001A002
B11001Ai3 = B11001A003
B11001Ai4 = B11001A004
B11001Ai5 = B11001A005
B11001Ai6 = B11001A006
B11001Ai7 = B11001A007
B11001Ai8 = B11001A008
B11001Ai9 = B11001A009
B11001Bi1 = B11001B001
B11001Bi2 = B11001B002
B11001Bi3 = B11001B003
B11001Bi4 = B11001B004
B11001Bi5 = B11001B005
B11001Bi6 = B11001B006
B11001Bi7 = B11001B007
B11001Bi8 = B11001B008
B11001Bi9 = B11001B009
B11001Ci1 = B11001C001
B11001Ci2 = B11001C002
B11001Ci3 = B11001C003
B11001Ci4 = B11001C004
B11001Ci5 = B11001C005
B11001Ci6 = B11001C006
B11001Ci7 = B11001C007
B11001Ci8 = B11001C008
B11001Ci9 = B11001C009
B11001Di1 = B11001D001
B11001Di2 = B11001D002
B11001Di3 = B11001D003
B11001Di4 = B11001D004
B11001Di5 = B11001D005
B11001Di6 = B11001D006
B11001Di7 = B11001D007
B11001Di8 = B11001D008
B11001Di9 = B11001D009
B11001Ei1 = B11001E001
B11001Ei2 = B11001E002
B11001Ei3 = B11001E003
B11001Ei4 = B11001E004
B11001Ei5 = B11001E005
B11001Ei6 = B11001E006
B11001Ei7 = B11001E007
B11001Ei8 = B11001E008
B11001Ei9 = B11001E009
B11001Fi1 = B11001F001
B11001Fi2 = B11001F002
B11001Fi3 = B11001F003
B11001Fi4 = B11001F004
B11001Fi5 = B11001F005
B11001Fi6 = B11001F006
B11001Fi7 = B11001F007
B11001Fi8 = B11001F008
B11001Fi9 = B11001F009
B11001Gi1 = B11001G001
B11001Gi2 = B11001G002
B11001Gi3 = B11001G003
B11001Gi4 = B11001G004
B11001Gi5 = B11001G005
B11001Gi6 = B11001G006
B11001Gi7 = B11001G007
B11001Gi8 = B11001G008
B11001Gi9 = B11001G009
B11001Hi1 = B11001H001
B11001Hi2 = B11001H002
B11001Hi3 = B11001H003
B11001Hi4 = B11001H004
B11001Hi5 = B11001H005
B11001Hi6 = B11001H006
B11001Hi7 = B11001H007
B11001Hi8 = B11001H008
B11001Hi9 = B11001H009
B11001Ii1 = B11001I001
B11001Ii2 = B11001I002
B11001Ii3 = B11001I003
B11001Ii4 = B11001I004
B11001Ii5 = B11001I005
B11001Ii6 = B11001I006
B11001Ii7 = B11001I007
B11001Ii8 = B11001I008
B11001Ii9 = B11001I009
B11001i1 = B11001001
B11001i2 = B11001002
B11001i3 = B11001003
B11001i4 = B11001004
B11001i5 = B11001005
B11001i6 = B11001006
B11001i7 = B11001007
B11001i8 = B11001008
B11001i9 = B11001009
B11002Ai1 = B11002A001
B11002Ai2 = B11002A002
B11002Ai3 = B11002A003
B11002Ai4 = B11002A004
B11002Ai5 = B11002A005
B11002Ai6 = B11002A006
B11002Ai7 = B11002A007
B11002Ai8 = B11002A008
B11002Ai9 = B11002A009
B11002Ai10 = B11002A010
B11002Ai11 = B11002A011
B11002Ai12 = B11002A012
B11002Bi1 = B11002B001
B11002Bi2 = B11002B002
B11002Bi3 = B11002B003
B11002Bi4 = B11002B004
B11002Bi5 = B11002B005
B11002Bi6 = B11002B006
B11002Bi7 = B11002B007
B11002Bi8 = B11002B008
B11002Bi9 = B11002B009
B11002Bi10 = B11002B010
B11002Bi11 = B11002B011
B11002Bi12 = B11002B012
B11002Ci1 = B11002C001
B11002Ci2 = B11002C002
B11002Ci3 = B11002C003
B11002Ci4 = B11002C004
B11002Ci5 = B11002C005
B11002Ci6 = B11002C006
B11002Ci7 = B11002C007
B11002Ci8 = B11002C008
B11002Ci9 = B11002C009
B11002Ci10 = B11002C010
B11002Ci11 = B11002C011
B11002Ci12 = B11002C012
B11002Di1 = B11002D001
B11002Di2 = B11002D002
B11002Di3 = B11002D003
B11002Di4 = B11002D004
B11002Di5 = B11002D005
B11002Di6 = B11002D006
B11002Di7 = B11002D007
B11002Di8 = B11002D008
B11002Di9 = B11002D009
B11002Di10 = B11002D010
B11002Di11 = B11002D011
B11002Di12 = B11002D012
B11002Ei1 = B11002E001
B11002Ei2 = B11002E002
B11002Ei3 = B11002E003
B11002Ei4 = B11002E004
B11002Ei5 = B11002E005
B11002Ei6 = B11002E006
B11002Ei7 = B11002E007
B11002Ei8 = B11002E008
B11002Ei9 = B11002E009
B11002Ei10 = B11002E010
B11002Ei11 = B11002E011
B11002Ei12 = B11002E012
B11002Fi1 = B11002F001
B11002Fi2 = B11002F002
B11002Fi3 = B11002F003
B11002Fi4 = B11002F004
B11002Fi5 = B11002F005
B11002Fi6 = B11002F006
B11002Fi7 = B11002F007
B11002Fi8 = B11002F008
B11002Fi9 = B11002F009
B11002Fi10 = B11002F010
B11002Fi11 = B11002F011
B11002Fi12 = B11002F012
B11002Gi1 = B11002G001
B11002Gi2 = B11002G002
B11002Gi3 = B11002G003
B11002Gi4 = B11002G004
B11002Gi5 = B11002G005
B11002Gi6 = B11002G006
B11002Gi7 = B11002G007
B11002Gi8 = B11002G008
B11002Gi9 = B11002G009
B11002Gi10 = B11002G010
B11002Gi11 = B11002G011
B11002Gi12 = B11002G012
B11002Hi1 = B11002H001
B11002Hi2 = B11002H002
B11002Hi3 = B11002H003
B11002Hi4 = B11002H004
B11002Hi5 = B11002H005
B11002Hi6 = B11002H006
B11002Hi7 = B11002H007
B11002Hi8 = B11002H008
B11002Hi9 = B11002H009
B11002Hi10 = B11002H010
B11002Hi11 = B11002H011
B11002Hi12 = B11002H012
B11002Ii1 = B11002I001
B11002Ii2 = B11002I002
B11002Ii3 = B11002I003
B11002Ii4 = B11002I004
B11002Ii5 = B11002I005
B11002Ii6 = B11002I006
B11002Ii7 = B11002I007
B11002Ii8 = B11002I008
B11002Ii9 = B11002I009
B11002Ii10 = B11002I010
B11002Ii11 = B11002I011
B11002Ii12 = B11002I012
B11002i1 = B11002001
B11002i2 = B11002002
B11002i3 = B11002003
B11002i4 = B11002004
B11002i5 = B11002005
B11002i6 = B11002006
B11002i7 = B11002007
B11002i8 = B11002008
B11002i9 = B11002009
B11002i10 = B11002010
B11002i11 = B11002011
B11002i12 = B11002012
B11003i1 = B11003001
B11003i2 = B11003002
B11003i3 = B11003003
B11003i4 = B11003004
B11003i5 = B11003005
B11003i6 = B11003006
B11003i7 = B11003007
B11003i8 = B11003008
B11003i9 = B11003009
B11003i10 = B11003010
B11003i11 = B11003011
B11003i12 = B11003012
B11003i13 = B11003013
B11003i14 = B11003014
B11003i15 = B11003015
B11003i16 = B11003016
B11003i17 = B11003017
B11003i18 = B11003018
B11003i19 = B11003019
B11003i20 = B11003020
B11004i1 = B11004001
B11004i2 = B11004002
B11004i3 = B11004003
B11004i4 = B11004004
B11004i5 = B11004005
B11004i6 = B11004006
B11004i7 = B11004007
B11004i8 = B11004008
B11004i9 = B11004009
B11004i10 = B11004010
B11004i11 = B11004011
B11004i12 = B11004012
B11004i13 = B11004013
B11004i14 = B11004014
B11004i15 = B11004015
B11004i16 = B11004016
B11004i17 = B11004017
B11004i18 = B11004018
B11004i19 = B11004019
B11004i20 = B11004020
B11005i1 = B11005001
B11005i2 = B11005002
B11005i3 = B11005003
B11005i4 = B11005004
B11005i5 = B11005005
B11005i6 = B11005006
B11005i7 = B11005007
B11005i8 = B11005008
B11005i9 = B11005009
B11005i10 = B11005010
B11005i11 = B11005011
B11005i12 = B11005012
B11005i13 = B11005013
B11005i14 = B11005014
B11005i15 = B11005015
B11005i16 = B11005016
B11005i17 = B11005017
B11005i18 = B11005018
B11005i19 = B11005019
B11006i1 = B11006001
B11006i2 = B11006002
B11006i3 = B11006003
B11006i4 = B11006004
B11006i5 = B11006005
B11006i6 = B11006006
B11006i7 = B11006007
B11006i8 = B11006008
B11006i9 = B11006009
B11006i10 = B11006010
B11006i11 = B11006011
B11006i12 = B11006012
B11006i13 = B11006013
B11006i14 = B11006014
B11006i15 = B11006015
B11007i1 = B11007001
B11007i2 = B11007002
B11007i3 = B11007003
B11007i4 = B11007004
B11007i5 = B11007005
B11007i6 = B11007006
B11007i7 = B11007007
B11007i8 = B11007008
B11007i9 = B11007009
B11007i10 = B11007010
B11007i11 = B11007011
B11015i1 = B11015001
B11015i2 = B11015002
B11015i3 = B11015003
B11016i1 = B11016001
B11016i2 = B11016002
B11016i3 = B11016003
B11016i4 = B11016004
B11016i5 = B11016005
B11016i6 = B11016006
B11016i7 = B11016007
B11016i8 = B11016008
B11016i9 = B11016009
B11016i10 = B11016010
B11016i11 = B11016011
B11016i12 = B11016012
B11016i13 = B11016013
B11016i14 = B11016014
B11016i15 = B11016015
B11016i16 = B11016016
B12001i1 = B12001001
B12001i2 = B12001002
B12001i3 = B12001003
B12001i4 = B12001004
B12001i5 = B12001005
B12001i6 = B12001006
B12001i7 = B12001007
B12001i8 = B12001008
B12001i9 = B12001009
B12001i10 = B12001010
B12001i11 = B12001011
B12001i12 = B12001012
B12001i13 = B12001013
B12001i14 = B12001014
B12001i15 = B12001015
B12001i16 = B12001016
B12001i17 = B12001017
B12001i18 = B12001018
B12001i19 = B12001019
B14002i1 = B14002001
B14002i2 = B14002002
B14002i3 = B14002003
B14002i4 = B14002004
B14002i5 = B14002005
B14002i6 = B14002006
B14002i7 = B14002007
B14002i8 = B14002008
B14002i9 = B14002009
B14002i10 = B14002010
B14002i11 = B14002011
B14002i12 = B14002012
B14002i13 = B14002013
B14002i14 = B14002014
B14002i15 = B14002015
B14002i16 = B14002016
B14002i17 = B14002017
B14002i18 = B14002018
B14002i19 = B14002019
B14002i20 = B14002020
B14002i21 = B14002021
B14002i22 = B14002022
B14002i23 = B14002023
B14002i24 = B14002024
B14002i25 = B14002025
B14002i26 = B14002026
B14002i27 = B14002027
B14002i28 = B14002028
B14002i29 = B14002029
B14002i30 = B14002030
B14002i31 = B14002031
B14002i32 = B14002032
B14002i33 = B14002033
B14002i34 = B14002034
B14002i35 = B14002035
B14002i36 = B14002036
B14002i37 = B14002037
B14002i38 = B14002038
B14002i39 = B14002039
B14002i40 = B14002040
B14002i41 = B14002041
B14002i42 = B14002042
B14002i43 = B14002043
B14002i44 = B14002044
B14002i45 = B14002045
B14002i46 = B14002046
B14002i47 = B14002047
B14002i48 = B14002048
B14002i49 = B14002049
B14005i1 = B14005001
B14005i2 = B14005002
B14005i3 = B14005003
B14005i4 = B14005004
B14005i5 = B14005005
B14005i6 = B14005006
B14005i7 = B14005007
B14005i8 = B14005008
B14005i9 = B14005009
B14005i10 = B14005010
B14005i11 = B14005011
B14005i12 = B14005012
B14005i13 = B14005013
B14005i14 = B14005014
B14005i15 = B14005015
B14005i16 = B14005016
B14005i17 = B14005017
B14005i18 = B14005018
B14005i19 = B14005019
B14005i20 = B14005020
B14005i21 = B14005021
B14005i22 = B14005022
B14005i23 = B14005023
B14005i24 = B14005024
B14005i25 = B14005025
B14005i26 = B14005026
B14005i27 = B14005027
B14005i28 = B14005028
B14005i29 = B14005029
B14007Ai1 = B14007A001
B14007Ai2 = B14007A002
B14007Ai3 = B14007A003
B14007Ai4 = B14007A004
B14007Ai5 = B14007A005
B14007Ai6 = B14007A006
B14007Ai7 = B14007A007
B14007Ai8 = B14007A008
B14007Ai9 = B14007A009
B14007Ai10 = B14007A010
B14007Ai11 = B14007A011
B14007Ai12 = B14007A012
B14007Ai13 = B14007A013
B14007Ai14 = B14007A014
B14007Ai15 = B14007A015
B14007Ai16 = B14007A016
B14007Ai17 = B14007A017
B14007Ai18 = B14007A018
B14007Ai19 = B14007A019
B14007Bi1 = B14007B001
B14007Bi2 = B14007B002
B14007Bi3 = B14007B003
B14007Bi4 = B14007B004
B14007Bi5 = B14007B005
B14007Bi6 = B14007B006
B14007Bi7 = B14007B007
B14007Bi8 = B14007B008
B14007Bi9 = B14007B009
B14007Bi10 = B14007B010
B14007Bi11 = B14007B011
B14007Bi12 = B14007B012
B14007Bi13 = B14007B013
B14007Bi14 = B14007B014
B14007Bi15 = B14007B015
B14007Bi16 = B14007B016
B14007Bi17 = B14007B017
B14007Bi18 = B14007B018
B14007Bi19 = B14007B019
B14007Ci1 = B14007C001
B14007Ci2 = B14007C002
B14007Ci3 = B14007C003
B14007Ci4 = B14007C004
B14007Ci5 = B14007C005
B14007Ci6 = B14007C006
B14007Ci7 = B14007C007
B14007Ci8 = B14007C008
B14007Ci9 = B14007C009
B14007Ci10 = B14007C010
B14007Ci11 = B14007C011
B14007Ci12 = B14007C012
B14007Ci13 = B14007C013
B14007Ci14 = B14007C014
B14007Ci15 = B14007C015
B14007Ci16 = B14007C016
B14007Ci17 = B14007C017
B14007Ci18 = B14007C018
B14007Ci19 = B14007C019
B14007Di1 = B14007D001
B14007Di2 = B14007D002
B14007Di3 = B14007D003
B14007Di4 = B14007D004
B14007Di5 = B14007D005
B14007Di6 = B14007D006
B14007Di7 = B14007D007
B14007Di8 = B14007D008
B14007Di9 = B14007D009
B14007Di10 = B14007D010
B14007Di11 = B14007D011
B14007Di12 = B14007D012
B14007Di13 = B14007D013
B14007Di14 = B14007D014
B14007Di15 = B14007D015
B14007Di16 = B14007D016
B14007Di17 = B14007D017
B14007Di18 = B14007D018
B14007Di19 = B14007D019
B14007Ei1 = B14007E001
B14007Ei2 = B14007E002
B14007Ei3 = B14007E003
B14007Ei4 = B14007E004
B14007Ei5 = B14007E005
B14007Ei6 = B14007E006
B14007Ei7 = B14007E007
B14007Ei8 = B14007E008
B14007Ei9 = B14007E009
B14007Ei10 = B14007E010
B14007Ei11 = B14007E011
B14007Ei12 = B14007E012
B14007Ei13 = B14007E013
B14007Ei14 = B14007E014
B14007Ei15 = B14007E015
B14007Ei16 = B14007E016
B14007Ei17 = B14007E017
B14007Ei18 = B14007E018
B14007Ei19 = B14007E019
B14007Fi1 = B14007F001
B14007Fi2 = B14007F002
B14007Fi3 = B14007F003
B14007Fi4 = B14007F004
B14007Fi5 = B14007F005
B14007Fi6 = B14007F006
B14007Fi7 = B14007F007
B14007Fi8 = B14007F008
B14007Fi9 = B14007F009
B14007Fi10 = B14007F010
B14007Fi11 = B14007F011
B14007Fi12 = B14007F012
B14007Fi13 = B14007F013
B14007Fi14 = B14007F014
B14007Fi15 = B14007F015
B14007Fi16 = B14007F016
B14007Fi17 = B14007F017
B14007Fi18 = B14007F018
B14007Fi19 = B14007F019
B14007Gi1 = B14007G001
B14007Gi2 = B14007G002
B14007Gi3 = B14007G003
B14007Gi4 = B14007G004
B14007Gi5 = B14007G005
B14007Gi6 = B14007G006
B14007Gi7 = B14007G007
B14007Gi8 = B14007G008
B14007Gi9 = B14007G009
B14007Gi10 = B14007G010
B14007Gi11 = B14007G011
B14007Gi12 = B14007G012
B14007Gi13 = B14007G013
B14007Gi14 = B14007G014
B14007Gi15 = B14007G015
B14007Gi16 = B14007G016
B14007Gi17 = B14007G017
B14007Gi18 = B14007G018
B14007Gi19 = B14007G019
B14007Hi1 = B14007H001
B14007Hi2 = B14007H002
B14007Hi3 = B14007H003
B14007Hi4 = B14007H004
B14007Hi5 = B14007H005
B14007Hi6 = B14007H006
B14007Hi7 = B14007H007
B14007Hi8 = B14007H008
B14007Hi9 = B14007H009
B14007Hi10 = B14007H010
B14007Hi11 = B14007H011
B14007Hi12 = B14007H012
B14007Hi13 = B14007H013
B14007Hi14 = B14007H014
B14007Hi15 = B14007H015
B14007Hi16 = B14007H016
B14007Hi17 = B14007H017
B14007Hi18 = B14007H018
B14007Hi19 = B14007H019
B14007Ii1 = B14007I001
B14007Ii2 = B14007I002
B14007Ii3 = B14007I003
B14007Ii4 = B14007I004
B14007Ii5 = B14007I005
B14007Ii6 = B14007I006
B14007Ii7 = B14007I007
B14007Ii8 = B14007I008
B14007Ii9 = B14007I009
B14007Ii10 = B14007I010
B14007Ii11 = B14007I011
B14007Ii12 = B14007I012
B14007Ii13 = B14007I013
B14007Ii14 = B14007I014
B14007Ii15 = B14007I015
B14007Ii16 = B14007I016
B14007Ii17 = B14007I017
B14007Ii18 = B14007I018
B14007Ii19 = B14007I019
B14007i1 = B14007001
B14007i2 = B14007002
B14007i3 = B14007003
B14007i4 = B14007004
B14007i5 = B14007005
B14007i6 = B14007006
B14007i7 = B14007007
B14007i8 = B14007008
B14007i9 = B14007009
B14007i10 = B14007010
B14007i11 = B14007011
B14007i12 = B14007012
B14007i13 = B14007013
B14007i14 = B14007014
B14007i15 = B14007015
B14007i16 = B14007016
B14007i17 = B14007017
B14007i18 = B14007018
B14007i19 = B14007019
B15002i1 = B15002001
B15002i2 = B15002002
B15002i3 = B15002003
B15002i4 = B15002004
B15002i5 = B15002005
B15002i6 = B15002006
B15002i7 = B15002007
B15002i8 = B15002008
B15002i9 = B15002009
B15002i10 = B15002010
B15002i11 = B15002011
B15002i12 = B15002012
B15002i13 = B15002013
B15002i14 = B15002014
B15002i15 = B15002015
B15002i16 = B15002016
B15002i17 = B15002017
B15002i18 = B15002018
B15002i19 = B15002019
B15002i20 = B15002020
B15002i21 = B15002021
B15002i22 = B15002022
B15002i23 = B15002023
B15002i24 = B15002024
B15002i25 = B15002025
B15002i26 = B15002026
B15002i27 = B15002027
B15002i28 = B15002028
B15002i29 = B15002029
B15002i30 = B15002030
B15002i31 = B15002031
B15002i32 = B15002032
B15002i33 = B15002033
B15002i34 = B15002034
B15002i35 = B15002035
B15003i1 = B15003001
B15003i2 = B15003002
B15003i3 = B15003003
B15003i4 = B15003004
B15003i5 = B15003005
B15003i6 = B15003006
B15003i7 = B15003007
B15003i8 = B15003008
B15003i9 = B15003009
B15003i10 = B15003010
B15003i11 = B15003011
B15003i12 = B15003012
B15003i13 = B15003013
B15003i14 = B15003014
B15003i15 = B15003015
B15003i16 = B15003016
B15003i17 = B15003017
B15003i18 = B15003018
B15003i19 = B15003019
B15003i20 = B15003020
B15003i21 = B15003021
B15003i22 = B15003022
B15003i23 = B15003023
B15003i24 = B15003024
B15003i25 = B15003025
B15011i1 = B15011001
B15011i2 = B15011002
B15011i3 = B15011003
B15011i4 = B15011004
B15011i5 = B15011005
B15011i6 = B15011006
B15011i7 = B15011007
B15011i8 = B15011008
B15011i9 = B15011009
B15011i10 = B15011010
B15011i11 = B15011011
B15011i12 = B15011012
B15011i13 = B15011013
B15011i14 = B15011014
B15011i15 = B15011015
B15011i16 = B15011016
B15011i17 = B15011017
B15011i18 = B15011018
B15011i19 = B15011019
B15011i20 = B15011020
B15011i21 = B15011021
B15011i22 = B15011022
B15011i23 = B15011023
B15011i24 = B15011024
B15011i25 = B15011025
B15011i26 = B15011026
B15011i27 = B15011027
B15011i28 = B15011028
B15011i29 = B15011029
B15011i30 = B15011030
B15011i31 = B15011031
B15011i32 = B15011032
B15011i33 = B15011033
B15011i34 = B15011034
B15011i35 = B15011035
B15011i36 = B15011036
B15011i37 = B15011037
B15011i38 = B15011038
B15011i39 = B15011039
B15012i1 = B15012001
B15012i2 = B15012002
B15012i3 = B15012003
B15012i4 = B15012004
B15012i5 = B15012005
B15012i6 = B15012006
B15012i7 = B15012007
B15012i8 = B15012008
B15012i9 = B15012009
B15012i10 = B15012010
B15012i11 = B15012011
B15012i12 = B15012012
B15012i13 = B15012013
B15012i14 = B15012014
B15012i15 = B15012015
B15012i16 = B15012016
B16004i1 = B16004001
B16004i2 = B16004002
B16004i3 = B16004003
B16004i4 = B16004004
B16004i5 = B16004005
B16004i6 = B16004006
B16004i7 = B16004007
B16004i8 = B16004008
B16004i9 = B16004009
B16004i10 = B16004010
B16004i11 = B16004011
B16004i12 = B16004012
B16004i13 = B16004013
B16004i14 = B16004014
B16004i15 = B16004015
B16004i16 = B16004016
B16004i17 = B16004017
B16004i18 = B16004018
B16004i19 = B16004019
B16004i20 = B16004020
B16004i21 = B16004021
B16004i22 = B16004022
B16004i23 = B16004023
B16004i24 = B16004024
B16004i25 = B16004025
B16004i26 = B16004026
B16004i27 = B16004027
B16004i28 = B16004028
B16004i29 = B16004029
B16004i30 = B16004030
B16004i31 = B16004031
B16004i32 = B16004032
B16004i33 = B16004033
B16004i34 = B16004034
B16004i35 = B16004035
B16004i36 = B16004036
B16004i37 = B16004037
B16004i38 = B16004038
B16004i39 = B16004039
B16004i40 = B16004040
B16004i41 = B16004041
B16004i42 = B16004042
B16004i43 = B16004043
B16004i44 = B16004044
B16004i45 = B16004045
B16004i46 = B16004046
B16004i47 = B16004047
B16004i48 = B16004048
B16004i49 = B16004049
B16004i50 = B16004050
B16004i51 = B16004051
B16004i52 = B16004052
B16004i53 = B16004053
B16004i54 = B16004054
B16004i55 = B16004055
B16004i56 = B16004056
B16004i57 = B16004057
B16004i58 = B16004058
B16004i59 = B16004059
B16004i60 = B16004060
B16004i61 = B16004061
B16004i62 = B16004062
B16004i63 = B16004063
B16004i64 = B16004064
B16004i65 = B16004065
B16004i66 = B16004066
B16004i67 = B16004067
C15010Ai1 = C15010A001
C15010Ai2 = C15010A002
C15010Ai3 = C15010A003
C15010Ai4 = C15010A004
C15010Ai5 = C15010A005
C15010Ai6 = C15010A006
C15010Bi1 = C15010B001
C15010Bi2 = C15010B002
C15010Bi3 = C15010B003
C15010Bi4 = C15010B004
C15010Bi5 = C15010B005
C15010Bi6 = C15010B006
C15010Ci1 = C15010C001
C15010Ci2 = C15010C002
C15010Ci3 = C15010C003
C15010Ci4 = C15010C004
C15010Ci5 = C15010C005
C15010Ci6 = C15010C006
C15010Di1 = C15010D001
C15010Di2 = C15010D002
C15010Di3 = C15010D003
C15010Di4 = C15010D004
C15010Di5 = C15010D005
C15010Di6 = C15010D006
C15010Ei1 = C15010E001
C15010Ei2 = C15010E002
C15010Ei3 = C15010E003
C15010Ei4 = C15010E004
C15010Ei5 = C15010E005
C15010Ei6 = C15010E006
C15010Fi1 = C15010F001
C15010Fi2 = C15010F002
C15010Fi3 = C15010F003
C15010Fi4 = C15010F004
C15010Fi5 = C15010F005
C15010Fi6 = C15010F006
C15010Gi1 = C15010G001
C15010Gi2 = C15010G002
C15010Gi3 = C15010G003
C15010Gi4 = C15010G004
C15010Gi5 = C15010G005
C15010Gi6 = C15010G006
C15010Hi1 = C15010H001
C15010Hi2 = C15010H002
C15010Hi3 = C15010H003
C15010Hi4 = C15010H004
C15010Hi5 = C15010H005
C15010Hi6 = C15010H006
C15010Ii1 = C15010I001
C15010Ii2 = C15010I002
C15010Ii3 = C15010I003
C15010Ii4 = C15010I004
C15010Ii5 = C15010I005
C15010Ii6 = C15010I006
C15010i1 = C15010001
C15010i2 = C15010002
C15010i3 = C15010003
C15010i4 = C15010004
C15010i5 = C15010005
C15010i6 = C15010006
C16002i1 = C16002001
C16002i2 = C16002002
C16002i3 = C16002003
C16002i4 = C16002004
C16002i5 = C16002005
C16002i6 = C16002006
C16002i7 = C16002007
C16002i8 = C16002008
C16002i9 = C16002009
C16002i10 = C16002010
C16002i11 = C16002011
C16002i12 = C16002012
C16002i13 = C16002013
C16002i14 = C16002014
B17010i1 = B17010001
B17010i2 = B17010002
B17010i3 = B17010003
B17010i4 = B17010004
B17010i5 = B17010005
B17010i6 = B17010006
B17010i7 = B17010007
B17010i8 = B17010008
B17010i9 = B17010009
B17010i10 = B17010010
B17010i11 = B17010011
B17010i12 = B17010012
B17010i13 = B17010013
B17010i14 = B17010014
B17010i15 = B17010015
B17010i16 = B17010016
B17010i17 = B17010017
B17010i18 = B17010018
B17010i19 = B17010019
B17010i20 = B17010020
B17010i21 = B17010021
B17010i22 = B17010022
B17010i23 = B17010023
B17010i24 = B17010024
B17010i25 = B17010025
B17010i26 = B17010026
B17010i27 = B17010027
B17010i28 = B17010028
B17010i29 = B17010029
B17010i30 = B17010030
B17010i31 = B17010031
B17010i32 = B17010032
B17010i33 = B17010033
B17010i34 = B17010034
B17010i35 = B17010035
B17010i36 = B17010036
B17010i37 = B17010037
B17010i38 = B17010038
B17010i39 = B17010039
B17010i40 = B17010040
B17010i41 = B17010041
B17017i1 = B17017001
B17017i2 = B17017002
B17017i3 = B17017003
B17017i4 = B17017004
B17017i5 = B17017005
B17017i6 = B17017006
B17017i7 = B17017007
B17017i8 = B17017008
B17017i9 = B17017009
B17017i10 = B17017010
B17017i11 = B17017011
B17017i12 = B17017012
B17017i13 = B17017013
B17017i14 = B17017014
B17017i15 = B17017015
B17017i16 = B17017016
B17017i17 = B17017017
B17017i18 = B17017018
B17017i19 = B17017019
B17017i20 = B17017020
B17017i21 = B17017021
B17017i22 = B17017022
B17017i23 = B17017023
B17017i24 = B17017024
B17017i25 = B17017025
B17017i26 = B17017026
B17017i27 = B17017027
B17017i28 = B17017028
B17017i29 = B17017029
B17017i30 = B17017030
B17017i31 = B17017031
B17017i32 = B17017032
B17017i33 = B17017033
B17017i34 = B17017034
B17017i35 = B17017035
B17017i36 = B17017036
B17017i37 = B17017037
B17017i38 = B17017038
B17017i39 = B17017039
B17017i40 = B17017040
B17017i41 = B17017041
B17017i42 = B17017042
B17017i43 = B17017043
B17017i44 = B17017044
B17017i45 = B17017045
B17017i46 = B17017046
B17017i47 = B17017047
B17017i48 = B17017048
B17017i49 = B17017049
B17017i50 = B17017050
B17017i51 = B17017051
B17017i52 = B17017052
B17017i53 = B17017053
B17017i54 = B17017054
B17017i55 = B17017055
B17017i56 = B17017056
B17017i57 = B17017057
B17017i58 = B17017058
B17017i59 = B17017059
B17021i1 = B17021001
B17021i2 = B17021002
B17021i3 = B17021003
B17021i4 = B17021004
B17021i5 = B17021005
B17021i6 = B17021006
B17021i7 = B17021007
B17021i8 = B17021008
B17021i9 = B17021009
B17021i10 = B17021010
B17021i11 = B17021011
B17021i12 = B17021012
B17021i13 = B17021013
B17021i14 = B17021014
B17021i15 = B17021015
B17021i16 = B17021016
B17021i17 = B17021017
B17021i18 = B17021018
B17021i19 = B17021019
B17021i20 = B17021020
B17021i21 = B17021021
B17021i22 = B17021022
B17021i23 = B17021023
B17021i24 = B17021024
B17021i25 = B17021025
B17021i26 = B17021026
B17021i27 = B17021027
B17021i28 = B17021028
B17021i29 = B17021029
B17021i30 = B17021030
B17021i31 = B17021031
B17021i32 = B17021032
B17021i33 = B17021033
B17021i34 = B17021034
B17021i35 = B17021035
B19001i1 = B19001001
B19001i2 = B19001002
B19001i3 = B19001003
B19001i4 = B19001004
B19001i5 = B19001005
B19001i6 = B19001006
B19001i7 = B19001007
B19001i8 = B19001008
B19001i9 = B19001009
B19001i10 = B19001010
B19001i11 = B19001011
B19001i12 = B19001012
B19001i13 = B19001013
B19001i14 = B19001014
B19001i15 = B19001015
B19001i16 = B19001016
B19001i17 = B19001017
B19013i1 = B19013001
B19025Ai1 = B19025A001
B19025Bi1 = B19025B001
B19025Hi1 = B19025H001
B19025i1 = B19025001
B19037i1 = B19037001
B19037i2 = B19037002
B19037i3 = B19037003
B19037i4 = B19037004
B19037i5 = B19037005
B19037i6 = B19037006
B19037i7 = B19037007
B19037i8 = B19037008
B19037i9 = B19037009
B19037i10 = B19037010
B19037i11 = B19037011
B19037i12 = B19037012
B19037i13 = B19037013
B19037i14 = B19037014
B19037i15 = B19037015
B19037i16 = B19037016
B19037i17 = B19037017
B19037i18 = B19037018
B19037i19 = B19037019
B19037i20 = B19037020
B19037i21 = B19037021
B19037i22 = B19037022
B19037i23 = B19037023
B19037i24 = B19037024
B19037i25 = B19037025
B19037i26 = B19037026
B19037i27 = B19037027
B19037i28 = B19037028
B19037i29 = B19037029
B19037i30 = B19037030
B19037i31 = B19037031
B19037i32 = B19037032
B19037i33 = B19037033
B19037i34 = B19037034
B19037i35 = B19037035
B19037i36 = B19037036
B19037i37 = B19037037
B19037i38 = B19037038
B19037i39 = B19037039
B19037i40 = B19037040
B19037i41 = B19037041
B19037i42 = B19037042
B19037i43 = B19037043
B19037i44 = B19037044
B19037i45 = B19037045
B19037i46 = B19037046
B19037i47 = B19037047
B19037i48 = B19037048
B19037i49 = B19037049
B19037i50 = B19037050
B19037i51 = B19037051
B19037i52 = B19037052
B19037i53 = B19037053
B19037i54 = B19037054
B19037i55 = B19037055
B19037i56 = B19037056
B19037i57 = B19037057
B19037i58 = B19037058
B19037i59 = B19037059
B19037i60 = B19037060
B19037i61 = B19037061
B19037i62 = B19037062
B19037i63 = B19037063
B19037i64 = B19037064
B19037i65 = B19037065
B19037i66 = B19037066
B19037i67 = B19037067
B19037i68 = B19037068
B19037i69 = B19037069
B19049i1 = B19049001
B19049i2 = B19049002
B19049i3 = B19049003
B19049i4 = B19049004
B19049i5 = B19049005
B19050i1 = B19050001
B19050i2 = B19050002
B19050i3 = B19050003
B19050i4 = B19050004
B19050i5 = B19050005
B19051i1 = B19051001
B19051i2 = B19051002
B19051i3 = B19051003
B19052i1 = B19052001
B19052i2 = B19052002
B19052i3 = B19052003
B19053i1 = B19053001
B19053i2 = B19053002
B19053i3 = B19053003
B19054i1 = B19054001
B19054i2 = B19054002
B19054i3 = B19054003
B19055i1 = B19055001
B19055i2 = B19055002
B19055i3 = B19055003
B19056i1 = B19056001
B19056i2 = B19056002
B19056i3 = B19056003
B19057i1 = B19057001
B19057i2 = B19057002
B19057i3 = B19057003
B19058i1 = B19058001
B19058i2 = B19058002
B19058i3 = B19058003
B19059i1 = B19059001
B19059i2 = B19059002
B19059i3 = B19059003
B19060i1 = B19060001
B19060i2 = B19060002
B19060i3 = B19060003
B19061i1 = B19061001
B19062i1 = B19062001
B19063i1 = B19063001
B19064i1 = B19064001
B19065i1 = B19065001
B19066i1 = B19066001
B19069i1 = B19069001
B19070i1 = B19070001
B19101i1 = B19101001
B19101i2 = B19101002
B19101i3 = B19101003
B19101i4 = B19101004
B19101i5 = B19101005
B19101i6 = B19101006
B19101i7 = B19101007
B19101i8 = B19101008
B19101i9 = B19101009
B19101i10 = B19101010
B19101i11 = B19101011
B19101i12 = B19101012
B19101i13 = B19101013
B19101i14 = B19101014
B19101i15 = B19101015
B19101i16 = B19101016
B19101i17 = B19101017
B19113i1 = B19113001
B19127i1 = B19127001
B19201i1 = B19201001
B19201i2 = B19201002
B19201i3 = B19201003
B19201i4 = B19201004
B19201i5 = B19201005
B19201i6 = B19201006
B19201i7 = B19201007
B19201i8 = B19201008
B19201i9 = B19201009
B19201i10 = B19201010
B19201i11 = B19201011
B19201i12 = B19201012
B19201i13 = B19201013
B19201i14 = B19201014
B19201i15 = B19201015
B19201i16 = B19201016
B19201i17 = B19201017
B19202i1 = B19202001
B19214i1 = B19214001
B19301Ai1 = B19301A001
B19301Bi1 = B19301B001
B19301Ci1 = B19301C001
B19301Fi1 = B19301F001
B19301Gi1 = B19301G001
B19301Hi1 = B19301H001
B19301Ii1 = B19301I001
B19301i1 = B19301001
B19313Ai1 = B19313A001
B19313Bi1 = B19313B001
B19313Ci1 = B19313C001
B19313Fi1 = B19313F001
B19313Gi1 = B19313G001
B19313Hi1 = B19313H001
B19313Ii1 = B19313I001
B19313i1 = B19313001
B20001i1 = B20001001
B20001i2 = B20001002
B20001i3 = B20001003
B20001i4 = B20001004
B20001i5 = B20001005
B20001i6 = B20001006
B20001i7 = B20001007
B20001i8 = B20001008
B20001i9 = B20001009
B20001i10 = B20001010
B20001i11 = B20001011
B20001i12 = B20001012
B20001i13 = B20001013
B20001i14 = B20001014
B20001i15 = B20001015
B20001i16 = B20001016
B20001i17 = B20001017
B20001i18 = B20001018
B20001i19 = B20001019
B20001i20 = B20001020
B20001i21 = B20001021
B20001i22 = B20001022
B20001i23 = B20001023
B20001i24 = B20001024
B20001i25 = B20001025
B20001i26 = B20001026
B20001i27 = B20001027
B20001i28 = B20001028
B20001i29 = B20001029
B20001i30 = B20001030
B20001i31 = B20001031
B20001i32 = B20001032
B20001i33 = B20001033
B20001i34 = B20001034
B20001i35 = B20001035
B20001i36 = B20001036
B20001i37 = B20001037
B20001i38 = B20001038
B20001i39 = B20001039
B20001i40 = B20001040
B20001i41 = B20001041
B20001i42 = B20001042
B20001i43 = B20001043
B20002i1 = B20002001
B20002i2 = B20002002
B20002i3 = B20002003
B20003i1 = B20003001
B20003i2 = B20003002
B20003i3 = B20003003
B20003i4 = B20003004
B20003i5 = B20003005
B20003i6 = B20003006
B20003i7 = B20003007
B20017i1 = B20017001
B20017i2 = B20017002
B20017i3 = B20017003
B20017i4 = B20017004
B20017i5 = B20017005
B20017i6 = B20017006
B20017i7 = B20017007
C17002i1 = C17002001
C17002i2 = C17002002
C17002i3 = C17002003
C17002i4 = C17002004
C17002i5 = C17002005
C17002i6 = C17002006
C17002i7 = C17002007
C17002i8 = C17002008
B21001i1 = B21001001
B21001i2 = B21001002
B21001i3 = B21001003
B21001i4 = B21001004
B21001i5 = B21001005
B21001i6 = B21001006
B21001i7 = B21001007
B21001i8 = B21001008
B21001i9 = B21001009
B21001i10 = B21001010
B21001i11 = B21001011
B21001i12 = B21001012
B21001i13 = B21001013
B21001i14 = B21001014
B21001i15 = B21001015
B21001i16 = B21001016
B21001i17 = B21001017
B21001i18 = B21001018
B21001i19 = B21001019
B21001i20 = B21001020
B21001i21 = B21001021
B21001i22 = B21001022
B21001i23 = B21001023
B21001i24 = B21001024
B21001i25 = B21001025
B21001i26 = B21001026
B21001i27 = B21001027
B21001i28 = B21001028
B21001i29 = B21001029
B21001i30 = B21001030
B21001i31 = B21001031
B21001i32 = B21001032
B21001i33 = B21001033
B21001i34 = B21001034
B21001i35 = B21001035
B21001i36 = B21001036
B21001i37 = B21001037
B21001i38 = B21001038
B21001i39 = B21001039
B21002i1 = B21002001
B21002i2 = B21002002
B21002i3 = B21002003
B21002i4 = B21002004
B21002i5 = B21002005
B21002i6 = B21002006
B21002i7 = B21002007
B21002i8 = B21002008
B21002i9 = B21002009
B21002i10 = B21002010
B21002i11 = B21002011
B21002i12 = B21002012
B21002i13 = B21002013
B21002i14 = B21002014
B21002i15 = B21002015
B21002i16 = B21002016
B22010i1 = B22010001
B22010i2 = B22010002
B22010i3 = B22010003
B22010i4 = B22010004
B22010i5 = B22010005
B22010i6 = B22010006
B22010i7 = B22010007
B23003i1 = B23003001
B23003i2 = B23003002
B23003i3 = B23003003
B23003i4 = B23003004
B23003i5 = B23003005
B23003i6 = B23003006
B23003i7 = B23003007
B23003i8 = B23003008
B23003i9 = B23003009
B23003i10 = B23003010
B23003i11 = B23003011
B23003i12 = B23003012
B23003i13 = B23003013
B23003i14 = B23003014
B23003i15 = B23003015
B23003i16 = B23003016
B23003i17 = B23003017
B23003i18 = B23003018
B23003i19 = B23003019
B23003i20 = B23003020
B23003i21 = B23003021
B23003i22 = B23003022
B23003i23 = B23003023
B23003i24 = B23003024
B23003i25 = B23003025
B23003i26 = B23003026
B23003i27 = B23003027
B23003i28 = B23003028
B23003i29 = B23003029
B23003i30 = B23003030
B23007i1 = B23007001
B23007i2 = B23007002
B23007i3 = B23007003
B23007i4 = B23007004
B23007i5 = B23007005
B23007i6 = B23007006
B23007i7 = B23007007
B23007i8 = B23007008
B23007i9 = B23007009
B23007i10 = B23007010
B23007i11 = B23007011
B23007i12 = B23007012
B23007i13 = B23007013
B23007i14 = B23007014
B23007i15 = B23007015
B23007i16 = B23007016
B23007i17 = B23007017
B23007i18 = B23007018
B23007i19 = B23007019
B23007i20 = B23007020
B23007i21 = B23007021
B23007i22 = B23007022
B23007i23 = B23007023
B23007i24 = B23007024
B23007i25 = B23007025
B23007i26 = B23007026
B23007i27 = B23007027
B23007i28 = B23007028
B23007i29 = B23007029
B23007i30 = B23007030
B23007i31 = B23007031
B23007i32 = B23007032
B23007i33 = B23007033
B23007i34 = B23007034
B23007i35 = B23007035
B23007i36 = B23007036
B23007i37 = B23007037
B23007i38 = B23007038
B23007i39 = B23007039
B23007i40 = B23007040
B23007i41 = B23007041
B23007i42 = B23007042
B23007i43 = B23007043
B23007i44 = B23007044
B23007i45 = B23007045
B23007i46 = B23007046
B23007i47 = B23007047
B23007i48 = B23007048
B23007i49 = B23007049
B23007i50 = B23007050
B23007i51 = B23007051
B23007i52 = B23007052
B23007i53 = B23007053
B23007i54 = B23007054
B23007i55 = B23007055
B23007i56 = B23007056
B23007i57 = B23007057
B23007i58 = B23007058
B23007i59 = B23007059
B23008i1 = B23008001
B23008i2 = B23008002
B23008i3 = B23008003
B23008i4 = B23008004
B23008i5 = B23008005
B23008i6 = B23008006
B23008i7 = B23008007
B23008i8 = B23008008
B23008i9 = B23008009
B23008i10 = B23008010
B23008i11 = B23008011
B23008i12 = B23008012
B23008i13 = B23008013
B23008i14 = B23008014
B23008i15 = B23008015
B23008i16 = B23008016
B23008i17 = B23008017
B23008i18 = B23008018
B23008i19 = B23008019
B23008i20 = B23008020
B23008i21 = B23008021
B23008i22 = B23008022
B23008i23 = B23008023
B23008i24 = B23008024
B23008i25 = B23008025
B23008i26 = B23008026
B23008i27 = B23008027
B23009i1 = B23009001
B23009i2 = B23009002
B23009i3 = B23009003
B23009i4 = B23009004
B23009i5 = B23009005
B23009i6 = B23009006
B23009i7 = B23009007
B23009i8 = B23009008
B23009i9 = B23009009
B23009i10 = B23009010
B23009i11 = B23009011
B23009i12 = B23009012
B23009i13 = B23009013
B23009i14 = B23009014
B23009i15 = B23009015
B23009i16 = B23009016
B23009i17 = B23009017
B23009i18 = B23009018
B23009i19 = B23009019
B23009i20 = B23009020
B23009i21 = B23009021
B23009i22 = B23009022
B23009i23 = B23009023
B23009i24 = B23009024
B23009i25 = B23009025
B23009i26 = B23009026
B23009i27 = B23009027
B23009i28 = B23009028
B23009i29 = B23009029
B23009i30 = B23009030
B23009i31 = B23009031
B23009i32 = B23009032
B23009i33 = B23009033
B23009i34 = B23009034
B23009i35 = B23009035
B23009i36 = B23009036
B23009i37 = B23009037
B23009i38 = B23009038
B23009i39 = B23009039
B23009i40 = B23009040
B23009i41 = B23009041
B23009i42 = B23009042
B23009i43 = B23009043
B23022i1 = B23022001
B23022i2 = B23022002
B23022i3 = B23022003
B23022i4 = B23022004
B23022i5 = B23022005
B23022i6 = B23022006
B23022i7 = B23022007
B23022i8 = B23022008
B23022i9 = B23022009
B23022i10 = B23022010
B23022i11 = B23022011
B23022i12 = B23022012
B23022i13 = B23022013
B23022i14 = B23022014
B23022i15 = B23022015
B23022i16 = B23022016
B23022i17 = B23022017
B23022i18 = B23022018
B23022i19 = B23022019
B23022i20 = B23022020
B23022i21 = B23022021
B23022i22 = B23022022
B23022i23 = B23022023
B23022i24 = B23022024
B23022i25 = B23022025
B23022i26 = B23022026
B23022i27 = B23022027
B23022i28 = B23022028
B23022i29 = B23022029
B23022i30 = B23022030
B23022i31 = B23022031
B23022i32 = B23022032
B23022i33 = B23022033
B23022i34 = B23022034
B23022i35 = B23022035
B23022i36 = B23022036
B23022i37 = B23022037
B23022i38 = B23022038
B23022i39 = B23022039
B23022i40 = B23022040
B23022i41 = B23022041
B23022i42 = B23022042
B23022i43 = B23022043
B23022i44 = B23022044
B23022i45 = B23022045
B23022i46 = B23022046
B23022i47 = B23022047
B23022i48 = B23022048
B23022i49 = B23022049
B23024i1 = B23024001
B23024i2 = B23024002
B23024i3 = B23024003
B23024i4 = B23024004
B23024i5 = B23024005
B23024i6 = B23024006
B23024i7 = B23024007
B23024i8 = B23024008
B23024i9 = B23024009
B23024i10 = B23024010
B23024i11 = B23024011
B23024i12 = B23024012
B23024i13 = B23024013
B23024i14 = B23024014
B23024i15 = B23024015
B23024i16 = B23024016
B23024i17 = B23024017
B23024i18 = B23024018
B23024i19 = B23024019
B23024i20 = B23024020
B23024i21 = B23024021
B23024i22 = B23024022
B23024i23 = B23024023
B23024i24 = B23024024
B23024i25 = B23024025
B23024i26 = B23024026
B23024i27 = B23024027
B23024i28 = B23024028
B23024i29 = B23024029
B23024i30 = B23024030
B23024i31 = B23024031
B23025i1 = B23025001
B23025i2 = B23025002
B23025i3 = B23025003
B23025i4 = B23025004
B23025i5 = B23025005
B23025i6 = B23025006
B23025i7 = B23025007
B23026i1 = B23026001
B23026i2 = B23026002
B23026i3 = B23026003
B23026i4 = B23026004
B23026i5 = B23026005
B23026i6 = B23026006
B23026i7 = B23026007
B23026i8 = B23026008
B23026i9 = B23026009
B23026i10 = B23026010
B23026i11 = B23026011
B23026i12 = B23026012
B23026i13 = B23026013
B23026i14 = B23026014
B23026i15 = B23026015
B23026i16 = B23026016
B23026i17 = B23026017
B23026i18 = B23026018
B23026i19 = B23026019
B23026i20 = B23026020
B23026i21 = B23026021
B23026i22 = B23026022
B23026i23 = B23026023
B23026i24 = B23026024
B23026i25 = B23026025
B23026i26 = B23026026
B23026i27 = B23026027
B23026i28 = B23026028
B23026i29 = B23026029
B23026i30 = B23026030
B23026i31 = B23026031
B23026i32 = B23026032
B23026i33 = B23026033
B23026i34 = B23026034
B23026i35 = B23026035
B23026i36 = B23026036
B23026i37 = B23026037
B23026i38 = B23026038
B23026i39 = B23026039
B23026i40 = B23026040
B23026i41 = B23026041
B23026i42 = B23026042
B23026i43 = B23026043
B23026i44 = B23026044
B23026i45 = B23026045
B23026i46 = B23026046
B23026i47 = B23026047
B23026i48 = B23026048
B23026i49 = B23026049
B23027i1 = B23027001
B23027i2 = B23027002
B23027i3 = B23027003
B23027i4 = B23027004
B23027i5 = B23027005
B23027i6 = B23027006
B23027i7 = B23027007
B23027i8 = B23027008
B23027i9 = B23027009
B23027i10 = B23027010
B23027i11 = B23027011
B23027i12 = B23027012
B23027i13 = B23027013
B23027i14 = B23027014
B23027i15 = B23027015
B23027i16 = B23027016
B23027i17 = B23027017
B23027i18 = B23027018
B23027i19 = B23027019
B23027i20 = B23027020
B23027i21 = B23027021
B23027i22 = B23027022
B23027i23 = B23027023
B23027i24 = B23027024
B23027i25 = B23027025
B23027i26 = B23027026
B23027i27 = B23027027
B23027i28 = B23027028
B23027i29 = B23027029
B23027i30 = B23027030
B23027i31 = B23027031
B23027i32 = B23027032
B23027i33 = B23027033
B23027i34 = B23027034
B23027i35 = B23027035
B23027i36 = B23027036
B24080i1 = B24080001
B24080i2 = B24080002
B24080i3 = B24080003
B24080i4 = B24080004
B24080i5 = B24080005
B24080i6 = B24080006
B24080i7 = B24080007
B24080i8 = B24080008
B24080i9 = B24080009
B24080i10 = B24080010
B24080i11 = B24080011
B24080i12 = B24080012
B24080i13 = B24080013
B24080i14 = B24080014
B24080i15 = B24080015
B24080i16 = B24080016
B24080i17 = B24080017
B24080i18 = B24080018
B24080i19 = B24080019
B24080i20 = B24080020
B24080i21 = B24080021
C21007i1 = C21007001
C21007i2 = C21007002
C21007i3 = C21007003
C21007i4 = C21007004
C21007i5 = C21007005
C21007i6 = C21007006
C21007i7 = C21007007
C21007i8 = C21007008
C21007i9 = C21007009
C21007i10 = C21007010
C21007i11 = C21007011
C21007i12 = C21007012
C21007i13 = C21007013
C21007i14 = C21007014
C21007i15 = C21007015
C21007i16 = C21007016
C21007i17 = C21007017
C21007i18 = C21007018
C21007i19 = C21007019
C21007i20 = C21007020
C21007i21 = C21007021
C21007i22 = C21007022
C21007i23 = C21007023
C21007i24 = C21007024
C21007i25 = C21007025
C21007i26 = C21007026
C21007i27 = C21007027
C21007i28 = C21007028
C21007i29 = C21007029
C21007i30 = C21007030
C21007i31 = C21007031
C24010Ai1 = C24010A001
C24010Ai2 = C24010A002
C24010Ai3 = C24010A003
C24010Ai4 = C24010A004
C24010Ai5 = C24010A005
C24010Ai6 = C24010A006
C24010Ai7 = C24010A007
C24010Ai8 = C24010A008
C24010Ai9 = C24010A009
C24010Ai10 = C24010A010
C24010Ai11 = C24010A011
C24010Ai12 = C24010A012
C24010Ai13 = C24010A013
C24010Bi1 = C24010B001
C24010Bi2 = C24010B002
C24010Bi3 = C24010B003
C24010Bi4 = C24010B004
C24010Bi5 = C24010B005
C24010Bi6 = C24010B006
C24010Bi7 = C24010B007
C24010Bi8 = C24010B008
C24010Bi9 = C24010B009
C24010Bi10 = C24010B010
C24010Bi11 = C24010B011
C24010Bi12 = C24010B012
C24010Bi13 = C24010B013
C24010Ci1 = C24010C001
C24010Ci2 = C24010C002
C24010Ci3 = C24010C003
C24010Ci4 = C24010C004
C24010Ci5 = C24010C005
C24010Ci6 = C24010C006
C24010Ci7 = C24010C007
C24010Ci8 = C24010C008
C24010Ci9 = C24010C009
C24010Ci10 = C24010C010
C24010Ci11 = C24010C011
C24010Ci12 = C24010C012
C24010Ci13 = C24010C013
C24010Di1 = C24010D001
C24010Di2 = C24010D002
C24010Di3 = C24010D003
C24010Di4 = C24010D004
C24010Di5 = C24010D005
C24010Di6 = C24010D006
C24010Di7 = C24010D007
C24010Di8 = C24010D008
C24010Di9 = C24010D009
C24010Di10 = C24010D010
C24010Di11 = C24010D011
C24010Di12 = C24010D012
C24010Di13 = C24010D013
C24010Ei1 = C24010E001
C24010Ei2 = C24010E002
C24010Ei3 = C24010E003
C24010Ei4 = C24010E004
C24010Ei5 = C24010E005
C24010Ei6 = C24010E006
C24010Ei7 = C24010E007
C24010Ei8 = C24010E008
C24010Ei9 = C24010E009
C24010Ei10 = C24010E010
C24010Ei11 = C24010E011
C24010Ei12 = C24010E012
C24010Ei13 = C24010E013
C24010Fi1 = C24010F001
C24010Fi2 = C24010F002
C24010Fi3 = C24010F003
C24010Fi4 = C24010F004
C24010Fi5 = C24010F005
C24010Fi6 = C24010F006
C24010Fi7 = C24010F007
C24010Fi8 = C24010F008
C24010Fi9 = C24010F009
C24010Fi10 = C24010F010
C24010Fi11 = C24010F011
C24010Fi12 = C24010F012
C24010Fi13 = C24010F013
C24010Gi1 = C24010G001
C24010Gi2 = C24010G002
C24010Gi3 = C24010G003
C24010Gi4 = C24010G004
C24010Gi5 = C24010G005
C24010Gi6 = C24010G006
C24010Gi7 = C24010G007
C24010Gi8 = C24010G008
C24010Gi9 = C24010G009
C24010Gi10 = C24010G010
C24010Gi11 = C24010G011
C24010Gi12 = C24010G012
C24010Gi13 = C24010G013
C24010Hi1 = C24010H001
C24010Hi2 = C24010H002
C24010Hi3 = C24010H003
C24010Hi4 = C24010H004
C24010Hi5 = C24010H005
C24010Hi6 = C24010H006
C24010Hi7 = C24010H007
C24010Hi8 = C24010H008
C24010Hi9 = C24010H009
C24010Hi10 = C24010H010
C24010Hi11 = C24010H011
C24010Hi12 = C24010H012
C24010Hi13 = C24010H013
C24010Ii1 = C24010I001
C24010Ii2 = C24010I002
C24010Ii3 = C24010I003
C24010Ii4 = C24010I004
C24010Ii5 = C24010I005
C24010Ii6 = C24010I006
C24010Ii7 = C24010I007
C24010Ii8 = C24010I008
C24010Ii9 = C24010I009
C24010Ii10 = C24010I010
C24010Ii11 = C24010I011
C24010Ii12 = C24010I012
C24010Ii13 = C24010I013
C24010i1 = C24010001
C24010i2 = C24010002
C24010i3 = C24010003
C24010i4 = C24010004
C24010i5 = C24010005
C24010i6 = C24010006
C24010i7 = C24010007
C24010i8 = C24010008
C24010i9 = C24010009
C24010i10 = C24010010
C24010i11 = C24010011
C24010i12 = C24010012
C24010i13 = C24010013
C24010i14 = C24010014
C24010i15 = C24010015
C24010i16 = C24010016
C24010i17 = C24010017
C24010i18 = C24010018
C24010i19 = C24010019
C24010i20 = C24010020
C24010i21 = C24010021
C24010i22 = C24010022
C24010i23 = C24010023
C24010i24 = C24010024
C24010i25 = C24010025
C24010i26 = C24010026
C24010i27 = C24010027
C24010i28 = C24010028
C24010i29 = C24010029
C24010i30 = C24010030
C24010i31 = C24010031
C24010i32 = C24010032
C24010i33 = C24010033
C24010i34 = C24010034
C24010i35 = C24010035
C24010i36 = C24010036
C24010i37 = C24010037
C24010i38 = C24010038
C24010i39 = C24010039
C24010i40 = C24010040
C24010i41 = C24010041
C24010i42 = C24010042
C24010i43 = C24010043
C24010i44 = C24010044
C24010i45 = C24010045
C24010i46 = C24010046
C24010i47 = C24010047
C24010i48 = C24010048
C24010i49 = C24010049
C24010i50 = C24010050
C24010i51 = C24010051
C24010i52 = C24010052
C24010i53 = C24010053
C24010i54 = C24010054
C24010i55 = C24010055
C24010i56 = C24010056
C24010i57 = C24010057
C24010i58 = C24010058
C24010i59 = C24010059
C24010i60 = C24010060
C24010i61 = C24010061
C24010i62 = C24010062
C24010i63 = C24010063
C24010i64 = C24010064
C24010i65 = C24010065
C24010i66 = C24010066
C24010i67 = C24010067
C24010i68 = C24010068
C24010i69 = C24010069
C24010i70 = C24010070
C24010i71 = C24010071
C24010i72 = C24010072
C24010i73 = C24010073
C24020i1 = C24020001
C24020i2 = C24020002
C24020i3 = C24020003
C24020i4 = C24020004
C24020i5 = C24020005
C24020i6 = C24020006
C24020i7 = C24020007
C24020i8 = C24020008
C24020i9 = C24020009
C24020i10 = C24020010
C24020i11 = C24020011
C24020i12 = C24020012
C24020i13 = C24020013
C24020i14 = C24020014
C24020i15 = C24020015
C24020i16 = C24020016
C24020i17 = C24020017
C24020i18 = C24020018
C24020i19 = C24020019
C24020i20 = C24020020
C24020i21 = C24020021
C24020i22 = C24020022
C24020i23 = C24020023
C24020i24 = C24020024
C24020i25 = C24020025
C24020i26 = C24020026
C24020i27 = C24020027
C24020i28 = C24020028
C24020i29 = C24020029
C24020i30 = C24020030
C24020i31 = C24020031
C24020i32 = C24020032
C24020i33 = C24020033
C24020i34 = C24020034
C24020i35 = C24020035
C24020i36 = C24020036
C24020i37 = C24020037
C24020i38 = C24020038
C24020i39 = C24020039
C24020i40 = C24020040
C24020i41 = C24020041
C24020i42 = C24020042
C24020i43 = C24020043
C24020i44 = C24020044
C24020i45 = C24020045
C24020i46 = C24020046
C24020i47 = C24020047
C24020i48 = C24020048
C24020i49 = C24020049
C24020i50 = C24020050
C24020i51 = C24020051
C24020i52 = C24020052
C24020i53 = C24020053
C24020i54 = C24020054
C24020i55 = C24020055
C24020i56 = C24020056
C24020i57 = C24020057
C24020i58 = C24020058
C24020i59 = C24020059
C24020i60 = C24020060
C24020i61 = C24020061
C24020i62 = C24020062
C24020i63 = C24020063
C24020i64 = C24020064
C24020i65 = C24020065
C24020i66 = C24020066
C24020i67 = C24020067
C24020i68 = C24020068
C24020i69 = C24020069
C24020i70 = C24020070
C24020i71 = C24020071
C24020i72 = C24020072
C24020i73 = C24020073
C24030i1 = C24030001
C24030i2 = C24030002
C24030i3 = C24030003
C24030i4 = C24030004
C24030i5 = C24030005
C24030i6 = C24030006
C24030i7 = C24030007
C24030i8 = C24030008
C24030i9 = C24030009
C24030i10 = C24030010
C24030i11 = C24030011
C24030i12 = C24030012
C24030i13 = C24030013
C24030i14 = C24030014
C24030i15 = C24030015
C24030i16 = C24030016
C24030i17 = C24030017
C24030i18 = C24030018
C24030i19 = C24030019
C24030i20 = C24030020
C24030i21 = C24030021
C24030i22 = C24030022
C24030i23 = C24030023
C24030i24 = C24030024
C24030i25 = C24030025
C24030i26 = C24030026
C24030i27 = C24030027
C24030i28 = C24030028
C24030i29 = C24030029
C24030i30 = C24030030
C24030i31 = C24030031
C24030i32 = C24030032
C24030i33 = C24030033
C24030i34 = C24030034
C24030i35 = C24030035
C24030i36 = C24030036
C24030i37 = C24030037
C24030i38 = C24030038
C24030i39 = C24030039
C24030i40 = C24030040
C24030i41 = C24030041
C24030i42 = C24030042
C24030i43 = C24030043
C24030i44 = C24030044
C24030i45 = C24030045
C24030i46 = C24030046
C24030i47 = C24030047
C24030i48 = C24030048
C24030i49 = C24030049
C24030i50 = C24030050
C24030i51 = C24030051
C24030i52 = C24030052
C24030i53 = C24030053
C24030i54 = C24030054
C24030i55 = C24030055
B25001i1 = B25001001
B25002i1 = B25002001
B25002i2 = B25002002
B25002i3 = B25002003
B25003Ai1 = B25003A001
B25003Ai2 = B25003A002
B25003Ai3 = B25003A003
B25003Bi1 = B25003B001
B25003Bi2 = B25003B002
B25003Bi3 = B25003B003
B25003Ci1 = B25003C001
B25003Ci2 = B25003C002
B25003Ci3 = B25003C003
B25003Di1 = B25003D001
B25003Di2 = B25003D002
B25003Di3 = B25003D003
B25003Ei1 = B25003E001
B25003Ei2 = B25003E002
B25003Ei3 = B25003E003
B25003Fi1 = B25003F001
B25003Fi2 = B25003F002
B25003Fi3 = B25003F003
B25003Gi1 = B25003G001
B25003Gi2 = B25003G002
B25003Gi3 = B25003G003
B25003Hi1 = B25003H001
B25003Hi2 = B25003H002
B25003Hi3 = B25003H003
B25003Ii1 = B25003I001
B25003Ii2 = B25003I002
B25003Ii3 = B25003I003
B25003i1 = B25003001
B25003i2 = B25003002
B25003i3 = B25003003
B25004i1 = B25004001
B25004i2 = B25004002
B25004i3 = B25004003
B25004i4 = B25004004
B25004i5 = B25004005
B25004i6 = B25004006
B25004i7 = B25004007
B25004i8 = B25004008
B25006i1 = B25006001
B25006i2 = B25006002
B25006i3 = B25006003
B25006i4 = B25006004
B25006i5 = B25006005
B25006i6 = B25006006
B25006i7 = B25006007
B25006i8 = B25006008
B25006i9 = B25006009
B25006i10 = B25006010
B25007i1 = B25007001
B25007i2 = B25007002
B25007i3 = B25007003
B25007i4 = B25007004
B25007i5 = B25007005
B25007i6 = B25007006
B25007i7 = B25007007
B25007i8 = B25007008
B25007i9 = B25007009
B25007i10 = B25007010
B25007i11 = B25007011
B25007i12 = B25007012
B25007i13 = B25007013
B25007i14 = B25007014
B25007i15 = B25007015
B25007i16 = B25007016
B25007i17 = B25007017
B25007i18 = B25007018
B25007i19 = B25007019
B25007i20 = B25007020
B25007i21 = B25007021
B25008i1 = B25008001
B25008i2 = B25008002
B25008i3 = B25008003
B25009i1 = B25009001
B25009i2 = B25009002
B25009i3 = B25009003
B25009i4 = B25009004
B25009i5 = B25009005
B25009i6 = B25009006
B25009i7 = B25009007
B25009i8 = B25009008
B25009i9 = B25009009
B25009i10 = B25009010
B25009i11 = B25009011
B25009i12 = B25009012
B25009i13 = B25009013
B25009i14 = B25009014
B25009i15 = B25009015
B25009i16 = B25009016
B25009i17 = B25009017
B25010i1 = B25010001
B25010i2 = B25010002
B25010i3 = B25010003
B25014i1 = B25014001
B25014i2 = B25014002
B25014i3 = B25014003
B25014i4 = B25014004
B25014i5 = B25014005
B25014i6 = B25014006
B25014i7 = B25014007
B25014i8 = B25014008
B25014i9 = B25014009
B25014i10 = B25014010
B25014i11 = B25014011
B25014i12 = B25014012
B25014i13 = B25014013
B25015i1 = B25015001
B25015i2 = B25015002
B25015i3 = B25015003
B25015i4 = B25015004
B25015i5 = B25015005
B25015i6 = B25015006
B25015i7 = B25015007
B25015i8 = B25015008
B25015i9 = B25015009
B25015i10 = B25015010
B25015i11 = B25015011
B25015i12 = B25015012
B25015i13 = B25015013
B25015i14 = B25015014
B25015i15 = B25015015
B25015i16 = B25015016
B25015i17 = B25015017
B25015i18 = B25015018
B25015i19 = B25015019
B25015i20 = B25015020
B25015i21 = B25015021
B25015i22 = B25015022
B25015i23 = B25015023
B25015i24 = B25015024
B25015i25 = B25015025
B25015i26 = B25015026
B25015i27 = B25015027
B25016i1 = B25016001
B25016i2 = B25016002
B25016i3 = B25016003
B25016i4 = B25016004
B25016i5 = B25016005
B25016i6 = B25016006
B25016i7 = B25016007
B25016i8 = B25016008
B25016i9 = B25016009
B25016i10 = B25016010
B25016i11 = B25016011
B25016i12 = B25016012
B25016i13 = B25016013
B25016i14 = B25016014
B25016i15 = B25016015
B25016i16 = B25016016
B25016i17 = B25016017
B25016i18 = B25016018
B25016i19 = B25016019
B25017i1 = B25017001
B25017i2 = B25017002
B25017i3 = B25017003
B25017i4 = B25017004
B25017i5 = B25017005
B25017i6 = B25017006
B25017i7 = B25017007
B25017i8 = B25017008
B25017i9 = B25017009
B25017i10 = B25017010
B25018i1 = B25018001
B25019i1 = B25019001
B25020i1 = B25020001
B25020i2 = B25020002
B25020i3 = B25020003
B25020i4 = B25020004
B25020i5 = B25020005
B25020i6 = B25020006
B25020i7 = B25020007
B25020i8 = B25020008
B25020i9 = B25020009
B25020i10 = B25020010
B25020i11 = B25020011
B25020i12 = B25020012
B25020i13 = B25020013
B25020i14 = B25020014
B25020i15 = B25020015
B25020i16 = B25020016
B25020i17 = B25020017
B25020i18 = B25020018
B25020i19 = B25020019
B25020i20 = B25020020
B25020i21 = B25020021
B25021i1 = B25021001
B25021i2 = B25021002
B25021i3 = B25021003
B25022i1 = B25022001
B25022i2 = B25022002
B25022i3 = B25022003
B25024i1 = B25024001
B25024i2 = B25024002
B25024i3 = B25024003
B25024i4 = B25024004
B25024i5 = B25024005
B25024i6 = B25024006
B25024i7 = B25024007
B25024i8 = B25024008
B25024i9 = B25024009
B25024i10 = B25024010
B25024i11 = B25024011
B25032i1 = B25032001
B25032i2 = B25032002
B25032i3 = B25032003
B25032i4 = B25032004
B25032i5 = B25032005
B25032i6 = B25032006
B25032i7 = B25032007
B25032i8 = B25032008
B25032i9 = B25032009
B25032i10 = B25032010
B25032i11 = B25032011
B25032i12 = B25032012
B25032i13 = B25032013
B25032i14 = B25032014
B25032i15 = B25032015
B25032i16 = B25032016
B25032i17 = B25032017
B25032i18 = B25032018
B25032i19 = B25032019
B25032i20 = B25032020
B25032i21 = B25032021
B25032i22 = B25032022
B25032i23 = B25032023
B25033i1 = B25033001
B25033i2 = B25033002
B25033i3 = B25033003
B25033i4 = B25033004
B25033i5 = B25033005
B25033i6 = B25033006
B25033i7 = B25033007
B25033i8 = B25033008
B25033i9 = B25033009
B25033i10 = B25033010
B25033i11 = B25033011
B25033i12 = B25033012
B25033i13 = B25033013
B25034i1 = B25034001
B25034i2 = B25034002
B25034i3 = B25034003
B25034i4 = B25034004
B25034i5 = B25034005
B25034i6 = B25034006
B25034i7 = B25034007
B25034i8 = B25034008
B25034i9 = B25034009
B25034i10 = B25034010
B25034i11 = B25034011
B25035i1 = B25035001
B25036i1 = B25036001
B25036i2 = B25036002
B25036i3 = B25036003
B25036i4 = B25036004
B25036i5 = B25036005
B25036i6 = B25036006
B25036i7 = B25036007
B25036i8 = B25036008
B25036i9 = B25036009
B25036i10 = B25036010
B25036i11 = B25036011
B25036i12 = B25036012
B25036i13 = B25036013
B25036i14 = B25036014
B25036i15 = B25036015
B25036i16 = B25036016
B25036i17 = B25036017
B25036i18 = B25036018
B25036i19 = B25036019
B25036i20 = B25036020
B25036i21 = B25036021
B25036i22 = B25036022
B25036i23 = B25036023
B25037i1 = B25037001
B25037i2 = B25037002
B25037i3 = B25037003
B25038i1 = B25038001
B25038i2 = B25038002
B25038i3 = B25038003
B25038i4 = B25038004
B25038i5 = B25038005
B25038i6 = B25038006
B25038i7 = B25038007
B25038i8 = B25038008
B25038i9 = B25038009
B25038i10 = B25038010
B25038i11 = B25038011
B25038i12 = B25038012
B25038i13 = B25038013
B25038i14 = B25038014
B25038i15 = B25038015
B25039i1 = B25039001
B25039i2 = B25039002
B25039i3 = B25039003
B25040i1 = B25040001
B25040i2 = B25040002
B25040i3 = B25040003
B25040i4 = B25040004
B25040i5 = B25040005
B25040i6 = B25040006
B25040i7 = B25040007
B25040i8 = B25040008
B25040i9 = B25040009
B25040i10 = B25040010
B25041i1 = B25041001
B25041i2 = B25041002
B25041i3 = B25041003
B25041i4 = B25041004
B25041i5 = B25041005
B25041i6 = B25041006
B25041i7 = B25041007
B25042i1 = B25042001
B25042i2 = B25042002
B25042i3 = B25042003
B25042i4 = B25042004
B25042i5 = B25042005
B25042i6 = B25042006
B25042i7 = B25042007
B25042i8 = B25042008
B25042i9 = B25042009
B25042i10 = B25042010
B25042i11 = B25042011
B25042i12 = B25042012
B25042i13 = B25042013
B25042i14 = B25042014
B25042i15 = B25042015
B25043i1 = B25043001
B25043i2 = B25043002
B25043i3 = B25043003
B25043i4 = B25043004
B25043i5 = B25043005
B25043i6 = B25043006
B25043i7 = B25043007
B25043i8 = B25043008
B25043i9 = B25043009
B25043i10 = B25043010
B25043i11 = B25043011
B25043i12 = B25043012
B25043i13 = B25043013
B25043i14 = B25043014
B25043i15 = B25043015
B25043i16 = B25043016
B25043i17 = B25043017
B25043i18 = B25043018
B25043i19 = B25043019
B25044i1 = B25044001
B25044i2 = B25044002
B25044i3 = B25044003
B25044i4 = B25044004
B25044i5 = B25044005
B25044i6 = B25044006
B25044i7 = B25044007
B25044i8 = B25044008
B25044i9 = B25044009
B25044i10 = B25044010
B25044i11 = B25044011
B25044i12 = B25044012
B25044i13 = B25044013
B25044i14 = B25044014
B25044i15 = B25044015
B25045i1 = B25045001
B25045i2 = B25045002
B25045i3 = B25045003
B25045i4 = B25045004
B25045i5 = B25045005
B25045i6 = B25045006
B25045i7 = B25045007
B25045i8 = B25045008
B25045i9 = B25045009
B25045i10 = B25045010
B25045i11 = B25045011
B25045i12 = B25045012
B25045i13 = B25045013
B25045i14 = B25045014
B25045i15 = B25045015
B25045i16 = B25045016
B25045i17 = B25045017
B25045i18 = B25045018
B25045i19 = B25045019
B25046i1 = B25046001
B25046i2 = B25046002
B25046i3 = B25046003
B25047i1 = B25047001
B25047i2 = B25047002
B25047i3 = B25047003
B25049i1 = B25049001
B25049i2 = B25049002
B25049i3 = B25049003
B25049i4 = B25049004
B25049i5 = B25049005
B25049i6 = B25049006
B25049i7 = B25049007
B25050i1 = B25050001
B25050i2 = B25050002
B25050i3 = B25050003
B25050i4 = B25050004
B25050i5 = B25050005
B25050i6 = B25050006
B25050i7 = B25050007
B25050i8 = B25050008
B25050i9 = B25050009
B25050i10 = B25050010
B25050i11 = B25050011
B25050i12 = B25050012
B25050i13 = B25050013
B25050i14 = B25050014
B25050i15 = B25050015
B25050i16 = B25050016
B25050i17 = B25050017
B25050i18 = B25050018
B25050i19 = B25050019
B25051i1 = B25051001
B25051i2 = B25051002
B25051i3 = B25051003
B25053i1 = B25053001
B25053i2 = B25053002
B25053i3 = B25053003
B25053i4 = B25053004
B25053i5 = B25053005
B25053i6 = B25053006
B25053i7 = B25053007
B25054i1 = B25054001
B25054i2 = B25054002
B25054i3 = B25054003
B25054i4 = B25054004
B25054i5 = B25054005
B25054i6 = B25054006
B25054i7 = B25054007
B25055i1 = B25055001
B25055i2 = B25055002
B25055i3 = B25055003
B25055i4 = B25055004
B25055i5 = B25055005
B25055i6 = B25055006
B25055i7 = B25055007
B25055i8 = B25055008
B25055i9 = B25055009
B25055i10 = B25055010
B25055i11 = B25055011
B25055i12 = B25055012
B25055i13 = B25055013
B25056i1 = B25056001
B25056i2 = B25056002
B25056i3 = B25056003
B25056i4 = B25056004
B25056i5 = B25056005
B25056i6 = B25056006
B25056i7 = B25056007
B25056i8 = B25056008
B25056i9 = B25056009
B25056i10 = B25056010
B25056i11 = B25056011
B25056i12 = B25056012
B25056i13 = B25056013
B25056i14 = B25056014
B25056i15 = B25056015
B25056i16 = B25056016
B25056i17 = B25056017
B25056i18 = B25056018
B25056i19 = B25056019
B25056i20 = B25056020
B25056i21 = B25056021
B25056i22 = B25056022
B25056i23 = B25056023
B25056i24 = B25056024
B25056i25 = B25056025
B25056i26 = B25056026
B25056i27 = B25056027
B25057i1 = B25057001
B25058i1 = B25058001
B25059i1 = B25059001
B25060i1 = B25060001
B25061i1 = B25061001
B25061i2 = B25061002
B25061i3 = B25061003
B25061i4 = B25061004
B25061i5 = B25061005
B25061i6 = B25061006
B25061i7 = B25061007
B25061i8 = B25061008
B25061i9 = B25061009
B25061i10 = B25061010
B25061i11 = B25061011
B25061i12 = B25061012
B25061i13 = B25061013
B25061i14 = B25061014
B25061i15 = B25061015
B25061i16 = B25061016
B25061i17 = B25061017
B25061i18 = B25061018
B25061i19 = B25061019
B25061i20 = B25061020
B25061i21 = B25061021
B25061i22 = B25061022
B25061i23 = B25061023
B25061i24 = B25061024
B25061i25 = B25061025
B25062i1 = B25062001
B25063i1 = B25063001
B25063i2 = B25063002
B25063i3 = B25063003
B25063i4 = B25063004
B25063i5 = B25063005
B25063i6 = B25063006
B25063i7 = B25063007
B25063i8 = B25063008
B25063i9 = B25063009
B25063i10 = B25063010
B25063i11 = B25063011
B25063i12 = B25063012
B25063i13 = B25063013
B25063i14 = B25063014
B25063i15 = B25063015
B25063i16 = B25063016
B25063i17 = B25063017
B25063i18 = B25063018
B25063i19 = B25063019
B25063i20 = B25063020
B25063i21 = B25063021
B25063i22 = B25063022
B25063i23 = B25063023
B25063i24 = B25063024
B25063i25 = B25063025
B25063i26 = B25063026
B25063i27 = B25063027
B25064i1 = B25064001
B25065i1 = B25065001
B25066i1 = B25066001
B25066i2 = B25066002
B25066i3 = B25066003
B25066i4 = B25066004
B25066i5 = B25066005
B25066i6 = B25066006
B25066i7 = B25066007
B25066i8 = B25066008
B25067i1 = B25067001
B25067i2 = B25067002
B25067i3 = B25067003
B25068i1 = B25068001
B25068i2 = B25068002
B25068i3 = B25068003
B25068i4 = B25068004
B25068i5 = B25068005
B25068i6 = B25068006
B25068i7 = B25068007
B25068i8 = B25068008
B25068i9 = B25068009
B25068i10 = B25068010
B25068i11 = B25068011
B25068i12 = B25068012
B25068i13 = B25068013
B25068i14 = B25068014
B25068i15 = B25068015
B25068i16 = B25068016
B25068i17 = B25068017
B25068i18 = B25068018
B25068i19 = B25068019
B25068i20 = B25068020
B25068i21 = B25068021
B25068i22 = B25068022
B25068i23 = B25068023
B25068i24 = B25068024
B25068i25 = B25068025
B25068i26 = B25068026
B25068i27 = B25068027
B25068i28 = B25068028
B25068i29 = B25068029
B25068i30 = B25068030
B25068i31 = B25068031
B25068i32 = B25068032
B25068i33 = B25068033
B25068i34 = B25068034
B25068i35 = B25068035
B25068i36 = B25068036
B25068i37 = B25068037
B25069i1 = B25069001
B25069i2 = B25069002
B25069i3 = B25069003
B25070i1 = B25070001
B25070i2 = B25070002
B25070i3 = B25070003
B25070i4 = B25070004
B25070i5 = B25070005
B25070i6 = B25070006
B25070i7 = B25070007
B25070i8 = B25070008
B25070i9 = B25070009
B25070i10 = B25070010
B25070i11 = B25070011
B25071i1 = B25071001
B25072i1 = B25072001
B25072i2 = B25072002
B25072i3 = B25072003
B25072i4 = B25072004
B25072i5 = B25072005
B25072i6 = B25072006
B25072i7 = B25072007
B25072i8 = B25072008
B25072i9 = B25072009
B25072i10 = B25072010
B25072i11 = B25072011
B25072i12 = B25072012
B25072i13 = B25072013
B25072i14 = B25072014
B25072i15 = B25072015
B25072i16 = B25072016
B25072i17 = B25072017
B25072i18 = B25072018
B25072i19 = B25072019
B25072i20 = B25072020
B25072i21 = B25072021
B25072i22 = B25072022
B25072i23 = B25072023
B25072i24 = B25072024
B25072i25 = B25072025
B25072i26 = B25072026
B25072i27 = B25072027
B25072i28 = B25072028
B25072i29 = B25072029
B25074i1 = B25074001
B25074i2 = B25074002
B25074i3 = B25074003
B25074i4 = B25074004
B25074i5 = B25074005
B25074i6 = B25074006
B25074i7 = B25074007
B25074i8 = B25074008
B25074i9 = B25074009
B25074i10 = B25074010
B25074i11 = B25074011
B25074i12 = B25074012
B25074i13 = B25074013
B25074i14 = B25074014
B25074i15 = B25074015
B25074i16 = B25074016
B25074i17 = B25074017
B25074i18 = B25074018
B25074i19 = B25074019
B25074i20 = B25074020
B25074i21 = B25074021
B25074i22 = B25074022
B25074i23 = B25074023
B25074i24 = B25074024
B25074i25 = B25074025
B25074i26 = B25074026
B25074i27 = B25074027
B25074i28 = B25074028
B25074i29 = B25074029
B25074i30 = B25074030
B25074i31 = B25074031
B25074i32 = B25074032
B25074i33 = B25074033
B25074i34 = B25074034
B25074i35 = B25074035
B25074i36 = B25074036
B25074i37 = B25074037
B25074i38 = B25074038
B25074i39 = B25074039
B25074i40 = B25074040
B25074i41 = B25074041
B25074i42 = B25074042
B25074i43 = B25074043
B25074i44 = B25074044
B25074i45 = B25074045
B25074i46 = B25074046
B25074i47 = B25074047
B25074i48 = B25074048
B25074i49 = B25074049
B25074i50 = B25074050
B25074i51 = B25074051
B25074i52 = B25074052
B25074i53 = B25074053
B25074i54 = B25074054
B25074i55 = B25074055
B25074i56 = B25074056
B25074i57 = B25074057
B25074i58 = B25074058
B25074i59 = B25074059
B25074i60 = B25074060
B25074i61 = B25074061
B25074i62 = B25074062
B25074i63 = B25074063
B25074i64 = B25074064
B25075i1 = B25075001
B25075i2 = B25075002
B25075i3 = B25075003
B25075i4 = B25075004
B25075i5 = B25075005
B25075i6 = B25075006
B25075i7 = B25075007
B25075i8 = B25075008
B25075i9 = B25075009
B25075i10 = B25075010
B25075i11 = B25075011
B25075i12 = B25075012
B25075i13 = B25075013
B25075i14 = B25075014
B25075i15 = B25075015
B25075i16 = B25075016
B25075i17 = B25075017
B25075i18 = B25075018
B25075i19 = B25075019
B25075i20 = B25075020
B25075i21 = B25075021
B25075i22 = B25075022
B25075i23 = B25075023
B25075i24 = B25075024
B25075i25 = B25075025
B25075i26 = B25075026
B25075i27 = B25075027
B25076i1 = B25076001
B25077i1 = B25077001
B25078i1 = B25078001
B25079i1 = B25079001
B25079i2 = B25079002
B25079i3 = B25079003
B25079i4 = B25079004
B25079i5 = B25079005
B25080i1 = B25080001
B25080i2 = B25080002
B25080i3 = B25080003
B25080i4 = B25080004
B25080i5 = B25080005
B25080i6 = B25080006
B25080i7 = B25080007
B25080i8 = B25080008
B25081i1 = B25081001
B25081i2 = B25081002
B25081i3 = B25081003
B25081i4 = B25081004
B25081i5 = B25081005
B25081i6 = B25081006
B25081i7 = B25081007
B25081i8 = B25081008
B25082i1 = B25082001
B25082i2 = B25082002
B25082i3 = B25082003
B25083i1 = B25083001
B25085i1 = B25085001
B25085i2 = B25085002
B25085i3 = B25085003
B25085i4 = B25085004
B25085i5 = B25085005
B25085i6 = B25085006
B25085i7 = B25085007
B25085i8 = B25085008
B25085i9 = B25085009
B25085i10 = B25085010
B25085i11 = B25085011
B25085i12 = B25085012
B25085i13 = B25085013
B25085i14 = B25085014
B25085i15 = B25085015
B25085i16 = B25085016
B25085i17 = B25085017
B25085i18 = B25085018
B25085i19 = B25085019
B25085i20 = B25085020
B25085i21 = B25085021
B25085i22 = B25085022
B25085i23 = B25085023
B25085i24 = B25085024
B25085i25 = B25085025
B25085i26 = B25085026
B25085i27 = B25085027
B25087i1 = B25087001
B25087i2 = B25087002
B25087i3 = B25087003
B25087i4 = B25087004
B25087i5 = B25087005
B25087i6 = B25087006
B25087i7 = B25087007
B25087i8 = B25087008
B25087i9 = B25087009
B25087i10 = B25087010
B25087i11 = B25087011
B25087i12 = B25087012
B25087i13 = B25087013
B25087i14 = B25087014
B25087i15 = B25087015
B25087i16 = B25087016
B25087i17 = B25087017
B25087i18 = B25087018
B25087i19 = B25087019
B25087i20 = B25087020
B25087i21 = B25087021
B25087i22 = B25087022
B25087i23 = B25087023
B25087i24 = B25087024
B25087i25 = B25087025
B25087i26 = B25087026
B25087i27 = B25087027
B25087i28 = B25087028
B25087i29 = B25087029
B25087i30 = B25087030
B25087i31 = B25087031
B25087i32 = B25087032
B25087i33 = B25087033
B25087i34 = B25087034
B25087i35 = B25087035
B25087i36 = B25087036
B25087i37 = B25087037
B25087i38 = B25087038
B25087i39 = B25087039
B25088i1 = B25088001
B25088i2 = B25088002
B25088i3 = B25088003
B25089i1 = B25089001
B25089i2 = B25089002
B25089i3 = B25089003
B25091i1 = B25091001
B25091i2 = B25091002
B25091i3 = B25091003
B25091i4 = B25091004
B25091i5 = B25091005
B25091i6 = B25091006
B25091i7 = B25091007
B25091i8 = B25091008
B25091i9 = B25091009
B25091i10 = B25091010
B25091i11 = B25091011
B25091i12 = B25091012
B25091i13 = B25091013
B25091i14 = B25091014
B25091i15 = B25091015
B25091i16 = B25091016
B25091i17 = B25091017
B25091i18 = B25091018
B25091i19 = B25091019
B25091i20 = B25091020
B25091i21 = B25091021
B25091i22 = B25091022
B25091i23 = B25091023
B25092i1 = B25092001
B25092i2 = B25092002
B25092i3 = B25092003
B25093i1 = B25093001
B25093i2 = B25093002
B25093i3 = B25093003
B25093i4 = B25093004
B25093i5 = B25093005
B25093i6 = B25093006
B25093i7 = B25093007
B25093i8 = B25093008
B25093i9 = B25093009
B25093i10 = B25093010
B25093i11 = B25093011
B25093i12 = B25093012
B25093i13 = B25093013
B25093i14 = B25093014
B25093i15 = B25093015
B25093i16 = B25093016
B25093i17 = B25093017
B25093i18 = B25093018
B25093i19 = B25093019
B25093i20 = B25093020
B25093i21 = B25093021
B25093i22 = B25093022
B25093i23 = B25093023
B25093i24 = B25093024
B25093i25 = B25093025
B25093i26 = B25093026
B25093i27 = B25093027
B25093i28 = B25093028
B25093i29 = B25093029
B27010i1 = B27010001
B27010i2 = B27010002
B27010i3 = B27010003
B27010i4 = B27010004
B27010i5 = B27010005
B27010i6 = B27010006
B27010i7 = B27010007
B27010i8 = B27010008
B27010i9 = B27010009
B27010i10 = B27010010
B27010i11 = B27010011
B27010i12 = B27010012
B27010i13 = B27010013
B27010i14 = B27010014
B27010i15 = B27010015
B27010i16 = B27010016
B27010i17 = B27010017
B27010i18 = B27010018
B27010i19 = B27010019
B27010i20 = B27010020
B27010i21 = B27010021
B27010i22 = B27010022
B27010i23 = B27010023
B27010i24 = B27010024
B27010i25 = B27010025
B27010i26 = B27010026
B27010i27 = B27010027
B27010i28 = B27010028
B27010i29 = B27010029
B27010i30 = B27010030
B27010i31 = B27010031
B27010i32 = B27010032
B27010i33 = B27010033
B27010i34 = B27010034
B27010i35 = B27010035
B27010i36 = B27010036
B27010i37 = B27010037
B27010i38 = B27010038
B27010i39 = B27010039
B27010i40 = B27010040
B27010i41 = B27010041
B27010i42 = B27010042
B27010i43 = B27010043
B27010i44 = B27010044
B27010i45 = B27010045
B27010i46 = B27010046
B27010i47 = B27010047
B27010i48 = B27010048
B27010i49 = B27010049
B27010i50 = B27010050
B27010i51 = B27010051
B27010i52 = B27010052
B27010i53 = B27010053
B27010i54 = B27010054
B27010i55 = B27010055
B27010i56 = B27010056
B27010i57 = B27010057
B27010i58 = B27010058
B27010i59 = B27010059
B27010i60 = B27010060
B27010i61 = B27010061
B27010i62 = B27010062
B27010i63 = B27010063
B27010i64 = B27010064
B27010i65 = B27010065
B27010i66 = B27010066
B28001i1 = B28001001
B28001i2 = B28001002
B28001i3 = B28001003
B28001i4 = B28001004
B28001i5 = B28001005
B28001i6 = B28001006
B28001i7 = B28001007
B28001i8 = B28001008
B28001i9 = B28001009
B28001i10 = B28001010
B28001i11 = B28001011
B28002i1 = B28002001
B28002i2 = B28002002
B28002i3 = B28002003
B28002i4 = B28002004
B28002i5 = B28002005
B28002i6 = B28002006
B28002i7 = B28002007
B28002i8 = B28002008
B28002i9 = B28002009
B28002i10 = B28002010
B28002i11 = B28002011
B28002i12 = B28002012
B28002i13 = B28002013
B28003i1 = B28003001
B28003i2 = B28003002
B28003i3 = B28003003
B28003i4 = B28003004
B28003i5 = B28003005
B28003i6 = B28003006
B28004i1 = B28004001
B28004i2 = B28004002
B28004i3 = B28004003
B28004i4 = B28004004
B28004i5 = B28004005
B28004i6 = B28004006
B28004i7 = B28004007
B28004i8 = B28004008
B28004i9 = B28004009
B28004i10 = B28004010
B28004i11 = B28004011
B28004i12 = B28004012
B28004i13 = B28004013
B28004i14 = B28004014
B28004i15 = B28004015
B28004i16 = B28004016
B28004i17 = B28004017
B28004i18 = B28004018
B28004i19 = B28004019
B28004i20 = B28004020
B28004i21 = B28004021
B28004i22 = B28004022
B28004i23 = B28004023
B28004i24 = B28004024
B28004i25 = B28004025
B28005i1 = B28005001
B28005i2 = B28005002
B28005i3 = B28005003
B28005i4 = B28005004
B28005i5 = B28005005
B28005i6 = B28005006
B28005i7 = B28005007
B28005i8 = B28005008
B28005i9 = B28005009
B28005i10 = B28005010
B28005i11 = B28005011
B28005i12 = B28005012
B28005i13 = B28005013
B28005i14 = B28005014
B28005i15 = B28005015
B28005i16 = B28005016
B28005i17 = B28005017
B28005i18 = B28005018
B28005i19 = B28005019
B28006i1 = B28006001
B28006i2 = B28006002
B28006i3 = B28006003
B28006i4 = B28006004
B28006i5 = B28006005
B28006i6 = B28006006
B28006i7 = B28006007
B28006i8 = B28006008
B28006i9 = B28006009
B28006i10 = B28006010
B28006i11 = B28006011
B28006i12 = B28006012
B28006i13 = B28006013
B28006i14 = B28006014
B28006i15 = B28006015
B28006i16 = B28006016
B28006i17 = B28006017
B28006i18 = B28006018
B28006i19 = B28006019
B28007i1 = B28007001
B28007i2 = B28007002
B28007i3 = B28007003
B28007i4 = B28007004
B28007i5 = B28007005
B28007i6 = B28007006
B28007i7 = B28007007
B28007i8 = B28007008
B28007i9 = B28007009
B28007i10 = B28007010
B28007i11 = B28007011
B28007i12 = B28007012
B28007i13 = B28007013
B28007i14 = B28007014
B28007i15 = B28007015
B28007i16 = B28007016
B28007i17 = B28007017
B28007i18 = B28007018
B28007i19 = B28007019
B28007i20 = B28007020
B28008i1 = B28008001
B28008i2 = B28008002
B28008i3 = B28008003
B28008i4 = B28008004
B28008i5 = B28008005
B28008i6 = B28008006
B28008i7 = B28008007
B28008i8 = B28008008
B28008i9 = B28008009
B28008i10 = B28008010
B28009Ai1 = B28009A001
B28009Ai2 = B28009A002
B28009Ai3 = B28009A003
B28009Ai4 = B28009A004
B28009Ai5 = B28009A005
B28009Ai6 = B28009A006
B28009Bi1 = B28009B001
B28009Bi2 = B28009B002
B28009Bi3 = B28009B003
B28009Bi4 = B28009B004
B28009Bi5 = B28009B005
B28009Bi6 = B28009B006
B28009Ci1 = B28009C001
B28009Ci2 = B28009C002
B28009Ci3 = B28009C003
B28009Ci4 = B28009C004
B28009Ci5 = B28009C005
B28009Ci6 = B28009C006
B28009Di1 = B28009D001
B28009Di2 = B28009D002
B28009Di3 = B28009D003
B28009Di4 = B28009D004
B28009Di5 = B28009D005
B28009Di6 = B28009D006
B28009Ei1 = B28009E001
B28009Ei2 = B28009E002
B28009Ei3 = B28009E003
B28009Ei4 = B28009E004
B28009Ei5 = B28009E005
B28009Ei6 = B28009E006
B28009Fi1 = B28009F001
B28009Fi2 = B28009F002
B28009Fi3 = B28009F003
B28009Fi4 = B28009F004
B28009Fi5 = B28009F005
B28009Fi6 = B28009F006
B28009Gi1 = B28009G001
B28009Gi2 = B28009G002
B28009Gi3 = B28009G003
B28009Gi4 = B28009G004
B28009Gi5 = B28009G005
B28009Gi6 = B28009G006
B28009Hi1 = B28009H001
B28009Hi2 = B28009H002
B28009Hi3 = B28009H003
B28009Hi4 = B28009H004
B28009Hi5 = B28009H005
B28009Hi6 = B28009H006
B28009Ii1 = B28009I001
B28009Ii2 = B28009I002
B28009Ii3 = B28009I003
B28009Ii4 = B28009I004
B28009Ii5 = B28009I005
B28009Ii6 = B28009I006
B28010i1 = B28010001
B28010i2 = B28010002
B28010i3 = B28010003
B28010i4 = B28010004
B28010i5 = B28010005
B28010i6 = B28010006
B28010i7 = B28010007
B28011i1 = B28011001
B28011i2 = B28011002
B28011i3 = B28011003
B28011i4 = B28011004
B28011i5 = B28011005
B28011i6 = B28011006
B28011i7 = B28011007
B28011i8 = B28011008
B19083m1 = B19083001s
B07003m1 = B07003001s
B07003m4 = B07003004s
B01001m1 = B01001001s
B01001m2 = B01001002s
B01001m3 = B01001003s
B01001m4 = B01001004s
B01001m5 = B01001005s
B01001m6 = B01001006s
B01001m7 = B01001007s
B01001m8 = B01001008s
B01001m9 = B01001009s
B01001m10 = B01001010s
B01001m11 = B01001011s
B01001m12 = B01001012s
B01001m13 = B01001013s
B01001m14 = B01001014s
B01001m15 = B01001015s
B01001m16 = B01001016s
B01001m17 = B01001017s
B01001m18 = B01001018s
B01001m19 = B01001019s
B01001m20 = B01001020s
B01001m21 = B01001021s
B01001m22 = B01001022s
B01001m23 = B01001023s
B01001m24 = B01001024s
B01001m25 = B01001025s
B01001m26 = B01001026s
B01001m27 = B01001027s
B01001m28 = B01001028s
B01001m29 = B01001029s
B01001m30 = B01001030s
B01001m31 = B01001031s
B01001m32 = B01001032s
B01001m33 = B01001033s
B01001m34 = B01001034s
B01001m35 = B01001035s
B01001m36 = B01001036s
B01001m37 = B01001037s
B01001m38 = B01001038s
B01001m39 = B01001039s
B01001m40 = B01001040s
B01001m41 = B01001041s
B01001m42 = B01001042s
B01001m43 = B01001043s
B01001m44 = B01001044s
B01001m45 = B01001045s
B01001m46 = B01001046s
B01001m47 = B01001047s
B01001m48 = B01001048s
B01001m49 = B01001049s
B01002Am1 = B01002A001s
B01002Am2 = B01002A002s
B01002Am3 = B01002A003s
B01002Bm1 = B01002B001s
B01002Bm2 = B01002B002s
B01002Bm3 = B01002B003s
B01002Cm1 = B01002C001s
B01002Cm2 = B01002C002s
B01002Cm3 = B01002C003s
B01002Dm1 = B01002D001s
B01002Dm2 = B01002D002s
B01002Dm3 = B01002D003s
B01002Fm1 = B01002F001s
B01002Fm2 = B01002F002s
B01002Fm3 = B01002F003s
B01002Gm1 = B01002G001s
B01002Gm2 = B01002G002s
B01002Gm3 = B01002G003s
B01002Hm1 = B01002H001s
B01002Hm2 = B01002H002s
B01002Hm3 = B01002H003s
B01002Im1 = B01002I001s
B01002Im2 = B01002I002s
B01002Im3 = B01002I003s
B01002m1 = B01002001s
B01002m2 = B01002002s
B01002m3 = B01002003s
B01003m1 = B01003001s
B02001m1 = B02001001s
B02001m2 = B02001002s
B02001m3 = B02001003s
B02001m4 = B02001004s
B02001m5 = B02001005s
B02001m6 = B02001006s
B02001m7 = B02001007s
B02001m8 = B02001008s
B02001m9 = B02001009s
B02001m10 = B02001010s
B02008m1 = B02008001s
B02009m1 = B02009001s
B02010m1 = B02010001s
B02011m1 = B02011001s
B02012m1 = B02012001s
B02013m1 = B02013001s
B03002m1 = B03002001s
B03002m2 = B03002002s
B03002m3 = B03002003s
B03002m4 = B03002004s
B03002m5 = B03002005s
B03002m6 = B03002006s
B03002m7 = B03002007s
B03002m8 = B03002008s
B03002m9 = B03002009s
B03002m10 = B03002010s
B03002m11 = B03002011s
B03002m12 = B03002012s
B03002m13 = B03002013s
B03002m14 = B03002014s
B03002m15 = B03002015s
B03002m16 = B03002016s
B03002m17 = B03002017s
B03002m18 = B03002018s
B03002m19 = B03002019s
B03002m20 = B03002020s
B03002m21 = B03002021s
B03003m1 = B03003001s
B03003m2 = B03003002s
B03003m3 = B03003003s
B07201m1 = B07201001s
B07201m2 = B07201002s
B07201m3 = B07201003s
B07201m4 = B07201004s
B07201m5 = B07201005s
B07201m6 = B07201006s
B07201m7 = B07201007s
B07201m8 = B07201008s
B07201m9 = B07201009s
B07201m10 = B07201010s
B07201m11 = B07201011s
B07201m12 = B07201012s
B07201m13 = B07201013s
B07201m14 = B07201014s
B07202m1 = B07202001s
B07202m2 = B07202002s
B07202m3 = B07202003s
B07202m4 = B07202004s
B07202m5 = B07202005s
B07202m6 = B07202006s
B07202m7 = B07202007s
B07202m8 = B07202008s
B07202m9 = B07202009s
B07202m10 = B07202010s
B07202m11 = B07202011s
B07202m12 = B07202012s
B07202m13 = B07202013s
B07202m14 = B07202014s
B07203m1 = B07203001s
B07203m2 = B07203002s
B07203m3 = B07203003s
B07203m4 = B07203004s
B07203m5 = B07203005s
B07203m6 = B07203006s
B07203m7 = B07203007s
B07203m8 = B07203008s
B07203m9 = B07203009s
B07203m10 = B07203010s
B07203m11 = B07203011s
C02003m1 = C02003001s
C02003m2 = C02003002s
C02003m3 = C02003003s
C02003m4 = C02003004s
C02003m5 = C02003005s
C02003m6 = C02003006s
C02003m7 = C02003007s
C02003m8 = C02003008s
C02003m9 = C02003009s
C02003m10 = C02003010s
C02003m11 = C02003011s
C02003m12 = C02003012s
C02003m13 = C02003013s
C02003m14 = C02003014s
C02003m15 = C02003015s
C02003m16 = C02003016s
C02003m17 = C02003017s
C02003m18 = C02003018s
C02003m19 = C02003019s
B08007m1 = B08007001s
B08007m2 = B08007002s
B08007m3 = B08007003s
B08007m4 = B08007004s
B08007m5 = B08007005s
B08007m6 = B08007006s
B08007m7 = B08007007s
B08007m8 = B08007008s
B08007m9 = B08007009s
B08007m10 = B08007010s
B08007m11 = B08007011s
B08007m12 = B08007012s
B08007m13 = B08007013s
B08007m14 = B08007014s
B08007m15 = B08007015s
B08008m1 = B08008001s
B08008m2 = B08008002s
B08008m3 = B08008003s
B08008m4 = B08008004s
B08008m5 = B08008005s
B08008m6 = B08008006s
B08008m7 = B08008007s
B08008m8 = B08008008s
B08008m9 = B08008009s
B08008m10 = B08008010s
B08008m11 = B08008011s
B08008m12 = B08008012s
B08008m13 = B08008013s
B08008m14 = B08008014s
B08008m15 = B08008015s
B08009m1 = B08009001s
B08009m2 = B08009002s
B08009m3 = B08009003s
B08009m4 = B08009004s
B08009m5 = B08009005s
B08009m6 = B08009006s
B08009m7 = B08009007s
B08009m8 = B08009008s
B08009m9 = B08009009s
B08009m10 = B08009010s
B08009m11 = B08009011s
B08009m12 = B08009012s
B08009m13 = B08009013s
B08009m14 = B08009014s
B08009m15 = B08009015s
B08016m1 = B08016001s
B08016m2 = B08016002s
B08016m3 = B08016003s
B08016m4 = B08016004s
B08016m5 = B08016005s
B08016m6 = B08016006s
B08016m7 = B08016007s
B08016m8 = B08016008s
B08016m9 = B08016009s
B08016m10 = B08016010s
B08016m11 = B08016011s
B08016m12 = B08016012s
B08016m13 = B08016013s
B08016m14 = B08016014s
B08016m15 = B08016015s
B08016m16 = B08016016s
B08016m17 = B08016017s
B08016m18 = B08016018s
B08016m19 = B08016019s
B08016m20 = B08016020s
B08016m21 = B08016021s
B08016m22 = B08016022s
B08016m23 = B08016023s
B08017m1 = B08017001s
B08017m2 = B08017002s
B08017m3 = B08017003s
B08017m4 = B08017004s
B08017m5 = B08017005s
B08017m6 = B08017006s
B08017m7 = B08017007s
B08017m8 = B08017008s
B08017m9 = B08017009s
B08017m10 = B08017010s
B08017m11 = B08017011s
B08017m12 = B08017012s
B08017m13 = B08017013s
B08017m14 = B08017014s
B08017m15 = B08017015s
B08017m16 = B08017016s
B08017m17 = B08017017s
B08017m18 = B08017018s
B08017m19 = B08017019s
B08017m20 = B08017020s
B08017m21 = B08017021s
B08017m22 = B08017022s
B08017m23 = B08017023s
B08018m1 = B08018001s
B08018m2 = B08018002s
B08018m3 = B08018003s
B08018m4 = B08018004s
B08018m5 = B08018005s
B08018m6 = B08018006s
B08018m7 = B08018007s
B08018m8 = B08018008s
B08134m1 = B08134001s
B08134m2 = B08134002s
B08134m3 = B08134003s
B08134m4 = B08134004s
B08134m5 = B08134005s
B08134m6 = B08134006s
B08134m7 = B08134007s
B08134m8 = B08134008s
B08134m9 = B08134009s
B08134m10 = B08134010s
B08134m11 = B08134011s
B08134m12 = B08134012s
B08134m13 = B08134013s
B08134m14 = B08134014s
B08134m15 = B08134015s
B08134m16 = B08134016s
B08134m17 = B08134017s
B08134m18 = B08134018s
B08134m19 = B08134019s
B08134m20 = B08134020s
B08134m21 = B08134021s
B08134m22 = B08134022s
B08134m23 = B08134023s
B08134m24 = B08134024s
B08134m25 = B08134025s
B08134m26 = B08134026s
B08134m27 = B08134027s
B08134m28 = B08134028s
B08134m29 = B08134029s
B08134m30 = B08134030s
B08134m31 = B08134031s
B08134m32 = B08134032s
B08134m33 = B08134033s
B08134m34 = B08134034s
B08134m35 = B08134035s
B08134m36 = B08134036s
B08134m37 = B08134037s
B08134m38 = B08134038s
B08134m39 = B08134039s
B08134m40 = B08134040s
B08134m41 = B08134041s
B08134m42 = B08134042s
B08134m43 = B08134043s
B08134m44 = B08134044s
B08134m45 = B08134045s
B08134m46 = B08134046s
B08134m47 = B08134047s
B08134m48 = B08134048s
B08134m49 = B08134049s
B08134m50 = B08134050s
B08134m51 = B08134051s
B08134m52 = B08134052s
B08134m53 = B08134053s
B08134m54 = B08134054s
B08134m55 = B08134055s
B08134m56 = B08134056s
B08134m57 = B08134057s
B08134m58 = B08134058s
B08134m59 = B08134059s
B08134m60 = B08134060s
B08134m61 = B08134061s
B08134m62 = B08134062s
B08134m63 = B08134063s
B08134m64 = B08134064s
B08134m65 = B08134065s
B08134m66 = B08134066s
B08134m67 = B08134067s
B08134m68 = B08134068s
B08134m69 = B08134069s
B08134m70 = B08134070s
B08134m71 = B08134071s
B08134m72 = B08134072s
B08134m73 = B08134073s
B08134m74 = B08134074s
B08134m75 = B08134075s
B08134m76 = B08134076s
B08134m77 = B08134077s
B08134m78 = B08134078s
B08134m79 = B08134079s
B08134m80 = B08134080s
B08134m81 = B08134081s
B08134m82 = B08134082s
B08134m83 = B08134083s
B08134m84 = B08134084s
B08134m85 = B08134085s
B08134m86 = B08134086s
B08134m87 = B08134087s
B08134m88 = B08134088s
B08134m89 = B08134089s
B08134m90 = B08134090s
B08134m91 = B08134091s
B08134m92 = B08134092s
B08134m93 = B08134093s
B08134m94 = B08134094s
B08134m95 = B08134095s
B08134m96 = B08134096s
B08134m97 = B08134097s
B08134m98 = B08134098s
B08134m99 = B08134099s
B08134m100 = B081340100s
B08134m101 = B081340101s
B08134m102 = B081340102s
B08134m103 = B081340103s
B08134m104 = B081340104s
B08134m105 = B081340105s
B08134m106 = B081340106s
B08134m107 = B081340107s
B08134m108 = B081340108s
B08134m109 = B081340109s
B08134m110 = B081340110s
B08134m111 = B081340111s
B08134m112 = B081340112s
B08134m113 = B081340113s
B08134m114 = B081340114s
B08134m115 = B081340115s
B08134m116 = B081340116s
B08134m117 = B081340117s
B08134m118 = B081340118s
B08134m119 = B081340119s
B08134m120 = B081340120s
B08135m1 = B08135001s
B08135m2 = B08135002s
B08135m3 = B08135003s
B08135m4 = B08135004s
B08135m5 = B08135005s
B08135m6 = B08135006s
B08135m7 = B08135007s
B08135m8 = B08135008s
B08135m9 = B08135009s
B08135m10 = B08135010s
B08136m1 = B08136001s
B08136m2 = B08136002s
B08136m3 = B08136003s
B08136m4 = B08136004s
B08136m5 = B08136005s
B08136m6 = B08136006s
B08136m7 = B08136007s
B08136m8 = B08136008s
B08136m9 = B08136009s
B08136m10 = B08136010s
B08136m11 = B08136011s
B08136m12 = B08136012s
B08301m1 = B08301001s
B08301m2 = B08301002s
B08301m3 = B08301003s
B08301m4 = B08301004s
B08301m5 = B08301005s
B08301m6 = B08301006s
B08301m7 = B08301007s
B08301m8 = B08301008s
B08301m9 = B08301009s
B08301m10 = B08301010s
B08301m11 = B08301011s
B08301m12 = B08301012s
B08301m13 = B08301013s
B08301m14 = B08301014s
B08301m15 = B08301015s
B08301m16 = B08301016s
B08301m17 = B08301017s
B08301m18 = B08301018s
B08301m19 = B08301019s
B08301m20 = B08301020s
B08301m21 = B08301021s
B08302m1 = B08302001s
B08302m2 = B08302002s
B08302m3 = B08302003s
B08302m4 = B08302004s
B08302m5 = B08302005s
B08302m6 = B08302006s
B08302m7 = B08302007s
B08302m8 = B08302008s
B08302m9 = B08302009s
B08302m10 = B08302010s
B08302m11 = B08302011s
B08302m12 = B08302012s
B08302m13 = B08302013s
B08302m14 = B08302014s
B08302m15 = B08302015s
B08303m1 = B08303001s
B08303m2 = B08303002s
B08303m3 = B08303003s
B08303m4 = B08303004s
B08303m5 = B08303005s
B08303m6 = B08303006s
B08303m7 = B08303007s
B08303m8 = B08303008s
B08303m9 = B08303009s
B08303m10 = B08303010s
B08303m11 = B08303011s
B08303m12 = B08303012s
B08303m13 = B08303013s
B09002m1 = B09002001s
B09002m2 = B09002002s
B09002m3 = B09002003s
B09002m4 = B09002004s
B09002m5 = B09002005s
B09002m6 = B09002006s
B09002m7 = B09002007s
B09002m8 = B09002008s
B09002m9 = B09002009s
B09002m10 = B09002010s
B09002m11 = B09002011s
B09002m12 = B09002012s
B09002m13 = B09002013s
B09002m14 = B09002014s
B09002m15 = B09002015s
B09002m16 = B09002016s
B09002m17 = B09002017s
B09002m18 = B09002018s
B09002m19 = B09002019s
B09002m20 = B09002020s
B09018m1 = B09018001s
B09018m2 = B09018002s
B09018m3 = B09018003s
B09018m4 = B09018004s
B09018m5 = B09018005s
B09018m6 = B09018006s
B09018m7 = B09018007s
B09018m8 = B09018008s
B09019m1 = B09019001s
B09019m2 = B09019002s
B09019m3 = B09019003s
B09019m4 = B09019004s
B09019m5 = B09019005s
B09019m6 = B09019006s
B09019m7 = B09019007s
B09019m8 = B09019008s
B09019m9 = B09019009s
B09019m10 = B09019010s
B09019m11 = B09019011s
B09019m12 = B09019012s
B09019m13 = B09019013s
B09019m14 = B09019014s
B09019m15 = B09019015s
B09019m16 = B09019016s
B09019m17 = B09019017s
B09019m18 = B09019018s
B09019m19 = B09019019s
B09019m20 = B09019020s
B09019m21 = B09019021s
B09019m22 = B09019022s
B09019m23 = B09019023s
B09019m24 = B09019024s
B09019m25 = B09019025s
B09019m26 = B09019026s
B09020m1 = B09020001s
B09020m2 = B09020002s
B09020m3 = B09020003s
B09020m4 = B09020004s
B09020m5 = B09020005s
B09020m6 = B09020006s
B09020m7 = B09020007s
B09020m8 = B09020008s
B09020m9 = B09020009s
B09020m10 = B09020010s
B09020m11 = B09020011s
B09020m12 = B09020012s
B09020m13 = B09020013s
B09020m14 = B09020014s
B09020m15 = B09020015s
B09020m16 = B09020016s
B09020m17 = B09020017s
B09020m18 = B09020018s
B09020m19 = B09020019s
B09020m20 = B09020020s
B09020m21 = B09020021s
B09021m1 = B09021001s
B09021m2 = B09021002s
B09021m3 = B09021003s
B09021m4 = B09021004s
B09021m5 = B09021005s
B09021m6 = B09021006s
B09021m7 = B09021007s
B09021m8 = B09021008s
B09021m9 = B09021009s
B09021m10 = B09021010s
B09021m11 = B09021011s
B09021m12 = B09021012s
B09021m13 = B09021013s
B09021m14 = B09021014s
B09021m15 = B09021015s
B09021m16 = B09021016s
B09021m17 = B09021017s
B09021m18 = B09021018s
B09021m19 = B09021019s
B09021m20 = B09021020s
B09021m21 = B09021021s
B09021m22 = B09021022s
B09021m23 = B09021023s
B09021m24 = B09021024s
B09021m25 = B09021025s
B09021m26 = B09021026s
B09021m27 = B09021027s
B09021m28 = B09021028s
B11001Am1 = B11001A001s
B11001Am2 = B11001A002s
B11001Am3 = B11001A003s
B11001Am4 = B11001A004s
B11001Am5 = B11001A005s
B11001Am6 = B11001A006s
B11001Am7 = B11001A007s
B11001Am8 = B11001A008s
B11001Am9 = B11001A009s
B11001Bm1 = B11001B001s
B11001Bm2 = B11001B002s
B11001Bm3 = B11001B003s
B11001Bm4 = B11001B004s
B11001Bm5 = B11001B005s
B11001Bm6 = B11001B006s
B11001Bm7 = B11001B007s
B11001Bm8 = B11001B008s
B11001Bm9 = B11001B009s
B11001Cm1 = B11001C001s
B11001Cm2 = B11001C002s
B11001Cm3 = B11001C003s
B11001Cm4 = B11001C004s
B11001Cm5 = B11001C005s
B11001Cm6 = B11001C006s
B11001Cm7 = B11001C007s
B11001Cm8 = B11001C008s
B11001Cm9 = B11001C009s
B11001Dm1 = B11001D001s
B11001Dm2 = B11001D002s
B11001Dm3 = B11001D003s
B11001Dm4 = B11001D004s
B11001Dm5 = B11001D005s
B11001Dm6 = B11001D006s
B11001Dm7 = B11001D007s
B11001Dm8 = B11001D008s
B11001Dm9 = B11001D009s
B11001Em1 = B11001E001s
B11001Em2 = B11001E002s
B11001Em3 = B11001E003s
B11001Em4 = B11001E004s
B11001Em5 = B11001E005s
B11001Em6 = B11001E006s
B11001Em7 = B11001E007s
B11001Em8 = B11001E008s
B11001Em9 = B11001E009s
B11001Fm1 = B11001F001s
B11001Fm2 = B11001F002s
B11001Fm3 = B11001F003s
B11001Fm4 = B11001F004s
B11001Fm5 = B11001F005s
B11001Fm6 = B11001F006s
B11001Fm7 = B11001F007s
B11001Fm8 = B11001F008s
B11001Fm9 = B11001F009s
B11001Gm1 = B11001G001s
B11001Gm2 = B11001G002s
B11001Gm3 = B11001G003s
B11001Gm4 = B11001G004s
B11001Gm5 = B11001G005s
B11001Gm6 = B11001G006s
B11001Gm7 = B11001G007s
B11001Gm8 = B11001G008s
B11001Gm9 = B11001G009s
B11001Hm1 = B11001H001s
B11001Hm2 = B11001H002s
B11001Hm3 = B11001H003s
B11001Hm4 = B11001H004s
B11001Hm5 = B11001H005s
B11001Hm6 = B11001H006s
B11001Hm7 = B11001H007s
B11001Hm8 = B11001H008s
B11001Hm9 = B11001H009s
B11001Im1 = B11001I001s
B11001Im2 = B11001I002s
B11001Im3 = B11001I003s
B11001Im4 = B11001I004s
B11001Im5 = B11001I005s
B11001Im6 = B11001I006s
B11001Im7 = B11001I007s
B11001Im8 = B11001I008s
B11001Im9 = B11001I009s
B11001m1 = B11001001s
B11001m2 = B11001002s
B11001m3 = B11001003s
B11001m4 = B11001004s
B11001m5 = B11001005s
B11001m6 = B11001006s
B11001m7 = B11001007s
B11001m8 = B11001008s
B11001m9 = B11001009s
B11002Am1 = B11002A001s
B11002Am2 = B11002A002s
B11002Am3 = B11002A003s
B11002Am4 = B11002A004s
B11002Am5 = B11002A005s
B11002Am6 = B11002A006s
B11002Am7 = B11002A007s
B11002Am8 = B11002A008s
B11002Am9 = B11002A009s
B11002Am10 = B11002A010s
B11002Am11 = B11002A011s
B11002Am12 = B11002A012s
B11002Bm1 = B11002B001s
B11002Bm2 = B11002B002s
B11002Bm3 = B11002B003s
B11002Bm4 = B11002B004s
B11002Bm5 = B11002B005s
B11002Bm6 = B11002B006s
B11002Bm7 = B11002B007s
B11002Bm8 = B11002B008s
B11002Bm9 = B11002B009s
B11002Bm10 = B11002B010s
B11002Bm11 = B11002B011s
B11002Bm12 = B11002B012s
B11002Cm1 = B11002C001s
B11002Cm2 = B11002C002s
B11002Cm3 = B11002C003s
B11002Cm4 = B11002C004s
B11002Cm5 = B11002C005s
B11002Cm6 = B11002C006s
B11002Cm7 = B11002C007s
B11002Cm8 = B11002C008s
B11002Cm9 = B11002C009s
B11002Cm10 = B11002C010s
B11002Cm11 = B11002C011s
B11002Cm12 = B11002C012s
B11002Dm1 = B11002D001s
B11002Dm2 = B11002D002s
B11002Dm3 = B11002D003s
B11002Dm4 = B11002D004s
B11002Dm5 = B11002D005s
B11002Dm6 = B11002D006s
B11002Dm7 = B11002D007s
B11002Dm8 = B11002D008s
B11002Dm9 = B11002D009s
B11002Dm10 = B11002D010s
B11002Dm11 = B11002D011s
B11002Dm12 = B11002D012s
B11002Em1 = B11002E001s
B11002Em2 = B11002E002s
B11002Em3 = B11002E003s
B11002Em4 = B11002E004s
B11002Em5 = B11002E005s
B11002Em6 = B11002E006s
B11002Em7 = B11002E007s
B11002Em8 = B11002E008s
B11002Em9 = B11002E009s
B11002Em10 = B11002E010s
B11002Em11 = B11002E011s
B11002Em12 = B11002E012s
B11002Fm1 = B11002F001s
B11002Fm2 = B11002F002s
B11002Fm3 = B11002F003s
B11002Fm4 = B11002F004s
B11002Fm5 = B11002F005s
B11002Fm6 = B11002F006s
B11002Fm7 = B11002F007s
B11002Fm8 = B11002F008s
B11002Fm9 = B11002F009s
B11002Fm10 = B11002F010s
B11002Fm11 = B11002F011s
B11002Fm12 = B11002F012s
B11002Gm1 = B11002G001s
B11002Gm2 = B11002G002s
B11002Gm3 = B11002G003s
B11002Gm4 = B11002G004s
B11002Gm5 = B11002G005s
B11002Gm6 = B11002G006s
B11002Gm7 = B11002G007s
B11002Gm8 = B11002G008s
B11002Gm9 = B11002G009s
B11002Gm10 = B11002G010s
B11002Gm11 = B11002G011s
B11002Gm12 = B11002G012s
B11002Hm1 = B11002H001s
B11002Hm2 = B11002H002s
B11002Hm3 = B11002H003s
B11002Hm4 = B11002H004s
B11002Hm5 = B11002H005s
B11002Hm6 = B11002H006s
B11002Hm7 = B11002H007s
B11002Hm8 = B11002H008s
B11002Hm9 = B11002H009s
B11002Hm10 = B11002H010s
B11002Hm11 = B11002H011s
B11002Hm12 = B11002H012s
B11002Im1 = B11002I001s
B11002Im2 = B11002I002s
B11002Im3 = B11002I003s
B11002Im4 = B11002I004s
B11002Im5 = B11002I005s
B11002Im6 = B11002I006s
B11002Im7 = B11002I007s
B11002Im8 = B11002I008s
B11002Im9 = B11002I009s
B11002Im10 = B11002I010s
B11002Im11 = B11002I011s
B11002Im12 = B11002I012s
B11002m1 = B11002001s
B11002m2 = B11002002s
B11002m3 = B11002003s
B11002m4 = B11002004s
B11002m5 = B11002005s
B11002m6 = B11002006s
B11002m7 = B11002007s
B11002m8 = B11002008s
B11002m9 = B11002009s
B11002m10 = B11002010s
B11002m11 = B11002011s
B11002m12 = B11002012s
B11003m1 = B11003001s
B11003m2 = B11003002s
B11003m3 = B11003003s
B11003m4 = B11003004s
B11003m5 = B11003005s
B11003m6 = B11003006s
B11003m7 = B11003007s
B11003m8 = B11003008s
B11003m9 = B11003009s
B11003m10 = B11003010s
B11003m11 = B11003011s
B11003m12 = B11003012s
B11003m13 = B11003013s
B11003m14 = B11003014s
B11003m15 = B11003015s
B11003m16 = B11003016s
B11003m17 = B11003017s
B11003m18 = B11003018s
B11003m19 = B11003019s
B11003m20 = B11003020s
B11004m1 = B11004001s
B11004m2 = B11004002s
B11004m3 = B11004003s
B11004m4 = B11004004s
B11004m5 = B11004005s
B11004m6 = B11004006s
B11004m7 = B11004007s
B11004m8 = B11004008s
B11004m9 = B11004009s
B11004m10 = B11004010s
B11004m11 = B11004011s
B11004m12 = B11004012s
B11004m13 = B11004013s
B11004m14 = B11004014s
B11004m15 = B11004015s
B11004m16 = B11004016s
B11004m17 = B11004017s
B11004m18 = B11004018s
B11004m19 = B11004019s
B11004m20 = B11004020s
B11005m1 = B11005001s
B11005m2 = B11005002s
B11005m3 = B11005003s
B11005m4 = B11005004s
B11005m5 = B11005005s
B11005m6 = B11005006s
B11005m7 = B11005007s
B11005m8 = B11005008s
B11005m9 = B11005009s
B11005m10 = B11005010s
B11005m11 = B11005011s
B11005m12 = B11005012s
B11005m13 = B11005013s
B11005m14 = B11005014s
B11005m15 = B11005015s
B11005m16 = B11005016s
B11005m17 = B11005017s
B11005m18 = B11005018s
B11005m19 = B11005019s
B11006m1 = B11006001s
B11006m2 = B11006002s
B11006m3 = B11006003s
B11006m4 = B11006004s
B11006m5 = B11006005s
B11006m6 = B11006006s
B11006m7 = B11006007s
B11006m8 = B11006008s
B11006m9 = B11006009s
B11006m10 = B11006010s
B11006m11 = B11006011s
B11006m12 = B11006012s
B11006m13 = B11006013s
B11006m14 = B11006014s
B11006m15 = B11006015s
B11007m1 = B11007001s
B11007m2 = B11007002s
B11007m3 = B11007003s
B11007m4 = B11007004s
B11007m5 = B11007005s
B11007m6 = B11007006s
B11007m7 = B11007007s
B11007m8 = B11007008s
B11007m9 = B11007009s
B11007m10 = B11007010s
B11007m11 = B11007011s
B11015m1 = B11015001s
B11015m2 = B11015002s
B11015m3 = B11015003s
B11016m1 = B11016001s
B11016m2 = B11016002s
B11016m3 = B11016003s
B11016m4 = B11016004s
B11016m5 = B11016005s
B11016m6 = B11016006s
B11016m7 = B11016007s
B11016m8 = B11016008s
B11016m9 = B11016009s
B11016m10 = B11016010s
B11016m11 = B11016011s
B11016m12 = B11016012s
B11016m13 = B11016013s
B11016m14 = B11016014s
B11016m15 = B11016015s
B11016m16 = B11016016s
B12001m1 = B12001001s
B12001m2 = B12001002s
B12001m3 = B12001003s
B12001m4 = B12001004s
B12001m5 = B12001005s
B12001m6 = B12001006s
B12001m7 = B12001007s
B12001m8 = B12001008s
B12001m9 = B12001009s
B12001m10 = B12001010s
B12001m11 = B12001011s
B12001m12 = B12001012s
B12001m13 = B12001013s
B12001m14 = B12001014s
B12001m15 = B12001015s
B12001m16 = B12001016s
B12001m17 = B12001017s
B12001m18 = B12001018s
B12001m19 = B12001019s
B14002m1 = B14002001s
B14002m2 = B14002002s
B14002m3 = B14002003s
B14002m4 = B14002004s
B14002m5 = B14002005s
B14002m6 = B14002006s
B14002m7 = B14002007s
B14002m8 = B14002008s
B14002m9 = B14002009s
B14002m10 = B14002010s
B14002m11 = B14002011s
B14002m12 = B14002012s
B14002m13 = B14002013s
B14002m14 = B14002014s
B14002m15 = B14002015s
B14002m16 = B14002016s
B14002m17 = B14002017s
B14002m18 = B14002018s
B14002m19 = B14002019s
B14002m20 = B14002020s
B14002m21 = B14002021s
B14002m22 = B14002022s
B14002m23 = B14002023s
B14002m24 = B14002024s
B14002m25 = B14002025s
B14002m26 = B14002026s
B14002m27 = B14002027s
B14002m28 = B14002028s
B14002m29 = B14002029s
B14002m30 = B14002030s
B14002m31 = B14002031s
B14002m32 = B14002032s
B14002m33 = B14002033s
B14002m34 = B14002034s
B14002m35 = B14002035s
B14002m36 = B14002036s
B14002m37 = B14002037s
B14002m38 = B14002038s
B14002m39 = B14002039s
B14002m40 = B14002040s
B14002m41 = B14002041s
B14002m42 = B14002042s
B14002m43 = B14002043s
B14002m44 = B14002044s
B14002m45 = B14002045s
B14002m46 = B14002046s
B14002m47 = B14002047s
B14002m48 = B14002048s
B14002m49 = B14002049s
B14005m1 = B14005001s
B14005m2 = B14005002s
B14005m3 = B14005003s
B14005m4 = B14005004s
B14005m5 = B14005005s
B14005m6 = B14005006s
B14005m7 = B14005007s
B14005m8 = B14005008s
B14005m9 = B14005009s
B14005m10 = B14005010s
B14005m11 = B14005011s
B14005m12 = B14005012s
B14005m13 = B14005013s
B14005m14 = B14005014s
B14005m15 = B14005015s
B14005m16 = B14005016s
B14005m17 = B14005017s
B14005m18 = B14005018s
B14005m19 = B14005019s
B14005m20 = B14005020s
B14005m21 = B14005021s
B14005m22 = B14005022s
B14005m23 = B14005023s
B14005m24 = B14005024s
B14005m25 = B14005025s
B14005m26 = B14005026s
B14005m27 = B14005027s
B14005m28 = B14005028s
B14005m29 = B14005029s
B14007Am1 = B14007A001s
B14007Am2 = B14007A002s
B14007Am3 = B14007A003s
B14007Am4 = B14007A004s
B14007Am5 = B14007A005s
B14007Am6 = B14007A006s
B14007Am7 = B14007A007s
B14007Am8 = B14007A008s
B14007Am9 = B14007A009s
B14007Am10 = B14007A010s
B14007Am11 = B14007A011s
B14007Am12 = B14007A012s
B14007Am13 = B14007A013s
B14007Am14 = B14007A014s
B14007Am15 = B14007A015s
B14007Am16 = B14007A016s
B14007Am17 = B14007A017s
B14007Am18 = B14007A018s
B14007Am19 = B14007A019s
B14007Bm1 = B14007B001s
B14007Bm2 = B14007B002s
B14007Bm3 = B14007B003s
B14007Bm4 = B14007B004s
B14007Bm5 = B14007B005s
B14007Bm6 = B14007B006s
B14007Bm7 = B14007B007s
B14007Bm8 = B14007B008s
B14007Bm9 = B14007B009s
B14007Bm10 = B14007B010s
B14007Bm11 = B14007B011s
B14007Bm12 = B14007B012s
B14007Bm13 = B14007B013s
B14007Bm14 = B14007B014s
B14007Bm15 = B14007B015s
B14007Bm16 = B14007B016s
B14007Bm17 = B14007B017s
B14007Bm18 = B14007B018s
B14007Bm19 = B14007B019s
B14007Cm1 = B14007C001s
B14007Cm2 = B14007C002s
B14007Cm3 = B14007C003s
B14007Cm4 = B14007C004s
B14007Cm5 = B14007C005s
B14007Cm6 = B14007C006s
B14007Cm7 = B14007C007s
B14007Cm8 = B14007C008s
B14007Cm9 = B14007C009s
B14007Cm10 = B14007C010s
B14007Cm11 = B14007C011s
B14007Cm12 = B14007C012s
B14007Cm13 = B14007C013s
B14007Cm14 = B14007C014s
B14007Cm15 = B14007C015s
B14007Cm16 = B14007C016s
B14007Cm17 = B14007C017s
B14007Cm18 = B14007C018s
B14007Cm19 = B14007C019s
B14007Dm1 = B14007D001s
B14007Dm2 = B14007D002s
B14007Dm3 = B14007D003s
B14007Dm4 = B14007D004s
B14007Dm5 = B14007D005s
B14007Dm6 = B14007D006s
B14007Dm7 = B14007D007s
B14007Dm8 = B14007D008s
B14007Dm9 = B14007D009s
B14007Dm10 = B14007D010s
B14007Dm11 = B14007D011s
B14007Dm12 = B14007D012s
B14007Dm13 = B14007D013s
B14007Dm14 = B14007D014s
B14007Dm15 = B14007D015s
B14007Dm16 = B14007D016s
B14007Dm17 = B14007D017s
B14007Dm18 = B14007D018s
B14007Dm19 = B14007D019s
B14007Em1 = B14007E001s
B14007Em2 = B14007E002s
B14007Em3 = B14007E003s
B14007Em4 = B14007E004s
B14007Em5 = B14007E005s
B14007Em6 = B14007E006s
B14007Em7 = B14007E007s
B14007Em8 = B14007E008s
B14007Em9 = B14007E009s
B14007Em10 = B14007E010s
B14007Em11 = B14007E011s
B14007Em12 = B14007E012s
B14007Em13 = B14007E013s
B14007Em14 = B14007E014s
B14007Em15 = B14007E015s
B14007Em16 = B14007E016s
B14007Em17 = B14007E017s
B14007Em18 = B14007E018s
B14007Em19 = B14007E019s
B14007Fm1 = B14007F001s
B14007Fm2 = B14007F002s
B14007Fm3 = B14007F003s
B14007Fm4 = B14007F004s
B14007Fm5 = B14007F005s
B14007Fm6 = B14007F006s
B14007Fm7 = B14007F007s
B14007Fm8 = B14007F008s
B14007Fm9 = B14007F009s
B14007Fm10 = B14007F010s
B14007Fm11 = B14007F011s
B14007Fm12 = B14007F012s
B14007Fm13 = B14007F013s
B14007Fm14 = B14007F014s
B14007Fm15 = B14007F015s
B14007Fm16 = B14007F016s
B14007Fm17 = B14007F017s
B14007Fm18 = B14007F018s
B14007Fm19 = B14007F019s
B14007Gm1 = B14007G001s
B14007Gm2 = B14007G002s
B14007Gm3 = B14007G003s
B14007Gm4 = B14007G004s
B14007Gm5 = B14007G005s
B14007Gm6 = B14007G006s
B14007Gm7 = B14007G007s
B14007Gm8 = B14007G008s
B14007Gm9 = B14007G009s
B14007Gm10 = B14007G010s
B14007Gm11 = B14007G011s
B14007Gm12 = B14007G012s
B14007Gm13 = B14007G013s
B14007Gm14 = B14007G014s
B14007Gm15 = B14007G015s
B14007Gm16 = B14007G016s
B14007Gm17 = B14007G017s
B14007Gm18 = B14007G018s
B14007Gm19 = B14007G019s
B14007Hm1 = B14007H001s
B14007Hm2 = B14007H002s
B14007Hm3 = B14007H003s
B14007Hm4 = B14007H004s
B14007Hm5 = B14007H005s
B14007Hm6 = B14007H006s
B14007Hm7 = B14007H007s
B14007Hm8 = B14007H008s
B14007Hm9 = B14007H009s
B14007Hm10 = B14007H010s
B14007Hm11 = B14007H011s
B14007Hm12 = B14007H012s
B14007Hm13 = B14007H013s
B14007Hm14 = B14007H014s
B14007Hm15 = B14007H015s
B14007Hm16 = B14007H016s
B14007Hm17 = B14007H017s
B14007Hm18 = B14007H018s
B14007Hm19 = B14007H019s
B14007Im1 = B14007I001s
B14007Im2 = B14007I002s
B14007Im3 = B14007I003s
B14007Im4 = B14007I004s
B14007Im5 = B14007I005s
B14007Im6 = B14007I006s
B14007Im7 = B14007I007s
B14007Im8 = B14007I008s
B14007Im9 = B14007I009s
B14007Im10 = B14007I010s
B14007Im11 = B14007I011s
B14007Im12 = B14007I012s
B14007Im13 = B14007I013s
B14007Im14 = B14007I014s
B14007Im15 = B14007I015s
B14007Im16 = B14007I016s
B14007Im17 = B14007I017s
B14007Im18 = B14007I018s
B14007Im19 = B14007I019s
B14007m1 = B14007001s
B14007m2 = B14007002s
B14007m3 = B14007003s
B14007m4 = B14007004s
B14007m5 = B14007005s
B14007m6 = B14007006s
B14007m7 = B14007007s
B14007m8 = B14007008s
B14007m9 = B14007009s
B14007m10 = B14007010s
B14007m11 = B14007011s
B14007m12 = B14007012s
B14007m13 = B14007013s
B14007m14 = B14007014s
B14007m15 = B14007015s
B14007m16 = B14007016s
B14007m17 = B14007017s
B14007m18 = B14007018s
B14007m19 = B14007019s
B15002m1 = B15002001s
B15002m2 = B15002002s
B15002m3 = B15002003s
B15002m4 = B15002004s
B15002m5 = B15002005s
B15002m6 = B15002006s
B15002m7 = B15002007s
B15002m8 = B15002008s
B15002m9 = B15002009s
B15002m10 = B15002010s
B15002m11 = B15002011s
B15002m12 = B15002012s
B15002m13 = B15002013s
B15002m14 = B15002014s
B15002m15 = B15002015s
B15002m16 = B15002016s
B15002m17 = B15002017s
B15002m18 = B15002018s
B15002m19 = B15002019s
B15002m20 = B15002020s
B15002m21 = B15002021s
B15002m22 = B15002022s
B15002m23 = B15002023s
B15002m24 = B15002024s
B15002m25 = B15002025s
B15002m26 = B15002026s
B15002m27 = B15002027s
B15002m28 = B15002028s
B15002m29 = B15002029s
B15002m30 = B15002030s
B15002m31 = B15002031s
B15002m32 = B15002032s
B15002m33 = B15002033s
B15002m34 = B15002034s
B15002m35 = B15002035s
B15003m1 = B15003001s
B15003m2 = B15003002s
B15003m3 = B15003003s
B15003m4 = B15003004s
B15003m5 = B15003005s
B15003m6 = B15003006s
B15003m7 = B15003007s
B15003m8 = B15003008s
B15003m9 = B15003009s
B15003m10 = B15003010s
B15003m11 = B15003011s
B15003m12 = B15003012s
B15003m13 = B15003013s
B15003m14 = B15003014s
B15003m15 = B15003015s
B15003m16 = B15003016s
B15003m17 = B15003017s
B15003m18 = B15003018s
B15003m19 = B15003019s
B15003m20 = B15003020s
B15003m21 = B15003021s
B15003m22 = B15003022s
B15003m23 = B15003023s
B15003m24 = B15003024s
B15003m25 = B15003025s
B15011m1 = B15011001s
B15011m2 = B15011002s
B15011m3 = B15011003s
B15011m4 = B15011004s
B15011m5 = B15011005s
B15011m6 = B15011006s
B15011m7 = B15011007s
B15011m8 = B15011008s
B15011m9 = B15011009s
B15011m10 = B15011010s
B15011m11 = B15011011s
B15011m12 = B15011012s
B15011m13 = B15011013s
B15011m14 = B15011014s
B15011m15 = B15011015s
B15011m16 = B15011016s
B15011m17 = B15011017s
B15011m18 = B15011018s
B15011m19 = B15011019s
B15011m20 = B15011020s
B15011m21 = B15011021s
B15011m22 = B15011022s
B15011m23 = B15011023s
B15011m24 = B15011024s
B15011m25 = B15011025s
B15011m26 = B15011026s
B15011m27 = B15011027s
B15011m28 = B15011028s
B15011m29 = B15011029s
B15011m30 = B15011030s
B15011m31 = B15011031s
B15011m32 = B15011032s
B15011m33 = B15011033s
B15011m34 = B15011034s
B15011m35 = B15011035s
B15011m36 = B15011036s
B15011m37 = B15011037s
B15011m38 = B15011038s
B15011m39 = B15011039s
B15012m1 = B15012001s
B15012m2 = B15012002s
B15012m3 = B15012003s
B15012m4 = B15012004s
B15012m5 = B15012005s
B15012m6 = B15012006s
B15012m7 = B15012007s
B15012m8 = B15012008s
B15012m9 = B15012009s
B15012m10 = B15012010s
B15012m11 = B15012011s
B15012m12 = B15012012s
B15012m13 = B15012013s
B15012m14 = B15012014s
B15012m15 = B15012015s
B15012m16 = B15012016s
B16004m1 = B16004001s
B16004m2 = B16004002s
B16004m3 = B16004003s
B16004m4 = B16004004s
B16004m5 = B16004005s
B16004m6 = B16004006s
B16004m7 = B16004007s
B16004m8 = B16004008s
B16004m9 = B16004009s
B16004m10 = B16004010s
B16004m11 = B16004011s
B16004m12 = B16004012s
B16004m13 = B16004013s
B16004m14 = B16004014s
B16004m15 = B16004015s
B16004m16 = B16004016s
B16004m17 = B16004017s
B16004m18 = B16004018s
B16004m19 = B16004019s
B16004m20 = B16004020s
B16004m21 = B16004021s
B16004m22 = B16004022s
B16004m23 = B16004023s
B16004m24 = B16004024s
B16004m25 = B16004025s
B16004m26 = B16004026s
B16004m27 = B16004027s
B16004m28 = B16004028s
B16004m29 = B16004029s
B16004m30 = B16004030s
B16004m31 = B16004031s
B16004m32 = B16004032s
B16004m33 = B16004033s
B16004m34 = B16004034s
B16004m35 = B16004035s
B16004m36 = B16004036s
B16004m37 = B16004037s
B16004m38 = B16004038s
B16004m39 = B16004039s
B16004m40 = B16004040s
B16004m41 = B16004041s
B16004m42 = B16004042s
B16004m43 = B16004043s
B16004m44 = B16004044s
B16004m45 = B16004045s
B16004m46 = B16004046s
B16004m47 = B16004047s
B16004m48 = B16004048s
B16004m49 = B16004049s
B16004m50 = B16004050s
B16004m51 = B16004051s
B16004m52 = B16004052s
B16004m53 = B16004053s
B16004m54 = B16004054s
B16004m55 = B16004055s
B16004m56 = B16004056s
B16004m57 = B16004057s
B16004m58 = B16004058s
B16004m59 = B16004059s
B16004m60 = B16004060s
B16004m61 = B16004061s
B16004m62 = B16004062s
B16004m63 = B16004063s
B16004m64 = B16004064s
B16004m65 = B16004065s
B16004m66 = B16004066s
B16004m67 = B16004067s
C15010Am1 = C15010A001s
C15010Am2 = C15010A002s
C15010Am3 = C15010A003s
C15010Am4 = C15010A004s
C15010Am5 = C15010A005s
C15010Am6 = C15010A006s
C15010Bm1 = C15010B001s
C15010Bm2 = C15010B002s
C15010Bm3 = C15010B003s
C15010Bm4 = C15010B004s
C15010Bm5 = C15010B005s
C15010Bm6 = C15010B006s
C15010Cm1 = C15010C001s
C15010Cm2 = C15010C002s
C15010Cm3 = C15010C003s
C15010Cm4 = C15010C004s
C15010Cm5 = C15010C005s
C15010Cm6 = C15010C006s
C15010Dm1 = C15010D001s
C15010Dm2 = C15010D002s
C15010Dm3 = C15010D003s
C15010Dm4 = C15010D004s
C15010Dm5 = C15010D005s
C15010Dm6 = C15010D006s
C15010Em1 = C15010E001s
C15010Em2 = C15010E002s
C15010Em3 = C15010E003s
C15010Em4 = C15010E004s
C15010Em5 = C15010E005s
C15010Em6 = C15010E006s
C15010Fm1 = C15010F001s
C15010Fm2 = C15010F002s
C15010Fm3 = C15010F003s
C15010Fm4 = C15010F004s
C15010Fm5 = C15010F005s
C15010Fm6 = C15010F006s
C15010Gm1 = C15010G001s
C15010Gm2 = C15010G002s
C15010Gm3 = C15010G003s
C15010Gm4 = C15010G004s
C15010Gm5 = C15010G005s
C15010Gm6 = C15010G006s
C15010Hm1 = C15010H001s
C15010Hm2 = C15010H002s
C15010Hm3 = C15010H003s
C15010Hm4 = C15010H004s
C15010Hm5 = C15010H005s
C15010Hm6 = C15010H006s
C15010Im1 = C15010I001s
C15010Im2 = C15010I002s
C15010Im3 = C15010I003s
C15010Im4 = C15010I004s
C15010Im5 = C15010I005s
C15010Im6 = C15010I006s
C15010m1 = C15010001s
C15010m2 = C15010002s
C15010m3 = C15010003s
C15010m4 = C15010004s
C15010m5 = C15010005s
C15010m6 = C15010006s
C16002m1 = C16002001s
C16002m2 = C16002002s
C16002m3 = C16002003s
C16002m4 = C16002004s
C16002m5 = C16002005s
C16002m6 = C16002006s
C16002m7 = C16002007s
C16002m8 = C16002008s
C16002m9 = C16002009s
C16002m10 = C16002010s
C16002m11 = C16002011s
C16002m12 = C16002012s
C16002m13 = C16002013s
C16002m14 = C16002014s
B17010m1 = B17010001s
B17010m2 = B17010002s
B17010m3 = B17010003s
B17010m4 = B17010004s
B17010m5 = B17010005s
B17010m6 = B17010006s
B17010m7 = B17010007s
B17010m8 = B17010008s
B17010m9 = B17010009s
B17010m10 = B17010010s
B17010m11 = B17010011s
B17010m12 = B17010012s
B17010m13 = B17010013s
B17010m14 = B17010014s
B17010m15 = B17010015s
B17010m16 = B17010016s
B17010m17 = B17010017s
B17010m18 = B17010018s
B17010m19 = B17010019s
B17010m20 = B17010020s
B17010m21 = B17010021s
B17010m22 = B17010022s
B17010m23 = B17010023s
B17010m24 = B17010024s
B17010m25 = B17010025s
B17010m26 = B17010026s
B17010m27 = B17010027s
B17010m28 = B17010028s
B17010m29 = B17010029s
B17010m30 = B17010030s
B17010m31 = B17010031s
B17010m32 = B17010032s
B17010m33 = B17010033s
B17010m34 = B17010034s
B17010m35 = B17010035s
B17010m36 = B17010036s
B17010m37 = B17010037s
B17010m38 = B17010038s
B17010m39 = B17010039s
B17010m40 = B17010040s
B17010m41 = B17010041s
B17017m1 = B17017001s
B17017m2 = B17017002s
B17017m3 = B17017003s
B17017m4 = B17017004s
B17017m5 = B17017005s
B17017m6 = B17017006s
B17017m7 = B17017007s
B17017m8 = B17017008s
B17017m9 = B17017009s
B17017m10 = B17017010s
B17017m11 = B17017011s
B17017m12 = B17017012s
B17017m13 = B17017013s
B17017m14 = B17017014s
B17017m15 = B17017015s
B17017m16 = B17017016s
B17017m17 = B17017017s
B17017m18 = B17017018s
B17017m19 = B17017019s
B17017m20 = B17017020s
B17017m21 = B17017021s
B17017m22 = B17017022s
B17017m23 = B17017023s
B17017m24 = B17017024s
B17017m25 = B17017025s
B17017m26 = B17017026s
B17017m27 = B17017027s
B17017m28 = B17017028s
B17017m29 = B17017029s
B17017m30 = B17017030s
B17017m31 = B17017031s
B17017m32 = B17017032s
B17017m33 = B17017033s
B17017m34 = B17017034s
B17017m35 = B17017035s
B17017m36 = B17017036s
B17017m37 = B17017037s
B17017m38 = B17017038s
B17017m39 = B17017039s
B17017m40 = B17017040s
B17017m41 = B17017041s
B17017m42 = B17017042s
B17017m43 = B17017043s
B17017m44 = B17017044s
B17017m45 = B17017045s
B17017m46 = B17017046s
B17017m47 = B17017047s
B17017m48 = B17017048s
B17017m49 = B17017049s
B17017m50 = B17017050s
B17017m51 = B17017051s
B17017m52 = B17017052s
B17017m53 = B17017053s
B17017m54 = B17017054s
B17017m55 = B17017055s
B17017m56 = B17017056s
B17017m57 = B17017057s
B17017m58 = B17017058s
B17017m59 = B17017059s
B17021m1 = B17021001s
B17021m2 = B17021002s
B17021m3 = B17021003s
B17021m4 = B17021004s
B17021m5 = B17021005s
B17021m6 = B17021006s
B17021m7 = B17021007s
B17021m8 = B17021008s
B17021m9 = B17021009s
B17021m10 = B17021010s
B17021m11 = B17021011s
B17021m12 = B17021012s
B17021m13 = B17021013s
B17021m14 = B17021014s
B17021m15 = B17021015s
B17021m16 = B17021016s
B17021m17 = B17021017s
B17021m18 = B17021018s
B17021m19 = B17021019s
B17021m20 = B17021020s
B17021m21 = B17021021s
B17021m22 = B17021022s
B17021m23 = B17021023s
B17021m24 = B17021024s
B17021m25 = B17021025s
B17021m26 = B17021026s
B17021m27 = B17021027s
B17021m28 = B17021028s
B17021m29 = B17021029s
B17021m30 = B17021030s
B17021m31 = B17021031s
B17021m32 = B17021032s
B17021m33 = B17021033s
B17021m34 = B17021034s
B17021m35 = B17021035s
B19001m1 = B19001001s
B19001m2 = B19001002s
B19001m3 = B19001003s
B19001m4 = B19001004s
B19001m5 = B19001005s
B19001m6 = B19001006s
B19001m7 = B19001007s
B19001m8 = B19001008s
B19001m9 = B19001009s
B19001m10 = B19001010s
B19001m11 = B19001011s
B19001m12 = B19001012s
B19001m13 = B19001013s
B19001m14 = B19001014s
B19001m15 = B19001015s
B19001m16 = B19001016s
B19001m17 = B19001017s
B19013m1 = B19013001s
B19025Am1 = B19025A001s
B19025Bm1 = B19025B001s
B19025Hm1 = B19025H001s
B19025m1 = B19025001s
B19037m1 = B19037001s
B19037m2 = B19037002s
B19037m3 = B19037003s
B19037m4 = B19037004s
B19037m5 = B19037005s
B19037m6 = B19037006s
B19037m7 = B19037007s
B19037m8 = B19037008s
B19037m9 = B19037009s
B19037m10 = B19037010s
B19037m11 = B19037011s
B19037m12 = B19037012s
B19037m13 = B19037013s
B19037m14 = B19037014s
B19037m15 = B19037015s
B19037m16 = B19037016s
B19037m17 = B19037017s
B19037m18 = B19037018s
B19037m19 = B19037019s
B19037m20 = B19037020s
B19037m21 = B19037021s
B19037m22 = B19037022s
B19037m23 = B19037023s
B19037m24 = B19037024s
B19037m25 = B19037025s
B19037m26 = B19037026s
B19037m27 = B19037027s
B19037m28 = B19037028s
B19037m29 = B19037029s
B19037m30 = B19037030s
B19037m31 = B19037031s
B19037m32 = B19037032s
B19037m33 = B19037033s
B19037m34 = B19037034s
B19037m35 = B19037035s
B19037m36 = B19037036s
B19037m37 = B19037037s
B19037m38 = B19037038s
B19037m39 = B19037039s
B19037m40 = B19037040s
B19037m41 = B19037041s
B19037m42 = B19037042s
B19037m43 = B19037043s
B19037m44 = B19037044s
B19037m45 = B19037045s
B19037m46 = B19037046s
B19037m47 = B19037047s
B19037m48 = B19037048s
B19037m49 = B19037049s
B19037m50 = B19037050s
B19037m51 = B19037051s
B19037m52 = B19037052s
B19037m53 = B19037053s
B19037m54 = B19037054s
B19037m55 = B19037055s
B19037m56 = B19037056s
B19037m57 = B19037057s
B19037m58 = B19037058s
B19037m59 = B19037059s
B19037m60 = B19037060s
B19037m61 = B19037061s
B19037m62 = B19037062s
B19037m63 = B19037063s
B19037m64 = B19037064s
B19037m65 = B19037065s
B19037m66 = B19037066s
B19037m67 = B19037067s
B19037m68 = B19037068s
B19037m69 = B19037069s
B19049m1 = B19049001s
B19049m2 = B19049002s
B19049m3 = B19049003s
B19049m4 = B19049004s
B19049m5 = B19049005s
B19050m1 = B19050001s
B19050m2 = B19050002s
B19050m3 = B19050003s
B19050m4 = B19050004s
B19050m5 = B19050005s
B19051m1 = B19051001s
B19051m2 = B19051002s
B19051m3 = B19051003s
B19052m1 = B19052001s
B19052m2 = B19052002s
B19052m3 = B19052003s
B19053m1 = B19053001s
B19053m2 = B19053002s
B19053m3 = B19053003s
B19054m1 = B19054001s
B19054m2 = B19054002s
B19054m3 = B19054003s
B19055m1 = B19055001s
B19055m2 = B19055002s
B19055m3 = B19055003s
B19056m1 = B19056001s
B19056m2 = B19056002s
B19056m3 = B19056003s
B19057m1 = B19057001s
B19057m2 = B19057002s
B19057m3 = B19057003s
B19058m1 = B19058001s
B19058m2 = B19058002s
B19058m3 = B19058003s
B19059m1 = B19059001s
B19059m2 = B19059002s
B19059m3 = B19059003s
B19060m1 = B19060001s
B19060m2 = B19060002s
B19060m3 = B19060003s
B19061m1 = B19061001s
B19062m1 = B19062001s
B19063m1 = B19063001s
B19064m1 = B19064001s
B19065m1 = B19065001s
B19066m1 = B19066001s
B19069m1 = B19069001s
B19070m1 = B19070001s
B19101m1 = B19101001s
B19101m2 = B19101002s
B19101m3 = B19101003s
B19101m4 = B19101004s
B19101m5 = B19101005s
B19101m6 = B19101006s
B19101m7 = B19101007s
B19101m8 = B19101008s
B19101m9 = B19101009s
B19101m10 = B19101010s
B19101m11 = B19101011s
B19101m12 = B19101012s
B19101m13 = B19101013s
B19101m14 = B19101014s
B19101m15 = B19101015s
B19101m16 = B19101016s
B19101m17 = B19101017s
B19113m1 = B19113001s
B19127m1 = B19127001s
B19201m1 = B19201001s
B19201m2 = B19201002s
B19201m3 = B19201003s
B19201m4 = B19201004s
B19201m5 = B19201005s
B19201m6 = B19201006s
B19201m7 = B19201007s
B19201m8 = B19201008s
B19201m9 = B19201009s
B19201m10 = B19201010s
B19201m11 = B19201011s
B19201m12 = B19201012s
B19201m13 = B19201013s
B19201m14 = B19201014s
B19201m15 = B19201015s
B19201m16 = B19201016s
B19201m17 = B19201017s
B19202m1 = B19202001s
B19214m1 = B19214001s
B19301Am1 = B19301A001s
B19301Bm1 = B19301B001s
B19301Cm1 = B19301C001s
B19301Fm1 = B19301F001s
B19301Gm1 = B19301G001s
B19301Hm1 = B19301H001s
B19301Im1 = B19301I001s
B19301m1 = B19301001s
B19313Am1 = B19313A001s
B19313Bm1 = B19313B001s
B19313Cm1 = B19313C001s
B19313Fm1 = B19313F001s
B19313Gm1 = B19313G001s
B19313Hm1 = B19313H001s
B19313Im1 = B19313I001s
B19313m1 = B19313001s
B20001m1 = B20001001s
B20001m2 = B20001002s
B20001m3 = B20001003s
B20001m4 = B20001004s
B20001m5 = B20001005s
B20001m6 = B20001006s
B20001m7 = B20001007s
B20001m8 = B20001008s
B20001m9 = B20001009s
B20001m10 = B20001010s
B20001m11 = B20001011s
B20001m12 = B20001012s
B20001m13 = B20001013s
B20001m14 = B20001014s
B20001m15 = B20001015s
B20001m16 = B20001016s
B20001m17 = B20001017s
B20001m18 = B20001018s
B20001m19 = B20001019s
B20001m20 = B20001020s
B20001m21 = B20001021s
B20001m22 = B20001022s
B20001m23 = B20001023s
B20001m24 = B20001024s
B20001m25 = B20001025s
B20001m26 = B20001026s
B20001m27 = B20001027s
B20001m28 = B20001028s
B20001m29 = B20001029s
B20001m30 = B20001030s
B20001m31 = B20001031s
B20001m32 = B20001032s
B20001m33 = B20001033s
B20001m34 = B20001034s
B20001m35 = B20001035s
B20001m36 = B20001036s
B20001m37 = B20001037s
B20001m38 = B20001038s
B20001m39 = B20001039s
B20001m40 = B20001040s
B20001m41 = B20001041s
B20001m42 = B20001042s
B20001m43 = B20001043s
B20002m1 = B20002001s
B20002m2 = B20002002s
B20002m3 = B20002003s
B20003m1 = B20003001s
B20003m2 = B20003002s
B20003m3 = B20003003s
B20003m4 = B20003004s
B20003m5 = B20003005s
B20003m6 = B20003006s
B20003m7 = B20003007s
B20017m1 = B20017001s
B20017m2 = B20017002s
B20017m3 = B20017003s
B20017m4 = B20017004s
B20017m5 = B20017005s
B20017m6 = B20017006s
B20017m7 = B20017007s
C17002m1 = C17002001s
C17002m2 = C17002002s
C17002m3 = C17002003s
C17002m4 = C17002004s
C17002m5 = C17002005s
C17002m6 = C17002006s
C17002m7 = C17002007s
C17002m8 = C17002008s
B21001m1 = B21001001s
B21001m2 = B21001002s
B21001m3 = B21001003s
B21001m4 = B21001004s
B21001m5 = B21001005s
B21001m6 = B21001006s
B21001m7 = B21001007s
B21001m8 = B21001008s
B21001m9 = B21001009s
B21001m10 = B21001010s
B21001m11 = B21001011s
B21001m12 = B21001012s
B21001m13 = B21001013s
B21001m14 = B21001014s
B21001m15 = B21001015s
B21001m16 = B21001016s
B21001m17 = B21001017s
B21001m18 = B21001018s
B21001m19 = B21001019s
B21001m20 = B21001020s
B21001m21 = B21001021s
B21001m22 = B21001022s
B21001m23 = B21001023s
B21001m24 = B21001024s
B21001m25 = B21001025s
B21001m26 = B21001026s
B21001m27 = B21001027s
B21001m28 = B21001028s
B21001m29 = B21001029s
B21001m30 = B21001030s
B21001m31 = B21001031s
B21001m32 = B21001032s
B21001m33 = B21001033s
B21001m34 = B21001034s
B21001m35 = B21001035s
B21001m36 = B21001036s
B21001m37 = B21001037s
B21001m38 = B21001038s
B21001m39 = B21001039s
B21002m1 = B21002001s
B21002m2 = B21002002s
B21002m3 = B21002003s
B21002m4 = B21002004s
B21002m5 = B21002005s
B21002m6 = B21002006s
B21002m7 = B21002007s
B21002m8 = B21002008s
B21002m9 = B21002009s
B21002m10 = B21002010s
B21002m11 = B21002011s
B21002m12 = B21002012s
B21002m13 = B21002013s
B21002m14 = B21002014s
B21002m15 = B21002015s
B21002m16 = B21002016s
B22010m1 = B22010001s
B22010m2 = B22010002s
B22010m3 = B22010003s
B22010m4 = B22010004s
B22010m5 = B22010005s
B22010m6 = B22010006s
B22010m7 = B22010007s
B23003m1 = B23003001s
B23003m2 = B23003002s
B23003m3 = B23003003s
B23003m4 = B23003004s
B23003m5 = B23003005s
B23003m6 = B23003006s
B23003m7 = B23003007s
B23003m8 = B23003008s
B23003m9 = B23003009s
B23003m10 = B23003010s
B23003m11 = B23003011s
B23003m12 = B23003012s
B23003m13 = B23003013s
B23003m14 = B23003014s
B23003m15 = B23003015s
B23003m16 = B23003016s
B23003m17 = B23003017s
B23003m18 = B23003018s
B23003m19 = B23003019s
B23003m20 = B23003020s
B23003m21 = B23003021s
B23003m22 = B23003022s
B23003m23 = B23003023s
B23003m24 = B23003024s
B23003m25 = B23003025s
B23003m26 = B23003026s
B23003m27 = B23003027s
B23003m28 = B23003028s
B23003m29 = B23003029s
B23003m30 = B23003030s
B23007m1 = B23007001s
B23007m2 = B23007002s
B23007m3 = B23007003s
B23007m4 = B23007004s
B23007m5 = B23007005s
B23007m6 = B23007006s
B23007m7 = B23007007s
B23007m8 = B23007008s
B23007m9 = B23007009s
B23007m10 = B23007010s
B23007m11 = B23007011s
B23007m12 = B23007012s
B23007m13 = B23007013s
B23007m14 = B23007014s
B23007m15 = B23007015s
B23007m16 = B23007016s
B23007m17 = B23007017s
B23007m18 = B23007018s
B23007m19 = B23007019s
B23007m20 = B23007020s
B23007m21 = B23007021s
B23007m22 = B23007022s
B23007m23 = B23007023s
B23007m24 = B23007024s
B23007m25 = B23007025s
B23007m26 = B23007026s
B23007m27 = B23007027s
B23007m28 = B23007028s
B23007m29 = B23007029s
B23007m30 = B23007030s
B23007m31 = B23007031s
B23007m32 = B23007032s
B23007m33 = B23007033s
B23007m34 = B23007034s
B23007m35 = B23007035s
B23007m36 = B23007036s
B23007m37 = B23007037s
B23007m38 = B23007038s
B23007m39 = B23007039s
B23007m40 = B23007040s
B23007m41 = B23007041s
B23007m42 = B23007042s
B23007m43 = B23007043s
B23007m44 = B23007044s
B23007m45 = B23007045s
B23007m46 = B23007046s
B23007m47 = B23007047s
B23007m48 = B23007048s
B23007m49 = B23007049s
B23007m50 = B23007050s
B23007m51 = B23007051s
B23007m52 = B23007052s
B23007m53 = B23007053s
B23007m54 = B23007054s
B23007m55 = B23007055s
B23007m56 = B23007056s
B23007m57 = B23007057s
B23007m58 = B23007058s
B23007m59 = B23007059s
B23008m1 = B23008001s
B23008m2 = B23008002s
B23008m3 = B23008003s
B23008m4 = B23008004s
B23008m5 = B23008005s
B23008m6 = B23008006s
B23008m7 = B23008007s
B23008m8 = B23008008s
B23008m9 = B23008009s
B23008m10 = B23008010s
B23008m11 = B23008011s
B23008m12 = B23008012s
B23008m13 = B23008013s
B23008m14 = B23008014s
B23008m15 = B23008015s
B23008m16 = B23008016s
B23008m17 = B23008017s
B23008m18 = B23008018s
B23008m19 = B23008019s
B23008m20 = B23008020s
B23008m21 = B23008021s
B23008m22 = B23008022s
B23008m23 = B23008023s
B23008m24 = B23008024s
B23008m25 = B23008025s
B23008m26 = B23008026s
B23008m27 = B23008027s
B23009m1 = B23009001s
B23009m2 = B23009002s
B23009m3 = B23009003s
B23009m4 = B23009004s
B23009m5 = B23009005s
B23009m6 = B23009006s
B23009m7 = B23009007s
B23009m8 = B23009008s
B23009m9 = B23009009s
B23009m10 = B23009010s
B23009m11 = B23009011s
B23009m12 = B23009012s
B23009m13 = B23009013s
B23009m14 = B23009014s
B23009m15 = B23009015s
B23009m16 = B23009016s
B23009m17 = B23009017s
B23009m18 = B23009018s
B23009m19 = B23009019s
B23009m20 = B23009020s
B23009m21 = B23009021s
B23009m22 = B23009022s
B23009m23 = B23009023s
B23009m24 = B23009024s
B23009m25 = B23009025s
B23009m26 = B23009026s
B23009m27 = B23009027s
B23009m28 = B23009028s
B23009m29 = B23009029s
B23009m30 = B23009030s
B23009m31 = B23009031s
B23009m32 = B23009032s
B23009m33 = B23009033s
B23009m34 = B23009034s
B23009m35 = B23009035s
B23009m36 = B23009036s
B23009m37 = B23009037s
B23009m38 = B23009038s
B23009m39 = B23009039s
B23009m40 = B23009040s
B23009m41 = B23009041s
B23009m42 = B23009042s
B23009m43 = B23009043s
B23022m1 = B23022001s
B23022m2 = B23022002s
B23022m3 = B23022003s
B23022m4 = B23022004s
B23022m5 = B23022005s
B23022m6 = B23022006s
B23022m7 = B23022007s
B23022m8 = B23022008s
B23022m9 = B23022009s
B23022m10 = B23022010s
B23022m11 = B23022011s
B23022m12 = B23022012s
B23022m13 = B23022013s
B23022m14 = B23022014s
B23022m15 = B23022015s
B23022m16 = B23022016s
B23022m17 = B23022017s
B23022m18 = B23022018s
B23022m19 = B23022019s
B23022m20 = B23022020s
B23022m21 = B23022021s
B23022m22 = B23022022s
B23022m23 = B23022023s
B23022m24 = B23022024s
B23022m25 = B23022025s
B23022m26 = B23022026s
B23022m27 = B23022027s
B23022m28 = B23022028s
B23022m29 = B23022029s
B23022m30 = B23022030s
B23022m31 = B23022031s
B23022m32 = B23022032s
B23022m33 = B23022033s
B23022m34 = B23022034s
B23022m35 = B23022035s
B23022m36 = B23022036s
B23022m37 = B23022037s
B23022m38 = B23022038s
B23022m39 = B23022039s
B23022m40 = B23022040s
B23022m41 = B23022041s
B23022m42 = B23022042s
B23022m43 = B23022043s
B23022m44 = B23022044s
B23022m45 = B23022045s
B23022m46 = B23022046s
B23022m47 = B23022047s
B23022m48 = B23022048s
B23022m49 = B23022049s
B23024m1 = B23024001s
B23024m2 = B23024002s
B23024m3 = B23024003s
B23024m4 = B23024004s
B23024m5 = B23024005s
B23024m6 = B23024006s
B23024m7 = B23024007s
B23024m8 = B23024008s
B23024m9 = B23024009s
B23024m10 = B23024010s
B23024m11 = B23024011s
B23024m12 = B23024012s
B23024m13 = B23024013s
B23024m14 = B23024014s
B23024m15 = B23024015s
B23024m16 = B23024016s
B23024m17 = B23024017s
B23024m18 = B23024018s
B23024m19 = B23024019s
B23024m20 = B23024020s
B23024m21 = B23024021s
B23024m22 = B23024022s
B23024m23 = B23024023s
B23024m24 = B23024024s
B23024m25 = B23024025s
B23024m26 = B23024026s
B23024m27 = B23024027s
B23024m28 = B23024028s
B23024m29 = B23024029s
B23024m30 = B23024030s
B23024m31 = B23024031s
B23025m1 = B23025001s
B23025m2 = B23025002s
B23025m3 = B23025003s
B23025m4 = B23025004s
B23025m5 = B23025005s
B23025m6 = B23025006s
B23025m7 = B23025007s
B23026m1 = B23026001s
B23026m2 = B23026002s
B23026m3 = B23026003s
B23026m4 = B23026004s
B23026m5 = B23026005s
B23026m6 = B23026006s
B23026m7 = B23026007s
B23026m8 = B23026008s
B23026m9 = B23026009s
B23026m10 = B23026010s
B23026m11 = B23026011s
B23026m12 = B23026012s
B23026m13 = B23026013s
B23026m14 = B23026014s
B23026m15 = B23026015s
B23026m16 = B23026016s
B23026m17 = B23026017s
B23026m18 = B23026018s
B23026m19 = B23026019s
B23026m20 = B23026020s
B23026m21 = B23026021s
B23026m22 = B23026022s
B23026m23 = B23026023s
B23026m24 = B23026024s
B23026m25 = B23026025s
B23026m26 = B23026026s
B23026m27 = B23026027s
B23026m28 = B23026028s
B23026m29 = B23026029s
B23026m30 = B23026030s
B23026m31 = B23026031s
B23026m32 = B23026032s
B23026m33 = B23026033s
B23026m34 = B23026034s
B23026m35 = B23026035s
B23026m36 = B23026036s
B23026m37 = B23026037s
B23026m38 = B23026038s
B23026m39 = B23026039s
B23026m40 = B23026040s
B23026m41 = B23026041s
B23026m42 = B23026042s
B23026m43 = B23026043s
B23026m44 = B23026044s
B23026m45 = B23026045s
B23026m46 = B23026046s
B23026m47 = B23026047s
B23026m48 = B23026048s
B23026m49 = B23026049s
B23027m1 = B23027001s
B23027m2 = B23027002s
B23027m3 = B23027003s
B23027m4 = B23027004s
B23027m5 = B23027005s
B23027m6 = B23027006s
B23027m7 = B23027007s
B23027m8 = B23027008s
B23027m9 = B23027009s
B23027m10 = B23027010s
B23027m11 = B23027011s
B23027m12 = B23027012s
B23027m13 = B23027013s
B23027m14 = B23027014s
B23027m15 = B23027015s
B23027m16 = B23027016s
B23027m17 = B23027017s
B23027m18 = B23027018s
B23027m19 = B23027019s
B23027m20 = B23027020s
B23027m21 = B23027021s
B23027m22 = B23027022s
B23027m23 = B23027023s
B23027m24 = B23027024s
B23027m25 = B23027025s
B23027m26 = B23027026s
B23027m27 = B23027027s
B23027m28 = B23027028s
B23027m29 = B23027029s
B23027m30 = B23027030s
B23027m31 = B23027031s
B23027m32 = B23027032s
B23027m33 = B23027033s
B23027m34 = B23027034s
B23027m35 = B23027035s
B23027m36 = B23027036s
B24080m1 = B24080001s
B24080m2 = B24080002s
B24080m3 = B24080003s
B24080m4 = B24080004s
B24080m5 = B24080005s
B24080m6 = B24080006s
B24080m7 = B24080007s
B24080m8 = B24080008s
B24080m9 = B24080009s
B24080m10 = B24080010s
B24080m11 = B24080011s
B24080m12 = B24080012s
B24080m13 = B24080013s
B24080m14 = B24080014s
B24080m15 = B24080015s
B24080m16 = B24080016s
B24080m17 = B24080017s
B24080m18 = B24080018s
B24080m19 = B24080019s
B24080m20 = B24080020s
B24080m21 = B24080021s
C21007m1 = C21007001s
C21007m2 = C21007002s
C21007m3 = C21007003s
C21007m4 = C21007004s
C21007m5 = C21007005s
C21007m6 = C21007006s
C21007m7 = C21007007s
C21007m8 = C21007008s
C21007m9 = C21007009s
C21007m10 = C21007010s
C21007m11 = C21007011s
C21007m12 = C21007012s
C21007m13 = C21007013s
C21007m14 = C21007014s
C21007m15 = C21007015s
C21007m16 = C21007016s
C21007m17 = C21007017s
C21007m18 = C21007018s
C21007m19 = C21007019s
C21007m20 = C21007020s
C21007m21 = C21007021s
C21007m22 = C21007022s
C21007m23 = C21007023s
C21007m24 = C21007024s
C21007m25 = C21007025s
C21007m26 = C21007026s
C21007m27 = C21007027s
C21007m28 = C21007028s
C21007m29 = C21007029s
C21007m30 = C21007030s
C21007m31 = C21007031s
C24010Am1 = C24010A001s
C24010Am2 = C24010A002s
C24010Am3 = C24010A003s
C24010Am4 = C24010A004s
C24010Am5 = C24010A005s
C24010Am6 = C24010A006s
C24010Am7 = C24010A007s
C24010Am8 = C24010A008s
C24010Am9 = C24010A009s
C24010Am10 = C24010A010s
C24010Am11 = C24010A011s
C24010Am12 = C24010A012s
C24010Am13 = C24010A013s
C24010Bm1 = C24010B001s
C24010Bm2 = C24010B002s
C24010Bm3 = C24010B003s
C24010Bm4 = C24010B004s
C24010Bm5 = C24010B005s
C24010Bm6 = C24010B006s
C24010Bm7 = C24010B007s
C24010Bm8 = C24010B008s
C24010Bm9 = C24010B009s
C24010Bm10 = C24010B010s
C24010Bm11 = C24010B011s
C24010Bm12 = C24010B012s
C24010Bm13 = C24010B013s
C24010Cm1 = C24010C001s
C24010Cm2 = C24010C002s
C24010Cm3 = C24010C003s
C24010Cm4 = C24010C004s
C24010Cm5 = C24010C005s
C24010Cm6 = C24010C006s
C24010Cm7 = C24010C007s
C24010Cm8 = C24010C008s
C24010Cm9 = C24010C009s
C24010Cm10 = C24010C010s
C24010Cm11 = C24010C011s
C24010Cm12 = C24010C012s
C24010Cm13 = C24010C013s
C24010Dm1 = C24010D001s
C24010Dm2 = C24010D002s
C24010Dm3 = C24010D003s
C24010Dm4 = C24010D004s
C24010Dm5 = C24010D005s
C24010Dm6 = C24010D006s
C24010Dm7 = C24010D007s
C24010Dm8 = C24010D008s
C24010Dm9 = C24010D009s
C24010Dm10 = C24010D010s
C24010Dm11 = C24010D011s
C24010Dm12 = C24010D012s
C24010Dm13 = C24010D013s
C24010Em1 = C24010E001s
C24010Em2 = C24010E002s
C24010Em3 = C24010E003s
C24010Em4 = C24010E004s
C24010Em5 = C24010E005s
C24010Em6 = C24010E006s
C24010Em7 = C24010E007s
C24010Em8 = C24010E008s
C24010Em9 = C24010E009s
C24010Em10 = C24010E010s
C24010Em11 = C24010E011s
C24010Em12 = C24010E012s
C24010Em13 = C24010E013s
C24010Fm1 = C24010F001s
C24010Fm2 = C24010F002s
C24010Fm3 = C24010F003s
C24010Fm4 = C24010F004s
C24010Fm5 = C24010F005s
C24010Fm6 = C24010F006s
C24010Fm7 = C24010F007s
C24010Fm8 = C24010F008s
C24010Fm9 = C24010F009s
C24010Fm10 = C24010F010s
C24010Fm11 = C24010F011s
C24010Fm12 = C24010F012s
C24010Fm13 = C24010F013s
C24010Gm1 = C24010G001s
C24010Gm2 = C24010G002s
C24010Gm3 = C24010G003s
C24010Gm4 = C24010G004s
C24010Gm5 = C24010G005s
C24010Gm6 = C24010G006s
C24010Gm7 = C24010G007s
C24010Gm8 = C24010G008s
C24010Gm9 = C24010G009s
C24010Gm10 = C24010G010s
C24010Gm11 = C24010G011s
C24010Gm12 = C24010G012s
C24010Gm13 = C24010G013s
C24010Hm1 = C24010H001s
C24010Hm2 = C24010H002s
C24010Hm3 = C24010H003s
C24010Hm4 = C24010H004s
C24010Hm5 = C24010H005s
C24010Hm6 = C24010H006s
C24010Hm7 = C24010H007s
C24010Hm8 = C24010H008s
C24010Hm9 = C24010H009s
C24010Hm10 = C24010H010s
C24010Hm11 = C24010H011s
C24010Hm12 = C24010H012s
C24010Hm13 = C24010H013s
C24010Im1 = C24010I001s
C24010Im2 = C24010I002s
C24010Im3 = C24010I003s
C24010Im4 = C24010I004s
C24010Im5 = C24010I005s
C24010Im6 = C24010I006s
C24010Im7 = C24010I007s
C24010Im8 = C24010I008s
C24010Im9 = C24010I009s
C24010Im10 = C24010I010s
C24010Im11 = C24010I011s
C24010Im12 = C24010I012s
C24010Im13 = C24010I013s
C24010m1 = C24010001s
C24010m2 = C24010002s
C24010m3 = C24010003s
C24010m4 = C24010004s
C24010m5 = C24010005s
C24010m6 = C24010006s
C24010m7 = C24010007s
C24010m8 = C24010008s
C24010m9 = C24010009s
C24010m10 = C24010010s
C24010m11 = C24010011s
C24010m12 = C24010012s
C24010m13 = C24010013s
C24010m14 = C24010014s
C24010m15 = C24010015s
C24010m16 = C24010016s
C24010m17 = C24010017s
C24010m18 = C24010018s
C24010m19 = C24010019s
C24010m20 = C24010020s
C24010m21 = C24010021s
C24010m22 = C24010022s
C24010m23 = C24010023s
C24010m24 = C24010024s
C24010m25 = C24010025s
C24010m26 = C24010026s
C24010m27 = C24010027s
C24010m28 = C24010028s
C24010m29 = C24010029s
C24010m30 = C24010030s
C24010m31 = C24010031s
C24010m32 = C24010032s
C24010m33 = C24010033s
C24010m34 = C24010034s
C24010m35 = C24010035s
C24010m36 = C24010036s
C24010m37 = C24010037s
C24010m38 = C24010038s
C24010m39 = C24010039s
C24010m40 = C24010040s
C24010m41 = C24010041s
C24010m42 = C24010042s
C24010m43 = C24010043s
C24010m44 = C24010044s
C24010m45 = C24010045s
C24010m46 = C24010046s
C24010m47 = C24010047s
C24010m48 = C24010048s
C24010m49 = C24010049s
C24010m50 = C24010050s
C24010m51 = C24010051s
C24010m52 = C24010052s
C24010m53 = C24010053s
C24010m54 = C24010054s
C24010m55 = C24010055s
C24010m56 = C24010056s
C24010m57 = C24010057s
C24010m58 = C24010058s
C24010m59 = C24010059s
C24010m60 = C24010060s
C24010m61 = C24010061s
C24010m62 = C24010062s
C24010m63 = C24010063s
C24010m64 = C24010064s
C24010m65 = C24010065s
C24010m66 = C24010066s
C24010m67 = C24010067s
C24010m68 = C24010068s
C24010m69 = C24010069s
C24010m70 = C24010070s
C24010m71 = C24010071s
C24010m72 = C24010072s
C24010m73 = C24010073s
C24020m1 = C24020001s
C24020m2 = C24020002s
C24020m3 = C24020003s
C24020m4 = C24020004s
C24020m5 = C24020005s
C24020m6 = C24020006s
C24020m7 = C24020007s
C24020m8 = C24020008s
C24020m9 = C24020009s
C24020m10 = C24020010s
C24020m11 = C24020011s
C24020m12 = C24020012s
C24020m13 = C24020013s
C24020m14 = C24020014s
C24020m15 = C24020015s
C24020m16 = C24020016s
C24020m17 = C24020017s
C24020m18 = C24020018s
C24020m19 = C24020019s
C24020m20 = C24020020s
C24020m21 = C24020021s
C24020m22 = C24020022s
C24020m23 = C24020023s
C24020m24 = C24020024s
C24020m25 = C24020025s
C24020m26 = C24020026s
C24020m27 = C24020027s
C24020m28 = C24020028s
C24020m29 = C24020029s
C24020m30 = C24020030s
C24020m31 = C24020031s
C24020m32 = C24020032s
C24020m33 = C24020033s
C24020m34 = C24020034s
C24020m35 = C24020035s
C24020m36 = C24020036s
C24020m37 = C24020037s
C24020m38 = C24020038s
C24020m39 = C24020039s
C24020m40 = C24020040s
C24020m41 = C24020041s
C24020m42 = C24020042s
C24020m43 = C24020043s
C24020m44 = C24020044s
C24020m45 = C24020045s
C24020m46 = C24020046s
C24020m47 = C24020047s
C24020m48 = C24020048s
C24020m49 = C24020049s
C24020m50 = C24020050s
C24020m51 = C24020051s
C24020m52 = C24020052s
C24020m53 = C24020053s
C24020m54 = C24020054s
C24020m55 = C24020055s
C24020m56 = C24020056s
C24020m57 = C24020057s
C24020m58 = C24020058s
C24020m59 = C24020059s
C24020m60 = C24020060s
C24020m61 = C24020061s
C24020m62 = C24020062s
C24020m63 = C24020063s
C24020m64 = C24020064s
C24020m65 = C24020065s
C24020m66 = C24020066s
C24020m67 = C24020067s
C24020m68 = C24020068s
C24020m69 = C24020069s
C24020m70 = C24020070s
C24020m71 = C24020071s
C24020m72 = C24020072s
C24020m73 = C24020073s
C24030m1 = C24030001s
C24030m2 = C24030002s
C24030m3 = C24030003s
C24030m4 = C24030004s
C24030m5 = C24030005s
C24030m6 = C24030006s
C24030m7 = C24030007s
C24030m8 = C24030008s
C24030m9 = C24030009s
C24030m10 = C24030010s
C24030m11 = C24030011s
C24030m12 = C24030012s
C24030m13 = C24030013s
C24030m14 = C24030014s
C24030m15 = C24030015s
C24030m16 = C24030016s
C24030m17 = C24030017s
C24030m18 = C24030018s
C24030m19 = C24030019s
C24030m20 = C24030020s
C24030m21 = C24030021s
C24030m22 = C24030022s
C24030m23 = C24030023s
C24030m24 = C24030024s
C24030m25 = C24030025s
C24030m26 = C24030026s
C24030m27 = C24030027s
C24030m28 = C24030028s
C24030m29 = C24030029s
C24030m30 = C24030030s
C24030m31 = C24030031s
C24030m32 = C24030032s
C24030m33 = C24030033s
C24030m34 = C24030034s
C24030m35 = C24030035s
C24030m36 = C24030036s
C24030m37 = C24030037s
C24030m38 = C24030038s
C24030m39 = C24030039s
C24030m40 = C24030040s
C24030m41 = C24030041s
C24030m42 = C24030042s
C24030m43 = C24030043s
C24030m44 = C24030044s
C24030m45 = C24030045s
C24030m46 = C24030046s
C24030m47 = C24030047s
C24030m48 = C24030048s
C24030m49 = C24030049s
C24030m50 = C24030050s
C24030m51 = C24030051s
C24030m52 = C24030052s
C24030m53 = C24030053s
C24030m54 = C24030054s
C24030m55 = C24030055s
B25001m1 = B25001001s
B25002m1 = B25002001s
B25002m2 = B25002002s
B25002m3 = B25002003s
B25003Am1 = B25003A001s
B25003Am2 = B25003A002s
B25003Am3 = B25003A003s
B25003Bm1 = B25003B001s
B25003Bm2 = B25003B002s
B25003Bm3 = B25003B003s
B25003Cm1 = B25003C001s
B25003Cm2 = B25003C002s
B25003Cm3 = B25003C003s
B25003Dm1 = B25003D001s
B25003Dm2 = B25003D002s
B25003Dm3 = B25003D003s
B25003Em1 = B25003E001s
B25003Em2 = B25003E002s
B25003Em3 = B25003E003s
B25003Fm1 = B25003F001s
B25003Fm2 = B25003F002s
B25003Fm3 = B25003F003s
B25003Gm1 = B25003G001s
B25003Gm2 = B25003G002s
B25003Gm3 = B25003G003s
B25003Hm1 = B25003H001s
B25003Hm2 = B25003H002s
B25003Hm3 = B25003H003s
B25003Im1 = B25003I001s
B25003Im2 = B25003I002s
B25003Im3 = B25003I003s
B25003m1 = B25003001s
B25003m2 = B25003002s
B25003m3 = B25003003s
B25004m1 = B25004001s
B25004m2 = B25004002s
B25004m3 = B25004003s
B25004m4 = B25004004s
B25004m5 = B25004005s
B25004m6 = B25004006s
B25004m7 = B25004007s
B25004m8 = B25004008s
B25006m1 = B25006001s
B25006m2 = B25006002s
B25006m3 = B25006003s
B25006m4 = B25006004s
B25006m5 = B25006005s
B25006m6 = B25006006s
B25006m7 = B25006007s
B25006m8 = B25006008s
B25006m9 = B25006009s
B25006m10 = B25006010s
B25007m1 = B25007001s
B25007m2 = B25007002s
B25007m3 = B25007003s
B25007m4 = B25007004s
B25007m5 = B25007005s
B25007m6 = B25007006s
B25007m7 = B25007007s
B25007m8 = B25007008s
B25007m9 = B25007009s
B25007m10 = B25007010s
B25007m11 = B25007011s
B25007m12 = B25007012s
B25007m13 = B25007013s
B25007m14 = B25007014s
B25007m15 = B25007015s
B25007m16 = B25007016s
B25007m17 = B25007017s
B25007m18 = B25007018s
B25007m19 = B25007019s
B25007m20 = B25007020s
B25007m21 = B25007021s
B25008m1 = B25008001s
B25008m2 = B25008002s
B25008m3 = B25008003s
B25009m1 = B25009001s
B25009m2 = B25009002s
B25009m3 = B25009003s
B25009m4 = B25009004s
B25009m5 = B25009005s
B25009m6 = B25009006s
B25009m7 = B25009007s
B25009m8 = B25009008s
B25009m9 = B25009009s
B25009m10 = B25009010s
B25009m11 = B25009011s
B25009m12 = B25009012s
B25009m13 = B25009013s
B25009m14 = B25009014s
B25009m15 = B25009015s
B25009m16 = B25009016s
B25009m17 = B25009017s
B25010m1 = B25010001s
B25010m2 = B25010002s
B25010m3 = B25010003s
B25014m1 = B25014001s
B25014m2 = B25014002s
B25014m3 = B25014003s
B25014m4 = B25014004s
B25014m5 = B25014005s
B25014m6 = B25014006s
B25014m7 = B25014007s
B25014m8 = B25014008s
B25014m9 = B25014009s
B25014m10 = B25014010s
B25014m11 = B25014011s
B25014m12 = B25014012s
B25014m13 = B25014013s
B25015m1 = B25015001s
B25015m2 = B25015002s
B25015m3 = B25015003s
B25015m4 = B25015004s
B25015m5 = B25015005s
B25015m6 = B25015006s
B25015m7 = B25015007s
B25015m8 = B25015008s
B25015m9 = B25015009s
B25015m10 = B25015010s
B25015m11 = B25015011s
B25015m12 = B25015012s
B25015m13 = B25015013s
B25015m14 = B25015014s
B25015m15 = B25015015s
B25015m16 = B25015016s
B25015m17 = B25015017s
B25015m18 = B25015018s
B25015m19 = B25015019s
B25015m20 = B25015020s
B25015m21 = B25015021s
B25015m22 = B25015022s
B25015m23 = B25015023s
B25015m24 = B25015024s
B25015m25 = B25015025s
B25015m26 = B25015026s
B25015m27 = B25015027s
B25016m1 = B25016001s
B25016m2 = B25016002s
B25016m3 = B25016003s
B25016m4 = B25016004s
B25016m5 = B25016005s
B25016m6 = B25016006s
B25016m7 = B25016007s
B25016m8 = B25016008s
B25016m9 = B25016009s
B25016m10 = B25016010s
B25016m11 = B25016011s
B25016m12 = B25016012s
B25016m13 = B25016013s
B25016m14 = B25016014s
B25016m15 = B25016015s
B25016m16 = B25016016s
B25016m17 = B25016017s
B25016m18 = B25016018s
B25016m19 = B25016019s
B25017m1 = B25017001s
B25017m2 = B25017002s
B25017m3 = B25017003s
B25017m4 = B25017004s
B25017m5 = B25017005s
B25017m6 = B25017006s
B25017m7 = B25017007s
B25017m8 = B25017008s
B25017m9 = B25017009s
B25017m10 = B25017010s
B25018m1 = B25018001s
B25019m1 = B25019001s
B25020m1 = B25020001s
B25020m2 = B25020002s
B25020m3 = B25020003s
B25020m4 = B25020004s
B25020m5 = B25020005s
B25020m6 = B25020006s
B25020m7 = B25020007s
B25020m8 = B25020008s
B25020m9 = B25020009s
B25020m10 = B25020010s
B25020m11 = B25020011s
B25020m12 = B25020012s
B25020m13 = B25020013s
B25020m14 = B25020014s
B25020m15 = B25020015s
B25020m16 = B25020016s
B25020m17 = B25020017s
B25020m18 = B25020018s
B25020m19 = B25020019s
B25020m20 = B25020020s
B25020m21 = B25020021s
B25021m1 = B25021001s
B25021m2 = B25021002s
B25021m3 = B25021003s
B25022m1 = B25022001s
B25022m2 = B25022002s
B25022m3 = B25022003s
B25024m1 = B25024001s
B25024m2 = B25024002s
B25024m3 = B25024003s
B25024m4 = B25024004s
B25024m5 = B25024005s
B25024m6 = B25024006s
B25024m7 = B25024007s
B25024m8 = B25024008s
B25024m9 = B25024009s
B25024m10 = B25024010s
B25024m11 = B25024011s
B25032m1 = B25032001s
B25032m2 = B25032002s
B25032m3 = B25032003s
B25032m4 = B25032004s
B25032m5 = B25032005s
B25032m6 = B25032006s
B25032m7 = B25032007s
B25032m8 = B25032008s
B25032m9 = B25032009s
B25032m10 = B25032010s
B25032m11 = B25032011s
B25032m12 = B25032012s
B25032m13 = B25032013s
B25032m14 = B25032014s
B25032m15 = B25032015s
B25032m16 = B25032016s
B25032m17 = B25032017s
B25032m18 = B25032018s
B25032m19 = B25032019s
B25032m20 = B25032020s
B25032m21 = B25032021s
B25032m22 = B25032022s
B25032m23 = B25032023s
B25033m1 = B25033001s
B25033m2 = B25033002s
B25033m3 = B25033003s
B25033m4 = B25033004s
B25033m5 = B25033005s
B25033m6 = B25033006s
B25033m7 = B25033007s
B25033m8 = B25033008s
B25033m9 = B25033009s
B25033m10 = B25033010s
B25033m11 = B25033011s
B25033m12 = B25033012s
B25033m13 = B25033013s
B25034m1 = B25034001s
B25034m2 = B25034002s
B25034m3 = B25034003s
B25034m4 = B25034004s
B25034m5 = B25034005s
B25034m6 = B25034006s
B25034m7 = B25034007s
B25034m8 = B25034008s
B25034m9 = B25034009s
B25034m10 = B25034010s
B25034m11 = B25034011s
B25035m1 = B25035001s
B25036m1 = B25036001s
B25036m2 = B25036002s
B25036m3 = B25036003s
B25036m4 = B25036004s
B25036m5 = B25036005s
B25036m6 = B25036006s
B25036m7 = B25036007s
B25036m8 = B25036008s
B25036m9 = B25036009s
B25036m10 = B25036010s
B25036m11 = B25036011s
B25036m12 = B25036012s
B25036m13 = B25036013s
B25036m14 = B25036014s
B25036m15 = B25036015s
B25036m16 = B25036016s
B25036m17 = B25036017s
B25036m18 = B25036018s
B25036m19 = B25036019s
B25036m20 = B25036020s
B25036m21 = B25036021s
B25036m22 = B25036022s
B25036m23 = B25036023s
B25037m1 = B25037001s
B25037m2 = B25037002s
B25037m3 = B25037003s
B25038m1 = B25038001s
B25038m2 = B25038002s
B25038m3 = B25038003s
B25038m4 = B25038004s
B25038m5 = B25038005s
B25038m6 = B25038006s
B25038m7 = B25038007s
B25038m8 = B25038008s
B25038m9 = B25038009s
B25038m10 = B25038010s
B25038m11 = B25038011s
B25038m12 = B25038012s
B25038m13 = B25038013s
B25038m14 = B25038014s
B25038m15 = B25038015s
B25039m1 = B25039001s
B25039m2 = B25039002s
B25039m3 = B25039003s
B25040m1 = B25040001s
B25040m2 = B25040002s
B25040m3 = B25040003s
B25040m4 = B25040004s
B25040m5 = B25040005s
B25040m6 = B25040006s
B25040m7 = B25040007s
B25040m8 = B25040008s
B25040m9 = B25040009s
B25040m10 = B25040010s
B25041m1 = B25041001s
B25041m2 = B25041002s
B25041m3 = B25041003s
B25041m4 = B25041004s
B25041m5 = B25041005s
B25041m6 = B25041006s
B25041m7 = B25041007s
B25042m1 = B25042001s
B25042m2 = B25042002s
B25042m3 = B25042003s
B25042m4 = B25042004s
B25042m5 = B25042005s
B25042m6 = B25042006s
B25042m7 = B25042007s
B25042m8 = B25042008s
B25042m9 = B25042009s
B25042m10 = B25042010s
B25042m11 = B25042011s
B25042m12 = B25042012s
B25042m13 = B25042013s
B25042m14 = B25042014s
B25042m15 = B25042015s
B25043m1 = B25043001s
B25043m2 = B25043002s
B25043m3 = B25043003s
B25043m4 = B25043004s
B25043m5 = B25043005s
B25043m6 = B25043006s
B25043m7 = B25043007s
B25043m8 = B25043008s
B25043m9 = B25043009s
B25043m10 = B25043010s
B25043m11 = B25043011s
B25043m12 = B25043012s
B25043m13 = B25043013s
B25043m14 = B25043014s
B25043m15 = B25043015s
B25043m16 = B25043016s
B25043m17 = B25043017s
B25043m18 = B25043018s
B25043m19 = B25043019s
B25044m1 = B25044001s
B25044m2 = B25044002s
B25044m3 = B25044003s
B25044m4 = B25044004s
B25044m5 = B25044005s
B25044m6 = B25044006s
B25044m7 = B25044007s
B25044m8 = B25044008s
B25044m9 = B25044009s
B25044m10 = B25044010s
B25044m11 = B25044011s
B25044m12 = B25044012s
B25044m13 = B25044013s
B25044m14 = B25044014s
B25044m15 = B25044015s
B25045m1 = B25045001s
B25045m2 = B25045002s
B25045m3 = B25045003s
B25045m4 = B25045004s
B25045m5 = B25045005s
B25045m6 = B25045006s
B25045m7 = B25045007s
B25045m8 = B25045008s
B25045m9 = B25045009s
B25045m10 = B25045010s
B25045m11 = B25045011s
B25045m12 = B25045012s
B25045m13 = B25045013s
B25045m14 = B25045014s
B25045m15 = B25045015s
B25045m16 = B25045016s
B25045m17 = B25045017s
B25045m18 = B25045018s
B25045m19 = B25045019s
B25046m1 = B25046001s
B25046m2 = B25046002s
B25046m3 = B25046003s
B25047m1 = B25047001s
B25047m2 = B25047002s
B25047m3 = B25047003s
B25049m1 = B25049001s
B25049m2 = B25049002s
B25049m3 = B25049003s
B25049m4 = B25049004s
B25049m5 = B25049005s
B25049m6 = B25049006s
B25049m7 = B25049007s
B25050m1 = B25050001s
B25050m2 = B25050002s
B25050m3 = B25050003s
B25050m4 = B25050004s
B25050m5 = B25050005s
B25050m6 = B25050006s
B25050m7 = B25050007s
B25050m8 = B25050008s
B25050m9 = B25050009s
B25050m10 = B25050010s
B25050m11 = B25050011s
B25050m12 = B25050012s
B25050m13 = B25050013s
B25050m14 = B25050014s
B25050m15 = B25050015s
B25050m16 = B25050016s
B25050m17 = B25050017s
B25050m18 = B25050018s
B25050m19 = B25050019s
B25051m1 = B25051001s
B25051m2 = B25051002s
B25051m3 = B25051003s
B25053m1 = B25053001s
B25053m2 = B25053002s
B25053m3 = B25053003s
B25053m4 = B25053004s
B25053m5 = B25053005s
B25053m6 = B25053006s
B25053m7 = B25053007s
B25054m1 = B25054001s
B25054m2 = B25054002s
B25054m3 = B25054003s
B25054m4 = B25054004s
B25054m5 = B25054005s
B25054m6 = B25054006s
B25054m7 = B25054007s
B25055m1 = B25055001s
B25055m2 = B25055002s
B25055m3 = B25055003s
B25055m4 = B25055004s
B25055m5 = B25055005s
B25055m6 = B25055006s
B25055m7 = B25055007s
B25055m8 = B25055008s
B25055m9 = B25055009s
B25055m10 = B25055010s
B25055m11 = B25055011s
B25055m12 = B25055012s
B25055m13 = B25055013s
B25056m1 = B25056001s
B25056m2 = B25056002s
B25056m3 = B25056003s
B25056m4 = B25056004s
B25056m5 = B25056005s
B25056m6 = B25056006s
B25056m7 = B25056007s
B25056m8 = B25056008s
B25056m9 = B25056009s
B25056m10 = B25056010s
B25056m11 = B25056011s
B25056m12 = B25056012s
B25056m13 = B25056013s
B25056m14 = B25056014s
B25056m15 = B25056015s
B25056m16 = B25056016s
B25056m17 = B25056017s
B25056m18 = B25056018s
B25056m19 = B25056019s
B25056m20 = B25056020s
B25056m21 = B25056021s
B25056m22 = B25056022s
B25056m23 = B25056023s
B25056m24 = B25056024s
B25056m25 = B25056025s
B25056m26 = B25056026s
B25056m27 = B25056027s
B25057m1 = B25057001s
B25058m1 = B25058001s
B25059m1 = B25059001s
B25060m1 = B25060001s
B25061m1 = B25061001s
B25061m2 = B25061002s
B25061m3 = B25061003s
B25061m4 = B25061004s
B25061m5 = B25061005s
B25061m6 = B25061006s
B25061m7 = B25061007s
B25061m8 = B25061008s
B25061m9 = B25061009s
B25061m10 = B25061010s
B25061m11 = B25061011s
B25061m12 = B25061012s
B25061m13 = B25061013s
B25061m14 = B25061014s
B25061m15 = B25061015s
B25061m16 = B25061016s
B25061m17 = B25061017s
B25061m18 = B25061018s
B25061m19 = B25061019s
B25061m20 = B25061020s
B25061m21 = B25061021s
B25061m22 = B25061022s
B25061m23 = B25061023s
B25061m24 = B25061024s
B25061m25 = B25061025s
B25062m1 = B25062001s
B25063m1 = B25063001s
B25063m2 = B25063002s
B25063m3 = B25063003s
B25063m4 = B25063004s
B25063m5 = B25063005s
B25063m6 = B25063006s
B25063m7 = B25063007s
B25063m8 = B25063008s
B25063m9 = B25063009s
B25063m10 = B25063010s
B25063m11 = B25063011s
B25063m12 = B25063012s
B25063m13 = B25063013s
B25063m14 = B25063014s
B25063m15 = B25063015s
B25063m16 = B25063016s
B25063m17 = B25063017s
B25063m18 = B25063018s
B25063m19 = B25063019s
B25063m20 = B25063020s
B25063m21 = B25063021s
B25063m22 = B25063022s
B25063m23 = B25063023s
B25063m24 = B25063024s
B25063m25 = B25063025s
B25063m26 = B25063026s
B25063m27 = B25063027s
B25064m1 = B25064001s
B25065m1 = B25065001s
B25066m1 = B25066001s
B25066m2 = B25066002s
B25066m3 = B25066003s
B25066m4 = B25066004s
B25066m5 = B25066005s
B25066m6 = B25066006s
B25066m7 = B25066007s
B25066m8 = B25066008s
B25067m1 = B25067001s
B25067m2 = B25067002s
B25067m3 = B25067003s
B25068m1 = B25068001s
B25068m2 = B25068002s
B25068m3 = B25068003s
B25068m4 = B25068004s
B25068m5 = B25068005s
B25068m6 = B25068006s
B25068m7 = B25068007s
B25068m8 = B25068008s
B25068m9 = B25068009s
B25068m10 = B25068010s
B25068m11 = B25068011s
B25068m12 = B25068012s
B25068m13 = B25068013s
B25068m14 = B25068014s
B25068m15 = B25068015s
B25068m16 = B25068016s
B25068m17 = B25068017s
B25068m18 = B25068018s
B25068m19 = B25068019s
B25068m20 = B25068020s
B25068m21 = B25068021s
B25068m22 = B25068022s
B25068m23 = B25068023s
B25068m24 = B25068024s
B25068m25 = B25068025s
B25068m26 = B25068026s
B25068m27 = B25068027s
B25068m28 = B25068028s
B25068m29 = B25068029s
B25068m30 = B25068030s
B25068m31 = B25068031s
B25068m32 = B25068032s
B25068m33 = B25068033s
B25068m34 = B25068034s
B25068m35 = B25068035s
B25068m36 = B25068036s
B25068m37 = B25068037s
B25069m1 = B25069001s
B25069m2 = B25069002s
B25069m3 = B25069003s
B25070m1 = B25070001s
B25070m2 = B25070002s
B25070m3 = B25070003s
B25070m4 = B25070004s
B25070m5 = B25070005s
B25070m6 = B25070006s
B25070m7 = B25070007s
B25070m8 = B25070008s
B25070m9 = B25070009s
B25070m10 = B25070010s
B25070m11 = B25070011s
B25071m1 = B25071001s
B25072m1 = B25072001s
B25072m2 = B25072002s
B25072m3 = B25072003s
B25072m4 = B25072004s
B25072m5 = B25072005s
B25072m6 = B25072006s
B25072m7 = B25072007s
B25072m8 = B25072008s
B25072m9 = B25072009s
B25072m10 = B25072010s
B25072m11 = B25072011s
B25072m12 = B25072012s
B25072m13 = B25072013s
B25072m14 = B25072014s
B25072m15 = B25072015s
B25072m16 = B25072016s
B25072m17 = B25072017s
B25072m18 = B25072018s
B25072m19 = B25072019s
B25072m20 = B25072020s
B25072m21 = B25072021s
B25072m22 = B25072022s
B25072m23 = B25072023s
B25072m24 = B25072024s
B25072m25 = B25072025s
B25072m26 = B25072026s
B25072m27 = B25072027s
B25072m28 = B25072028s
B25072m29 = B25072029s
B25074m1 = B25074001s
B25074m2 = B25074002s
B25074m3 = B25074003s
B25074m4 = B25074004s
B25074m5 = B25074005s
B25074m6 = B25074006s
B25074m7 = B25074007s
B25074m8 = B25074008s
B25074m9 = B25074009s
B25074m10 = B25074010s
B25074m11 = B25074011s
B25074m12 = B25074012s
B25074m13 = B25074013s
B25074m14 = B25074014s
B25074m15 = B25074015s
B25074m16 = B25074016s
B25074m17 = B25074017s
B25074m18 = B25074018s
B25074m19 = B25074019s
B25074m20 = B25074020s
B25074m21 = B25074021s
B25074m22 = B25074022s
B25074m23 = B25074023s
B25074m24 = B25074024s
B25074m25 = B25074025s
B25074m26 = B25074026s
B25074m27 = B25074027s
B25074m28 = B25074028s
B25074m29 = B25074029s
B25074m30 = B25074030s
B25074m31 = B25074031s
B25074m32 = B25074032s
B25074m33 = B25074033s
B25074m34 = B25074034s
B25074m35 = B25074035s
B25074m36 = B25074036s
B25074m37 = B25074037s
B25074m38 = B25074038s
B25074m39 = B25074039s
B25074m40 = B25074040s
B25074m41 = B25074041s
B25074m42 = B25074042s
B25074m43 = B25074043s
B25074m44 = B25074044s
B25074m45 = B25074045s
B25074m46 = B25074046s
B25074m47 = B25074047s
B25074m48 = B25074048s
B25074m49 = B25074049s
B25074m50 = B25074050s
B25074m51 = B25074051s
B25074m52 = B25074052s
B25074m53 = B25074053s
B25074m54 = B25074054s
B25074m55 = B25074055s
B25074m56 = B25074056s
B25074m57 = B25074057s
B25074m58 = B25074058s
B25074m59 = B25074059s
B25074m60 = B25074060s
B25074m61 = B25074061s
B25074m62 = B25074062s
B25074m63 = B25074063s
B25074m64 = B25074064s
B25075m1 = B25075001s
B25075m2 = B25075002s
B25075m3 = B25075003s
B25075m4 = B25075004s
B25075m5 = B25075005s
B25075m6 = B25075006s
B25075m7 = B25075007s
B25075m8 = B25075008s
B25075m9 = B25075009s
B25075m10 = B25075010s
B25075m11 = B25075011s
B25075m12 = B25075012s
B25075m13 = B25075013s
B25075m14 = B25075014s
B25075m15 = B25075015s
B25075m16 = B25075016s
B25075m17 = B25075017s
B25075m18 = B25075018s
B25075m19 = B25075019s
B25075m20 = B25075020s
B25075m21 = B25075021s
B25075m22 = B25075022s
B25075m23 = B25075023s
B25075m24 = B25075024s
B25075m25 = B25075025s
B25075m26 = B25075026s
B25075m27 = B25075027s
B25076m1 = B25076001s
B25077m1 = B25077001s
B25078m1 = B25078001s
B25079m1 = B25079001s
B25079m2 = B25079002s
B25079m3 = B25079003s
B25079m4 = B25079004s
B25079m5 = B25079005s
B25080m1 = B25080001s
B25080m2 = B25080002s
B25080m3 = B25080003s
B25080m4 = B25080004s
B25080m5 = B25080005s
B25080m6 = B25080006s
B25080m7 = B25080007s
B25080m8 = B25080008s
B25081m1 = B25081001s
B25081m2 = B25081002s
B25081m3 = B25081003s
B25081m4 = B25081004s
B25081m5 = B25081005s
B25081m6 = B25081006s
B25081m7 = B25081007s
B25081m8 = B25081008s
B25082m1 = B25082001s
B25082m2 = B25082002s
B25082m3 = B25082003s
B25083m1 = B25083001s
B25085m1 = B25085001s
B25085m2 = B25085002s
B25085m3 = B25085003s
B25085m4 = B25085004s
B25085m5 = B25085005s
B25085m6 = B25085006s
B25085m7 = B25085007s
B25085m8 = B25085008s
B25085m9 = B25085009s
B25085m10 = B25085010s
B25085m11 = B25085011s
B25085m12 = B25085012s
B25085m13 = B25085013s
B25085m14 = B25085014s
B25085m15 = B25085015s
B25085m16 = B25085016s
B25085m17 = B25085017s
B25085m18 = B25085018s
B25085m19 = B25085019s
B25085m20 = B25085020s
B25085m21 = B25085021s
B25085m22 = B25085022s
B25085m23 = B25085023s
B25085m24 = B25085024s
B25085m25 = B25085025s
B25085m26 = B25085026s
B25085m27 = B25085027s
B25087m1 = B25087001s
B25087m2 = B25087002s
B25087m3 = B25087003s
B25087m4 = B25087004s
B25087m5 = B25087005s
B25087m6 = B25087006s
B25087m7 = B25087007s
B25087m8 = B25087008s
B25087m9 = B25087009s
B25087m10 = B25087010s
B25087m11 = B25087011s
B25087m12 = B25087012s
B25087m13 = B25087013s
B25087m14 = B25087014s
B25087m15 = B25087015s
B25087m16 = B25087016s
B25087m17 = B25087017s
B25087m18 = B25087018s
B25087m19 = B25087019s
B25087m20 = B25087020s
B25087m21 = B25087021s
B25087m22 = B25087022s
B25087m23 = B25087023s
B25087m24 = B25087024s
B25087m25 = B25087025s
B25087m26 = B25087026s
B25087m27 = B25087027s
B25087m28 = B25087028s
B25087m29 = B25087029s
B25087m30 = B25087030s
B25087m31 = B25087031s
B25087m32 = B25087032s
B25087m33 = B25087033s
B25087m34 = B25087034s
B25087m35 = B25087035s
B25087m36 = B25087036s
B25087m37 = B25087037s
B25087m38 = B25087038s
B25087m39 = B25087039s
B25088m1 = B25088001s
B25088m2 = B25088002s
B25088m3 = B25088003s
B25089m1 = B25089001s
B25089m2 = B25089002s
B25089m3 = B25089003s
B25091m1 = B25091001s
B25091m2 = B25091002s
B25091m3 = B25091003s
B25091m4 = B25091004s
B25091m5 = B25091005s
B25091m6 = B25091006s
B25091m7 = B25091007s
B25091m8 = B25091008s
B25091m9 = B25091009s
B25091m10 = B25091010s
B25091m11 = B25091011s
B25091m12 = B25091012s
B25091m13 = B25091013s
B25091m14 = B25091014s
B25091m15 = B25091015s
B25091m16 = B25091016s
B25091m17 = B25091017s
B25091m18 = B25091018s
B25091m19 = B25091019s
B25091m20 = B25091020s
B25091m21 = B25091021s
B25091m22 = B25091022s
B25091m23 = B25091023s
B25092m1 = B25092001s
B25092m2 = B25092002s
B25092m3 = B25092003s
B25093m1 = B25093001s
B25093m2 = B25093002s
B25093m3 = B25093003s
B25093m4 = B25093004s
B25093m5 = B25093005s
B25093m6 = B25093006s
B25093m7 = B25093007s
B25093m8 = B25093008s
B25093m9 = B25093009s
B25093m10 = B25093010s
B25093m11 = B25093011s
B25093m12 = B25093012s
B25093m13 = B25093013s
B25093m14 = B25093014s
B25093m15 = B25093015s
B25093m16 = B25093016s
B25093m17 = B25093017s
B25093m18 = B25093018s
B25093m19 = B25093019s
B25093m20 = B25093020s
B25093m21 = B25093021s
B25093m22 = B25093022s
B25093m23 = B25093023s
B25093m24 = B25093024s
B25093m25 = B25093025s
B25093m26 = B25093026s
B25093m27 = B25093027s
B25093m28 = B25093028s
B25093m29 = B25093029s
B27010m1 = B27010001s
B27010m2 = B27010002s
B27010m3 = B27010003s
B27010m4 = B27010004s
B27010m5 = B27010005s
B27010m6 = B27010006s
B27010m7 = B27010007s
B27010m8 = B27010008s
B27010m9 = B27010009s
B27010m10 = B27010010s
B27010m11 = B27010011s
B27010m12 = B27010012s
B27010m13 = B27010013s
B27010m14 = B27010014s
B27010m15 = B27010015s
B27010m16 = B27010016s
B27010m17 = B27010017s
B27010m18 = B27010018s
B27010m19 = B27010019s
B27010m20 = B27010020s
B27010m21 = B27010021s
B27010m22 = B27010022s
B27010m23 = B27010023s
B27010m24 = B27010024s
B27010m25 = B27010025s
B27010m26 = B27010026s
B27010m27 = B27010027s
B27010m28 = B27010028s
B27010m29 = B27010029s
B27010m30 = B27010030s
B27010m31 = B27010031s
B27010m32 = B27010032s
B27010m33 = B27010033s
B27010m34 = B27010034s
B27010m35 = B27010035s
B27010m36 = B27010036s
B27010m37 = B27010037s
B27010m38 = B27010038s
B27010m39 = B27010039s
B27010m40 = B27010040s
B27010m41 = B27010041s
B27010m42 = B27010042s
B27010m43 = B27010043s
B27010m44 = B27010044s
B27010m45 = B27010045s
B27010m46 = B27010046s
B27010m47 = B27010047s
B27010m48 = B27010048s
B27010m49 = B27010049s
B27010m50 = B27010050s
B27010m51 = B27010051s
B27010m52 = B27010052s
B27010m53 = B27010053s
B27010m54 = B27010054s
B27010m55 = B27010055s
B27010m56 = B27010056s
B27010m57 = B27010057s
B27010m58 = B27010058s
B27010m59 = B27010059s
B27010m60 = B27010060s
B27010m61 = B27010061s
B27010m62 = B27010062s
B27010m63 = B27010063s
B27010m64 = B27010064s
B27010m65 = B27010065s
B27010m66 = B27010066s
B28001m1 = B28001001s
B28001m2 = B28001002s
B28001m3 = B28001003s
B28001m4 = B28001004s
B28001m5 = B28001005s
B28001m6 = B28001006s
B28001m7 = B28001007s
B28001m8 = B28001008s
B28001m9 = B28001009s
B28001m10 = B28001010s
B28001m11 = B28001011s
B28002m1 = B28002001s
B28002m2 = B28002002s
B28002m3 = B28002003s
B28002m4 = B28002004s
B28002m5 = B28002005s
B28002m6 = B28002006s
B28002m7 = B28002007s
B28002m8 = B28002008s
B28002m9 = B28002009s
B28002m10 = B28002010s
B28002m11 = B28002011s
B28002m12 = B28002012s
B28002m13 = B28002013s
B28003m1 = B28003001s
B28003m2 = B28003002s
B28003m3 = B28003003s
B28003m4 = B28003004s
B28003m5 = B28003005s
B28003m6 = B28003006s
B28004m1 = B28004001s
B28004m2 = B28004002s
B28004m3 = B28004003s
B28004m4 = B28004004s
B28004m5 = B28004005s
B28004m6 = B28004006s
B28004m7 = B28004007s
B28004m8 = B28004008s
B28004m9 = B28004009s
B28004m10 = B28004010s
B28004m11 = B28004011s
B28004m12 = B28004012s
B28004m13 = B28004013s
B28004m14 = B28004014s
B28004m15 = B28004015s
B28004m16 = B28004016s
B28004m17 = B28004017s
B28004m18 = B28004018s
B28004m19 = B28004019s
B28004m20 = B28004020s
B28004m21 = B28004021s
B28004m22 = B28004022s
B28004m23 = B28004023s
B28004m24 = B28004024s
B28004m25 = B28004025s
B28005m1 = B28005001s
B28005m2 = B28005002s
B28005m3 = B28005003s
B28005m4 = B28005004s
B28005m5 = B28005005s
B28005m6 = B28005006s
B28005m7 = B28005007s
B28005m8 = B28005008s
B28005m9 = B28005009s
B28005m10 = B28005010s
B28005m11 = B28005011s
B28005m12 = B28005012s
B28005m13 = B28005013s
B28005m14 = B28005014s
B28005m15 = B28005015s
B28005m16 = B28005016s
B28005m17 = B28005017s
B28005m18 = B28005018s
B28005m19 = B28005019s
B28006m1 = B28006001s
B28006m2 = B28006002s
B28006m3 = B28006003s
B28006m4 = B28006004s
B28006m5 = B28006005s
B28006m6 = B28006006s
B28006m7 = B28006007s
B28006m8 = B28006008s
B28006m9 = B28006009s
B28006m10 = B28006010s
B28006m11 = B28006011s
B28006m12 = B28006012s
B28006m13 = B28006013s
B28006m14 = B28006014s
B28006m15 = B28006015s
B28006m16 = B28006016s
B28006m17 = B28006017s
B28006m18 = B28006018s
B28006m19 = B28006019s
B28007m1 = B28007001s
B28007m2 = B28007002s
B28007m3 = B28007003s
B28007m4 = B28007004s
B28007m5 = B28007005s
B28007m6 = B28007006s
B28007m7 = B28007007s
B28007m8 = B28007008s
B28007m9 = B28007009s
B28007m10 = B28007010s
B28007m11 = B28007011s
B28007m12 = B28007012s
B28007m13 = B28007013s
B28007m14 = B28007014s
B28007m15 = B28007015s
B28007m16 = B28007016s
B28007m17 = B28007017s
B28007m18 = B28007018s
B28007m19 = B28007019s
B28007m20 = B28007020s
B28008m1 = B28008001s
B28008m2 = B28008002s
B28008m3 = B28008003s
B28008m4 = B28008004s
B28008m5 = B28008005s
B28008m6 = B28008006s
B28008m7 = B28008007s
B28008m8 = B28008008s
B28008m9 = B28008009s
B28008m10 = B28008010s
B28009Am1 = B28009A001s
B28009Am2 = B28009A002s
B28009Am3 = B28009A003s
B28009Am4 = B28009A004s
B28009Am5 = B28009A005s
B28009Am6 = B28009A006s
B28009Bm1 = B28009B001s
B28009Bm2 = B28009B002s
B28009Bm3 = B28009B003s
B28009Bm4 = B28009B004s
B28009Bm5 = B28009B005s
B28009Bm6 = B28009B006s
B28009Cm1 = B28009C001s
B28009Cm2 = B28009C002s
B28009Cm3 = B28009C003s
B28009Cm4 = B28009C004s
B28009Cm5 = B28009C005s
B28009Cm6 = B28009C006s
B28009Dm1 = B28009D001s
B28009Dm2 = B28009D002s
B28009Dm3 = B28009D003s
B28009Dm4 = B28009D004s
B28009Dm5 = B28009D005s
B28009Dm6 = B28009D006s
B28009Em1 = B28009E001s
B28009Em2 = B28009E002s
B28009Em3 = B28009E003s
B28009Em4 = B28009E004s
B28009Em5 = B28009E005s
B28009Em6 = B28009E006s
B28009Fm1 = B28009F001s
B28009Fm2 = B28009F002s
B28009Fm3 = B28009F003s
B28009Fm4 = B28009F004s
B28009Fm5 = B28009F005s
B28009Fm6 = B28009F006s
B28009Gm1 = B28009G001s
B28009Gm2 = B28009G002s
B28009Gm3 = B28009G003s
B28009Gm4 = B28009G004s
B28009Gm5 = B28009G005s
B28009Gm6 = B28009G006s
B28009Hm1 = B28009H001s
B28009Hm2 = B28009H002s
B28009Hm3 = B28009H003s
B28009Hm4 = B28009H004s
B28009Hm5 = B28009H005s
B28009Hm6 = B28009H006s
B28009Im1 = B28009I001s
B28009Im2 = B28009I002s
B28009Im3 = B28009I003s
B28009Im4 = B28009I004s
B28009Im5 = B28009I005s
B28009Im6 = B28009I006s
B28010m1 = B28010001s
B28010m2 = B28010002s
B28010m3 = B28010003s
B28010m4 = B28010004s
B28010m5 = B28010005s
B28010m6 = B28010006s
B28010m7 = B28010007s
B28011m1 = B28011001s
B28011m2 = B28011002s
B28011m3 = B28011003s
B28011m4 = B28011004s
B28011m5 = B28011005s
B28011m6 = B28011006s
B28011m7 = B28011007s
B28011m8 = B28011008s
;
%mend;
