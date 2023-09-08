dm log 'clear';

libname ds "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

* ALL VARIABLES ABOVE ARE PRESENT IN DATA AS SPELLED ;

/*proc contents data = ds.acs_bg_ct varnum; run;*/

/*

Vars to get: 
	Not a citizen:
		*B05001 - Citizenship Status in the United States
		B05005 - Year of Entry by Citizenship Status in the United States
		B05007 - Place of Birth by Citizenship Status
	Foreign born:
		B05002 - Place Of Birth By Nativity And Citizenship Status

		Ready at CT level?
			Moved w/n a year:
			Gini Index:
*/

/* Notes/Questions

Gini index available at the census tract level from 2006-2010 to 2008-2012, available at block group for 2009-2013, census
tract for 2010-2014, and the block group after that.

*/

data ds.acs_raw_newvars;
  set ds.acs_raw;

		/*Total Population*/

		total_pop = B01001001; /*Total Population*/
		label total_pop = "Count of Total Population";

		total_pop_moe = B01001001s; /*Total Population*/
		label total_pop_moe = "[Margin of Error]Count of Total Population";


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

		age_45_74_moe = 
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

		label age_45_74_moe = "[Margin of Error]Count of population ages 45 to 74 years";

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

		age_ge65_moe = 
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
			) / 
			B01001001s /*Total Population*/;

		label age_ge65_moe = "[Margin of Error]Percent of population ages 65 years and older";


		/*Sex*/

		male = 
			B01001002 /*Males*/ / 
			B01001001 /*Total Population*/;

		label male = "Proportion of geographic unit who are male";

		female = 
			B01001026 /*Females*/ / 
			B01001001 /*Total Population*/;

		label female = "Proportion of geographic unit who are female";

		male_moe = 
			B01001002s /*Males*/ / 
			B01001001s /*Total Population*/;

		label male_moe = "[Margin of Error]Proportion of geographic unit who are male";

		female_moe = 
			B01001026s /*Females*/ / 
			B01001001s /*Total Population*/;

		label female_moe = "[Margin of Error]Proportion of geographic unit who are female";


		/*Race*/

		white = 
			B02001002 /*White alone*/ / 
			B01001001 /*Total Population*/;

		label white = "Proportion of geographic unit who are recorded as White";


		black = 
			B02001003 /*Black or African American Alone*/ / 
			B01001001 /*Total Population*/; 

		label black = "Proportion of geographic unit who are recorded as Black";


		asian_pacislander = 
		   (B02001005 /*Asian Alone*/ + 
			B02001006 /*Native Hawaiian and Other Pacific Islander Alone*/) / 
			B01001001 /*Total Population*/; 

		label asian_pacislander = "Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";


		other = 
		   (B02001004 /*American Indian and Alaska Native Alone*/ + 
			B02001009 /*Two or More Races: Two Races Including Some Other Race*/) / 
			B01001001 /*Total Population*/;

		label other = "Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";


		white_moe = 
			B02001002s /*White alone*/ / 
			B01001001s /*Total Population*/;

		label white_moe = "[Margin of Error]Proportion of geographic unit who are recorded as White";


		black_moe = 
			B02001003s /*Black or African American Alone*/ / 
			B01001001s /*Total Population*/; 

		label black_moe = "[Margin of Error]Proportion of geographic unit who are recorded as Black";


		asian_pacislander_moe = 
		   (B02001005s /*Asian Alone*/ + 
			B02001006s /*Native Hawaiian and Other Pacific Islander Alone*/) / 
			B01001001s /*Total Population*/; 

		label asian_pacislander_moe = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";


		other_moe = 
		   (B02001004s /*American Indian and Alaska Native Alone*/ + 
			B02001009s /*Two or More Races: Two Races Including Some Other Race*/) / 
			B01001001s /*Total Population*/;

		label other_moe = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";


		/*Ethnicity*/

		hisp = 
			B03002012 /*Hispanic or Latino*/ / 
			B03002001 /*Total Population*/;

		label hisp = "Proportion of geographic unit who are reported as Hispanic or Latino";

		hisp_moe = 
			B03002012s /*Hispanic or Latino*/ / 
			B03002001s /*Total Population*/;

		label hisp_moe = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino";


		/*School enrollment (3+)*/

		noenrolledinschool_3plus = 
		   (B14002025 /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
			B14002049 /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
			B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

		label noenrolledinschool_3plus = "Proportion of Population 3+ Not Enrolled in School";

		noenrolledinschool_3plus_moe = 
		   (B14002025s /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
			B14002049s /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
			B14002001s /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

		label noenrolledinschool_3plus_moe = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School";


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

		nohsgrad_25plus_moe =
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
			B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) /
			B15002001s /*Population 25 Years and Over*/;

		label nohsgrad_25plus_moe = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School ";


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

		unemployed_moe = 
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
			 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ )/
			(B23007031s + /*Families: No Children Under 18 Years*/
			 B23007002s   /*Families: with Own Children Under 18 Years*/ );

		label unemployed_moe = "[Margin of Error]Proportion of families with an unemployed parent";


		/*Median Household income*/

		med_houseincome = B19013001;

		label med_houseincome = "Median Household Income";


		med_houseincome_moe = B19013001s;

		label med_houseincome_moe = "[Margin of Error]Median Household Income";


		/*Public assistance*/

		households_w_publicassist = 
			B19057002 /*Households: with Public Assistance Income*/ /
			B19057001 /*Households*/;

		label households_w_publicassist = "Proportion of Households with Public Assistance Income";

		hhouseholds_w_publicassist_moe = 
			B19057002s /*Households: with Public Assistance Income*/ /
			B19057001s /*Households*/;

		label households_w_publicassist_moe = "[Margin of Error]Proportion of Households with Public Assistance Income";


		/*Social security income*/

		socsecinsur = 
			B19055002 /*Households: with Social Security Income*/ /
			B19055001 /*Households*/ ;

		label socsecinsur = "Proportion with social security income";

		socsecinsur_moe = 
			B19055002s /*Households: with Social Security Income*/ /
			B19055001s /*Households*/ ;

		label socsecinsur_moe = "[Margin of Error]Proportion with social security income";


		/*Poverty status*/

		belowpovertyline = 
			B17017002 / /*Households: Income in the Past 12 Months Below Poverty Level*/
			B17017001 /*Households*/ ;

		label belowpovertyline = "Proportion below the poverty line";

		belowpovertyline_moe = 
			B17017002s / /*Households: Income in the Past 12 Months Below Poverty Level*/
			B17017001s /*Households*/ ;

		label belowpovertyline_moe = "[Margin of Error]Proportion below the poverty line";


		/*Poverty status: Household 45+ */

		belowpovertyline45p = 
		   (B17017007 + B17017008 + B17017013 + B17017014 + B17017018 + B17017019 + B17017024 + B17017025 + B17017029 + B17017030) / /*Households: Income in the Past 12 Months Below Poverty Level - Ages 45+ */
			B17017001 /*Households*/ ;

		label belowpovertyline45p = "Proportion below the poverty line - Ages 45+ ";

		belowpovertyline45p_moe = 
			(B17017007s + B17017008s + B17017013s + B17017014s + B17017018s + B17017019s + B17017024s + B17017025s + B17017029s + B17017030s) / /*Households: Income in the Past 12 Months Below Poverty Level - Ages 45+ */
			B17017001s /*Households*/ ;

		label belowpovertyline45p_moe = "[Margin of Error]Proportion below the poverty line - Ages 45+ ";


		/*Familes with kids under poverty line*/

		famkids_poverty =
		   (B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
			B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
			B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
			B17010001 /*Total Families*/;

		label famkids_poverty = "Proportion of all family types below the poverty line with children under 18 years";

		famkids_poverty_moe =
		   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
			B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
			B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
			B17010001s /*Total Families*/;

		label famkids_poverty_moe = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years";


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


		householder45plus_poverty_moe = 
		   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
			B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
			B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
			B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
			B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
			B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
			B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
			B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
			B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
			B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
			B17017001s /*Households*/;

		label householder45plus_poverty_moe = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater";


		householder45plus_poverty2_moe = 
		   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
			B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
			B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
			B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
			B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
			B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
			B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
			B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
			B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
			B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
			B17017002s /*Households: Income in the Past 12 Months Below Poverty Level*/;

		label householder45plus_poverty2_moe = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater";


		/*Per capita income*/

		percapita_income = B19301001;
		label percapita_income = "Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";

		percapita_income_moe = B19301001;
		label percapita_income_moe = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";


		/*Gini index*/

		gini = B19083001 /*Households: Gini Index*/;
		label gini = "Gini Index of Income Inequality";

		gini_moe = B19083001 /*Households: Gini Index*/;
		label gini_moe = "Gini Index of Income Inequality";


		/*Citizenship*/

		not_citizen = 
			B26110011 /*Total Population in the United States: not U.S. Citizens*/ /
			B26110001 /*Total Population in the United States*/;

		label not_citizen = "Proportion who are not U.S. Citizens ";

		not_citizen_moe = 
			B26110011s /*Total Population in the United States: not U.S. Citizens*/ /
			B26110001s /*Total Population in the United States*/;

		label not_citizen_moe = "[Margin of Error]Proportion who are not U.S. Citizens ";

		foreign_born = 
			B26110005 /*Total Population in the United States: Foreign Born*/ /
			B26110001 /*Total Population in the United States*/;

		label foreign_born = "Proportion who are foreign born ";

		foreign_born_moe = 
			B26110005s /*Total Population in the United States: Foreign Born*/ /
			B26110001s /*Total Population in the United States*/;

		label foreign_born_moe = "[Margin of Error]Proportion who are foreign born ";


		/*Language spoken at home*/

		foreign_lang = 
			(B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
			 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
			 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
			 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
			 B16004001 /*Population 5 Years and Over*/;

		label foreign_lang = "Proportion who speak a foreign language";

		foreign_lang_moe = 
			(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
			 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
			 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
			 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
			 B16004001s /*Population 5 Years and Over*/;

		label foreign_lang_moe = "[Margin of Error]Proportion who speak a foreign language";


		/*Travel time to work*/

		commute_60minplus = 
			(B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
			 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
			 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

		label commute_60minplus = "Proportion who have a commute to work of 60min or longer";

		commute_60minplus_moe = 
			(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
			 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
			 B08303001s /*Workers 16 Years and Over Who Did Not Work At Home*/;

		label commute_60minplus_moe = "[Margin of Error]Proportion who have a commute to work of 60min or longer";


		/*Means of Transportation: Workers 16+*/

		publtrans_bike_walk = 
		   (B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
		    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
			B08301019 /*Workers 16 Years and Over: Walked*/ ) /
			B08301001 /*Workers 16 Years and Over*/;

		label publtrans_bike_walk = "Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";

		publtrans_bike_walk_moe = 
		   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
		    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
			B08301019s /*Workers 16 Years and Over: Walked*/ ) /
			B08301001s /*Workers 16 Years and Over*/;

		label publtrans_bike_walk_moe = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";


		/*Veteran status*/
		
		veteran = 
			B21001002 /*Civilian Population 18 Years and Over: Veteran*/ /
			B21001001 /*Civilian Population 18 Years and Over*/;

		label veteran = "Proportion of civilian population 18 years and over who are veterans";

		veteran_moe = 
			B21001002s /*Civilian Population 18 Years and Over: Veteran*/ /
			B21001001s /*Civilian Population 18 Years and Over*/;

		label veteran_moe = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans";


		/*Households*/

		nonfam_households = 
			B11001007 /*Non-family households*/ / 
			B11001001 /*Households*/;

		label nonfam_households = "Proportions of households which are non-family";

		nonfam_households_moe = 
			B11001007s /*Non-family households*/ / 
			B11001001s /*Households*/;

		label nonfam_households_moe = "[Margin of Error]Proportions of households which are non-family";


		/*Single parents with kids*/

		singledad = 
			B11003010 /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
			B11003001 /*Total Families*/;

		label singledad = "Proportion of families with single fathers";


		singlemom = 
			B11003016 /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
			B11003001 /*Total Families*/;

		label singlemom = "Proportion of families with single mothers";


		singledad_moe = 
			B11003010s /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
			B11003001s /*Total Families*/;

		label singledad_moe = "[Margin of Error]Proportion of families with single fathers";


		singlemom_moe = 
			B11003016s /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
			B11003001s /*Total Families*/;

		label singlemom_moe = "[Margin of Error]Proportion of families with single mothers";


		/*Housing Units*/

		house_units = B25001001;
		label house_units = "Number of housing units";

		house_units_moe = B25001001;
		label house_units_moe = "[Margin of Error]Number of housing units";


		/*Occupancy Status*/

		renter_occupied = 
			B25003003 /*Occupied Housing Units: Renter Occupied*/ /
			B25003001 /*Occupied Housing Units*/;

		label renter_occupied = "Proportion of renter occupied households";

		renter_occupied_moe = 
			B25003003s /*Occupied Housing Units: Renter Occupied*/ /
			B25003001s /*Occupied Housing Units*/;

		label renter_occupied_moe = "[Margin of Error]Proportion of renter occupied households";


		/*Vacant Housing Units*/

		vacant = 
			B25002003 /*Housing Units: Vacant*/ /
			B25002001 /*Housing Units*/;

		label vacant = "Proportion of housing units which are vacant";

		vacant_moe = 
			B25002003s /*Housing Units: Vacant*/ /
			B25002001s /*Housing Units*/;

		label vacant_moe = "[Margin of Error]Proportion of housing units which are vacant";


		/*Mortgage Status*/

		no_mortgage = 
			B25081008 /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
			B25081001 /*Owner-Occupied Housing Units*/;

		label no_mortgage = "Proportion of owner-occupied housing units without a mortgage";

		no_mortgage_moe = 
			B25081008s /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
			B25081001s /*Owner-Occupied Housing Units*/;

		label no_mortgage_moe = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage";


		/*Occupants per room*/

		occupantsperroom = 
		   (B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
			B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
			B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
			B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
			B25014001; /*Occupied Housing Units*/

		label occupantsperroom = "Proportion of occupied housing units with more than 1.5 occupants per room";

		occupantsperroom_moe = 
		   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
			B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
			B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
			B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
			B25014001s; /*Occupied Housing Units*/

		label occupantsperroom_moe = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room";


		/*Telephone Service Available*/

		no_telephone = 
		   (B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
			B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
			B25043001 /*Occupied Housing Units*/;

		label no_telephone = "Proportion of households with no telephone service";

		no_telephone_moe = 
		   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
			B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
			B25043001s /*Occupied Housing Units*/;

		label no_telephone_moe = "[Margin of Error]Proportion of households with no telephone service";


		/*Vehicles Available*/

		no_vehicle = 
		   (B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
			B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
			B25044001 /*Occupied Housing Units*/;

		label no_vehicle = "Proportion of households with no vehicle available";

		no_vehicle_moe = 
		   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
			B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
			B25044001s /*Occupied Housing Units*/;

		label no_vehicle_moe = "[Margin of Error]Proportion of households with no vehicle available";


		/*House heating fuel*/

		no_heat = 
			B25040010 /*Occupied Housing Units: No Fuel Used*/ /
			B25040001 /*Occupied Housing Units*/;

		label no_heat = "Proportion of occupied housing units with no house heating fuel used";

		no_heat_moe = 
			B25040010s /*Occupied Housing Units: No Fuel Used*/ /
			B25040001s /*Occupied Housing Units*/;

		label no_heat_moe = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used";


		/*Plumbing facilities*/

		lack_plumbing = 
			B25047003 /*Housing Units: Lacking Complete Plumbing Facilities*/ /
			B25047001 /*Housing Units*/;

		label lack_plumbing = "Proportion of households lacking complete plumbing facilities";

		lack_plumbing_moe = 
			B25047003s /*Housing Units: Lacking Complete Plumbing Facilities*/ /
			B25047001s /*Housing Units*/;

		label lack_plumbing_moe = "[Margin of Error]Proportion of households lacking complete plumbing facilities";


		/*Kitchen facilities*/

		lack_kitchen = 
			B25051003 /*Housing Units: Lacking Complete Kitchen Facilities*/ /
			B25051001 /*Housing Units*/;

		label lack_kitchen = "Proportion of households lacking complete kitchen facilities";

		lack_kitchen_moe = 
			B25051003s /*Housing Units: Lacking Complete Kitchen Facilities*/ /
			B25051001s /*Housing Units*/;

		label lack_kitchen_moe = "[Margin of Error]Proportion of households lacking complete kitchen facilities";

		med_yearbuilt = B25035001; /*Housing Units: Median Year Structure Built*/
	
		label med_yearbuilt = "Median year homes in geographic unit were built";

		med_yearbuilt_moe = B25035001s; /*Housing Units: Median Year Structure Built*/
	
		label med_yearbuilt_moe = "[Margin of Error]Median year homes in geographic unit were built";

	geoid_ct = substr(geoid,8,11);

	geoid_bg = input(substr(geoid,8), 12.);

		if year1 in ("2012" "2015") then do;
			geoid_ct = substr(geoid,1,11);
			geoid_bg = geoid;
		end;

run;

data geoid_ct;
  set ds.acs_raw_newvars (keep=geoid_bg geoid_ct);
	geoid_ctn = input(geoid_ct, BEST.);
	drop geoid_ct;
	rename 
		geoid_bg = geoid
		geoid_ctn = geoid_ct
	;
run;

proc export 
	data = geoid_ct
	outfile = "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS\geoid_ct.txt"
	dbms = tab
	replace;
run;


proc means data = ds.acs_raw_newvars nmiss;
var total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline belowpovertyline45p famkids_poverty householder45plus_poverty2 med_houseincome percapita_income not_citizen foreign_born foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt gini;
run;





/*

Missing by year:

2006: nohsgrad_18plus, unemployed_16plus, belowpovertyline, gini, not_citizen
2007: nohsgrad_18plus, unemployed_16plus, belowpovertyline, gini, not_citizen
2008: nohsgrad_18plus, unemployed_16plus, belowpovertyline, gini, not_citizen
2009: nohsgrad_18plus, unemployed_16plus, belowpovertyline, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)
2010: nohsgrad_18plus, unemployed_16plus, belowpovertyline, gini, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)
2011: nohsgrad_18plus, unemployed_16plus, belowpovertyline, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)
2012: nohsgrad_18plus, unemployed_16plus, belowpovertyline, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)
2013: nohsgrad_18plus, unemployed_16plus, belowpovertyline, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)
2014: nohsgrad_18plus, unemployed_16plus, belowpovertyline, not_citizen, house_units, renter_occupied, vacant, no_mortgage (mostly missing), no_telephone (mostly missing), no_heat (mostly missing), lack_plumbing (mostly missing)


Is availabe (NA = Not Available)? If yes, what table?

2006: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen
2007: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen
2008: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen
2009: NO nohsgrad_18plus, B23007, B17017, B19083, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051
2010: NO nohsgrad_18plus, B23007, B17017, B19083, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051
2011: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051
2012: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051
2013: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051
2014: NO nohsgrad_18plus, B23007, B17017, NO GINI AT BG, NO not_citizen, B25001?, B25003 (B25008? B11012?), B25002 (B25004), B25081/B25091, B25043, B25040, B25047, B25051

hOUSING UNITS ARE THE SAME TABLE IN 2009 BUT STILL MISSING? tRY b25002?

heat: B25040
plum: B25047
kitch: B25051
tele: B25043
mortg: B25081/B25091

Resaon for so much missing is no one with lack of facilities?

med year built - 25035

Is the reason missing in the SAS program?

*/



/*proc contents data = ds.acs_raw_ct varnum; run;*/

libname d "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2015-2019 ACS";

proc print data = ct15_19 (obs=100);
run;

libname ds18 "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2014-2018 ACS";

proc contents data = ds18.pact14_18; run;

proc means data = ds.acs_raw_ct nmiss;
var B05001i1 B05002i1;
run;


%macro ctvars;

	/*Total Population*/

	total_pop_ct = B01001001; /*Total Population*/
	label total_pop_ct = "Count of Total Population";

	total_pop_moe_ct = B01001001s; /*Total Population*/
	label total_pop_moe_ct = "[Margin of Error]Count of Total Population";


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

	age_45_74_moe_ct = 
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

	label age_45_74_moe_ct = "[Margin of Error]Count of population ages 45 to 74 years";

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

		age_ge65_moe_ct = 
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
			) / 
			B01001001s /*Total Population*/;

		label age_ge65_moe_ct = "[Margin of Error]Percent of population ages 65 years and older";

	/*Sex*/

	male_ct = 
		B01001002 /*Males*/ / 
		B01001001 /*Total Population*/;

	label male_ct = "Proportion of geographic unit who are male";

	female_ct = 
		B01001026 /*Females*/ / 
		B01001001 /*Total Population*/;

	label female_ct = "Proportion of geographic unit who are female";

	male_moe_ct = 
		B01001002s /*Males*/ / 
		B01001001s /*Total Population*/;

	label male_moe_ct = "[Margin of Error]Proportion of geographic unit who are male";

	female_moe_ct = 
		B01001026s /*Females*/ / 
		B01001001s /*Total Population*/;

	label female_moe_ct = "[Margin of Error]Proportion of geographic unit who are female";


	/*Race*/

	white_ct = 
		B02001002 /*White alone*/ / 
		B01001001 /*Total Population*/;

	label white_ct = "Proportion of geographic unit who are recorded as White";


	black_ct = 
		B02001003 /*Black or African American Alone*/ / 
		B01001001 /*Total Population*/; 

	label black_ct = "Proportion of geographic unit who are recorded as Black";


	asian_pacislander_ct = 
	   (B02001005 /*Asian Alone*/ + 
		B02001006 /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		B01001001 /*Total Population*/; 

	label asian_pacislander_ct = "Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";


	other_ct = 
	   (B02001004 /*American Indian and Alaska Native Alone*/ + 
		B02001009 /*Two or More Races: Two Races Including Some Other Race*/) / 
		B01001001 /*Total Population*/;

	label other_ct = "Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";


	white_moe_ct = 
		B02001002s /*White alone*/ / 
		B01001001s /*Total Population*/;

	label white_moe_ct = "[Margin of Error]Proportion of geographic unit who are recorded as White";


	black_moe_ct = 
		B02001003s /*Black or African American Alone*/ / 
		B01001001s /*Total Population*/; 

	label black_moe_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Black";


	asian_pacislander_moe_ct = 
	   (B02001005s /*Asian Alone*/ + 
		B02001006s /*Native Hawaiian and Other Pacific Islander Alone*/) / 
		B01001001s /*Total Population*/; 

	label asian_pacislander_moe_ct = "[Margin of Error]Proportion of geographic unit who are recorded as Asian, Native Hawaiian, and Other Pacific Islander ";


	other_moe_ct = 
	   (B02001004s /*American Indian and Alaska Native Alone*/ + 
		B02001009s /*Two or More Races: Two Races Including Some Other Race*/) / 
		B01001001s /*Total Population*/;

	label other_moe_ct = "[Margin of Error]Proportion of geographic unit who are recorded as American Indian, Alaska Native Alone, Two or More Races, and Two Races Including Some Other Race";


	/*Ethnicity*/

	hisp_ct = 
		B03002012 /*Hispanic or Latino*/ / 
		B03002001 /*Total Population*/;

	label hisp_ct = "Proportion of geographic unit who are reported as Hispanic or Latino";

	hisp_moe_ct = 
		B03002012s /*Hispanic or Latino*/ / 
		B03002001s /*Total Population*/;

	label hisp_moe_ct = "[Margin of Error]Proportion of geographic unit who are reported as Hispanic or Latino";


	/*School enrollment (3+)*/

	noenrolledinschool_3plus_ct = 
	   (B14002025 /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		B14002049 /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		B14002001 /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_ct = "Proportion of Population 3+ Not Enrolled in School";

	noenrolledinschool_3plus_moe_ct = 
	   (B14002025s /*Population 3 Years and Over: Male: Not Enrolled in School*/ +
		B14002049s /*Population 3 Years and Over: Female: Not Enrolled in School*/) /
		B14002001s /*Population 3 Years and Over*/; /*(Pop 3+ Not Enrolled in School)*/;

	label noenrolledinschool_3plus_moe_ct = "[Margin of Error]Proportion of Population 3+ Not Enrolled in School";


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

	nohsgrad_25plus_moe_ct =
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
		B15002027s /*Population 25 Years and Over: Female: 12th Grade, No Diploma*/ ) /
		B15002001s /*Population 25 Years and Over*/;

	label nohsgrad_25plus_moe_ct = "[Margin of Error]Proportion of Population 25+ who did not Graduate High School ";


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

	unemployed_moe_ct = 
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
		 B23007058s   /*Families: No Children Under 18 Years: Other Family: Female Householder, No Husband Present: in Labor Force: Unemployed*/ )/
		(B23007031s + /*Families: No Children Under 18 Years*/
		 B23007002s   /*Families: with Own Children Under 18 Years*/ );

	label unemployed_moe_ct = "[Margin of Error]Proportion of families with an unemployed parent";


	/*Median Household income*/

	med_houseincome_ct = B19013001;

	label med_houseincome_ct = "Median Household Income";


	med_houseincome_moe_ct = B19013001s;

	label med_houseincome_moe_ct = "[Margin of Error]Median Household Income";


	/*Public assistance*/

	households_w_publicassist_ct = 
		B19057002 /*Households: with Public Assistance Income*/ /
		B19057001 /*Households*/;

	label households_w_publicassist_ct = "Proportion of Households with Public Assistance Income";

	households_w_publicassist_moe_ct = 
		B19057002s /*Households: with Public Assistance Income*/ /
		B19057001s /*Households*/;

	label households_w_publicassist_moe_ct = "[Margin of Error]Proportion of Households with Public Assistance Income";


	/*Social security income*/

	socsecinsur_ct = 
		B19055002 /*Households: with Social Security Income*/ /
		B19055001 /*Households*/ ;

	label socsecinsur_ct = "Proportion with social security income";

	socsecinsur_moe_ct = 
		B19055002s /*Households: with Social Security Income*/ /
		B19055001s /*Households*/ ;

	label socsecinsur_moe_ct = "[Margin of Error]Proportion with social security income";


	/*Poverty status*/

	belowpovertyline_ct = 
		B17017002 / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001 /*Households*/ ;

	label belowpovertyline_ct = "Proportion below the poverty line";

	belowpovertyline_moe_ct = 
		B17017002s / /*Households: Income in the Past 12 Months Below Poverty Level*/
		B17017001s /*Households*/ ;

	label belowpovertyline_moe_ct = "[Margin of Error]Proportion below the poverty line";


	/*Familes with kids under poverty line*/

	famkids_poverty_ct =
	   (B17010004 /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017 /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
		B17010001 /*Total Families*/;

	label famkids_poverty_ct = "Proportion of all family types below the poverty line with children under 18 years";

	famkids_poverty_moe_ct =
	   (B17010004s /*Families: Income in the Past 12 Months Below Poverty Level: Married-Couple Family: with Related Children Under 18 Years*/ +
		B17010011s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Male Householder, No Wife Present: with Related Children Under 18 Years*/ +
		B17010017s /*Families: Income in the Past 12 Months Below Poverty Level: Other Family: Female Householder, No Husband Present: with Related Children Under 18 Years*/) /
		B17010001s /*Total Families*/;

	label famkids_poverty_moe_ct = "[Margin of Error]Proportion of all family types below the poverty line with children under 18 years";


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


	householder45plus_poverty_moe_ct = 
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017001s /*Households*/;

	label householder45plus_poverty_moe_ct = "[Margin of Error]Proportion of households which are below the poverty line and the householder is 45 years or greater";


	householder45plus_poverty2_moe_c = 
	   (B17017007s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 45 to 64 Years*/ +
		B17017008s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Married-Couple Family: Householder 65 Years and Over*/ +
		B17017013s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 45 to 64 Years*/ +
		B17017014s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Male Householder, No Wife Present: Householder 65 Years and Over*/ +
		B17017018s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 45 to 64 Years*/ +
		B17017019s /*Households: Income in the Past 12 Months Below Poverty Level: Family Households: Other Family: Female Householder, No Husband Present: Householder 65 Years and Over*/ +
		B17017024s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 45 to 64 Years*/ +
		B17017025s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Male Householder: Householder 65 Years and Over*/ +
		B17017029s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 45 to 64 Years*/ +
		B17017030s /*Households: Income in the Past 12 Months Below Poverty Level: Nonfamily Households: Female Householder: Householder 65 Years and Over*/) /
		B17017002s /*Households: Income in the Past 12 Months Below Poverty Level*/;

	label householder45plus_poverty2_moe_c = "[Margin of Error]Proportion of households below the poverty line which have a householder who is 45 years or greater";


	/*Per capita income*/

	percapita_income_ct = B19301001;
	label percapita_income_ct = "Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";

	percapita_income_moe_ct = B19301001;
	label percapita_income_moe_ct = "[Margin of Error]Per Capita Income in the Past 12 Months (in 2010 Inflation-Adjusted Dollars)";


	/*Citizenship*/

	not_citizen_ct = 
		B26110011 /*Total Population in the United States: not U.S. Citizens*/ /
		B26110001 /*Total Population in the United States*/;

	label not_citizen_ct = "Proportion who are not U.S. Citizens ";

	not_citizen_moe_ct = 
		B26110011s /*Total Population in the United States: not U.S. Citizens*/ /
		B26110001s /*Total Population in the United States*/;

	label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

	foreign_born_ct = 
		B26110005 /*Total Population in the United States: Foreign Born*/ /
		B26110001 /*Total Population in the United States*/;

	label foreign_born_ct = "Proportion who are foreign born ";

	foreign_born_moe_ct = 
		B26110005s /*Total Population in the United States: Foreign Born*/ /
		B26110001s /*Total Population in the United States*/;

	label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";


	/*Language spoken at home*/

	foreign_lang_ct = 
		(B16004004 /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014 /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019 /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
		 B16004001 /*Population 5 Years and Over*/;

	label foreign_lang_ct = "Proportion who speak a foreign language";

	foreign_lang_moe_ct = 
		(B16004004s /*Population 5 Years and Over: 5 to 17 Years: Speak Spanish*/ +
		 B16004009s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Indo-European Languages*/ +
		 B16004014s /*Population 5 Years and Over: 5 to 17 Years: Speak Asian and Pacific Island Languages*/ +
		 B16004019s /*Population 5 Years and Over: 5 to 17 Years: Speak Other Languages*/) /
		 B16004001s /*Population 5 Years and Over*/;

	label foreign_lang_moe_ct = "[Margin of Error]Proportion who speak a foreign language";


	/*Travel time to work*/

	commute_60minplus_ct = 
		(B08303012 /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013 /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
		 B08303001 /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_ct = "Proportion who have a commute to work of 60min or longer";

	commute_60minplus_moe_ct = 
		(B08303012s /*Workers 16 Years and Over Who Did Not Work At Home: 60 to 89 Minutes*/ +
		 B08303013s /*Workers 16 Years and Over Who Did Not Work At Home: 90 or More Minutes*/) /
		 B08303001s /*Workers 16 Years and Over Who Did Not Work At Home*/;

	label commute_60minplus_moe_ct = "[Margin of Error]Proportion who have a commute to work of 60min or longer";


	/*Means of Transportation: Workers 16+*/

	publtrans_bike_walk_ct = 
	   (B08301010 /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018 /*Workers 16 Years and Over: Bicycle*/ +
		B08301019 /*Workers 16 Years and Over: Walked*/ ) /
		B08301001 /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_ct = "Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";

	publtrans_bike_walk_moe_ct = 
	   (B08301010s /*Workers 16 Years and Over: Public Transportation (Excluding Taxicab)*/ +
	    B08301018s /*Workers 16 Years and Over: Bicycle*/ +
		B08301019s /*Workers 16 Years and Over: Walked*/ ) /
		B08301001s /*Workers 16 Years and Over*/;

	label publtrans_bike_walk_moe_ct = "[Margin of Error]Proportion of workers 16 years and over who either took public transportation, biked, or walked to work";


	/*Veteran status*/
	
	veteran_ct = 
		B21001002 /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001 /*Civilian Population 18 Years and Over*/;

	label veteran_ct = "Proportion of civilian population 18 years and over who are veterans";

	veteran_moe_ct = 
		B21001002s /*Civilian Population 18 Years and Over: Veteran*/ /
		B21001001s /*Civilian Population 18 Years and Over*/;

	label veteran_moe_ct = "[Margin of Error]Proportion of civilian population 18 years and over who are veterans";


	/*Households*/

	nonfam_households_ct = 
		B11001007 /*Non-family households*/ / 
		B11001001 /*Households*/;

	label nonfam_households_ct = "Proportions of households which are non-family";

	nonfam_households_moe_ct = 
		B11001007s /*Non-family households*/ / 
		B11001001s /*Households*/;

	label nonfam_households_moe_ct = "[Margin of Error]Proportions of households which are non-family";


	/*Single parents with kids*/

	singledad_ct = 
		B11003010 /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singledad_ct = "Proportion of families with single fathers";


	singlemom_ct = 
		B11003016 /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001 /*Total Families*/;

	label singlemom_ct = "Proportion of families with single mothers";


	singledad_moe_ct = 
		B11003010s /*Families: Other Family: Male Householder, No Wife Present: with Own Children Under 18 Years*/ / 
		B11003001s /*Total Families*/;

	label singledad_moe_ct = "[Margin of Error]Proportion of families with single fathers";


	singlemom_moe_ct = 
		B11003016s /*Families: Other Family: Female Householder, No Husband Present: with Own Children Under 18 Years*/ / 
		B11003001s /*Total Families*/;

	label singlemom_moe_ct = "[Margin of Error]Proportion of families with single mothers";


	/*Housing Units*/

	house_units_ct = B25001001;
	label house_units_ct = "Number of housing units";

	house_units_moe_ct = B25001001;
	label house_units_moe_ct = "[Margin of Error]Number of housing units";


	/*Occupancy Status*/

	renter_occupied_ct = 
		B25003003 /*Occupied Housing Units: Renter Occupied*/ /
		B25003001 /*Occupied Housing Units*/;

	label renter_occupied_ct = "Proportion of renter occupied households";

	renter_occupied_moe_ct = 
		B25003003s /*Occupied Housing Units: Renter Occupied*/ /
		B25003001s /*Occupied Housing Units*/;

	label renter_occupied_moe_ct = "[Margin of Error]Proportion of renter occupied households";


	/*Vacant Housing Units*/

	vacant_ct = 
		B25002003 /*Housing Units: Vacant*/ /
		B25002001 /*Housing Units*/;

	label vacant_ct = "Proportion of housing units which are vacant";

	vacant_moe_ct = 
		B25002003s /*Housing Units: Vacant*/ /
		B25002001s /*Housing Units*/;

	label vacant_moe_ct = "[Margin of Error]Proportion of housing units which are vacant";


	/*Mortgage Status*/

	no_mortgage_ct = 
		B25081008 /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001 /*Owner-Occupied Housing Units*/;

	label no_mortgage_ct = "Proportion of owner-occupied housing units without a mortgage";

	no_mortgage_moe_ct = 
		B25081008s /*Owner-Occupied Housing Units: Housing Units Without a Mortgage*/ /
		B25081001s /*Owner-Occupied Housing Units*/;

	label no_mortgage_moe_ct = "[Margin of Error]Proportion of owner-occupied housing units without a mortgage";


	/*Occupants per room*/

	occupantsperroom_ct = 
	   (B25014006 /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007 /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012 /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013 /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
		B25014001; /*Occupied Housing Units*/

	label occupantsperroom_ct = "Proportion of occupied housing units with more than 1.5 occupants per room";

	occupantsperroom_moe_ct = 
	   (B25014006s /*Occupied Housing Units: Owner Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014007s /*Occupied Housing Units: Owner Occupied: 2.01 or More Occupants Per Room*/ +
		B25014012s /*Occupied Housing Units: Renter Occupied: 1.51 to 2.00 Occupants Per Room*/ +
		B25014013s /*Occupied Housing Units: Renter Occupied: 2.01 or More Occupants Per Room*/) /
		B25014001s; /*Occupied Housing Units*/

	label occupantsperroom_moe_ct = "[Margin of Error]Proportion of occupied housing units with more than 1.5 occupants per room";


	/*Telephone Service Available*/

	no_telephone_ct = 
	   (B25043007 /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016 /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
		B25043001 /*Occupied Housing Units*/;

	label no_telephone_ct = "Proportion of households with no telephone service";

	no_telephone_moe_ct = 
	   (B25043007s /*Occupied Housing Units: Owner Occupied: No Telephone Service Available*/ + 
		B25043016s /*Occupied Housing Units: Renter Occupied: No Telephone Service Available*/) /
		B25043001s /*Occupied Housing Units*/;

	label no_telephone_moe_ct = "[Margin of Error]Proportion of households with no telephone service";


	/*Vehicles Available*/

	no_vehicle_ct = 
	   (B25044003 /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010 /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
		B25044001 /*Occupied Housing Units*/;

	label no_vehicle_ct = "Proportion of households with no vehicle available";

	no_vehicle_moe_ct = 
	   (B25044003s /*Occupied Housing Units: Owner Occupied: No Vehicle Available*/ +
		B25044010s /*Occupied Housing Units: Renter Occupied: No Vehicle Available*/) /
		B25044001s /*Occupied Housing Units*/;

	label no_vehicle_moe_ct = "[Margin of Error]Proportion of households with no vehicle available";


	/*House heating fuel*/

	no_heat_ct = 
		B25040010 /*Occupied Housing Units: No Fuel Used*/ /
		B25040001 /*Occupied Housing Units*/;

	label no_heat_ct = "Proportion of occupied housing units with no house heating fuel used";

	no_heat_moe_ct = 
		B25040010s /*Occupied Housing Units: No Fuel Used*/ /
		B25040001s /*Occupied Housing Units*/;

	label no_heat_moe_ct = "[Margin of Error]Proportion of occupied housing units with no house heating fuel used";


	/*Plumbing facilities*/

	lack_plumbing_ct = 
		B25047003 /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001 /*Housing Units*/;

	label lack_plumbing_ct = "Proportion of households lacking complete plumbing facilities";

	lack_plumbing_moe_ct = 
		B25047003s /*Housing Units: Lacking Complete Plumbing Facilities*/ /
		B25047001s /*Housing Units*/;

	label lack_plumbing_moe_ct = "[Margin of Error]Proportion of households lacking complete plumbing facilities";


	/*Kitchen facilities*/

	lack_kitchen_ct = 
		B25051003 /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001 /*Housing Units*/;

	label lack_kitchen_ct = "Proportion of households lacking complete kitchen facilities";

	lack_kitchen_moe_ct = 
		B25051003s /*Housing Units: Lacking Complete Kitchen Facilities*/ /
		B25051001s /*Housing Units*/;

	label lack_kitchen_moe_ct = "[Margin of Error]Proportion of households lacking complete kitchen facilities";

	med_yearbuilt_ct = B25035001; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_ct = "Median year homes in geographic unit were built";

	med_yearbuilt_moe_ct = B25035001s; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_moe_ct = "[Margin of Error]Median year homes in geographic unit were built";

	gini_ct = B19083001; /* Households: Gini Index */
	label gini_ct = "Gini index of inequality (Census Tracts)";

	gini_moe_ct = B19083001s; /* [Std. Error: Households: Gini Index */
	label gini_moe_ct = "[Margin of Error]Gini index of inequality (Census Tracts)";

	moved_1yr_ct = 
		(B07003001 /* Population 1 Year and Over in the United States */ - B07003004 /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) /
		 B07003001 /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_ct = "Proportion of population who moved houses within a year (Census Tracts";

	moved_1yr_moe_ct = 
		(B07003001s /* Population 1 Year and Over in the United States */ - B07003004s /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) /
		 B07003001s /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_moe_ct = "[Margin of Error]Proportion of population who moved houses within a year (Census Tracts";

	geoid_ct = input(substr(geoid,8,11), BEST.);

		if year1 eq "2015" then do;
			geoid_ct = substr(geoid,1,11);
		end;

%mend;


libname acs "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

proc sort data = acs.acs_raw_ct; by geoid year1; run;
proc sort data = acs.acs_12_16_ct; by geoid year1; run;
proc sort data = acs.acs_15_19_ct; by geoid year1; run;

data acs_raw_newvars_ct;
  set acs.acs_raw_ct;
	%ctvars;
run;

/*proc contents data = acs.acs_raw_ct varnum; run;*/

proc sort data = acs_raw_newvars_ct; by year1; run;

proc means data = acs_raw_newvars_ct nmiss mean maxdec=2 nolabels;
var &ctvarlist.;
by year1;
run;

data acs_12_16_ct;
  set acs.acs_12_16_ct;
	%ctvars;
run;

proc means data = acs_12_16_ct nmiss mean maxdec=2 nolabels;
var &ctvarlist.;
run;

data acs_15_19_ct;
  set acs.acs_15_19_ct;
	%ctvars;
run;

proc means data = acs_15_19_ct nmiss mean maxdec=2 nolabels;
var &ctvarlist.;
run;



















%macro imp(y1,y2);
	proc import 
		datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\20&y1.-20&y2. ACS\ct&y1._&y2._citizen_foreign.csv"
		out=ct&y1._&y2.(keep=Geo_STATE Geo_COUNTY Geo_TRACT ACS&y2._5yr_B05001001 ACS&y2._5yr_B05001006 ACS&y2._5yr_B05002001 ACS&y2._5yr_B05002013 ACS&y2._5yr_B05001001s ACS&y2._5yr_B05001006s ACS&y2._5yr_B05002001s ACS&y2._5yr_B05002013s)
		dbms=csv
		replace;
	run;
	quit;

	data ct&y1._&y2.;
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

		not_citizen_moe_ct = 
			ACS&y2._5yr_B05001006s /*Total Population in the United States: not U.S. Citizens*/ /
			ACS&y2._5yr_B05001001s /*Total Population in the United States*/;

		label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

		foreign_born_moe_ct = 
			ACS&y2._5yr_B05002013s /*Total Population in the United States: Foreign Born*/ /
			ACS&y2._5yr_B05002001s /*Total Population in the United States*/;

		label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";

		year1 = "20&y1.";
		year2 = "20&y2.";

		drop geoid Geo_STATE Geo_COUNTY Geo_TRACT;

	run;

	proc sort data = ct&y1._&y2.; by geoid_ct year1; run;

%mend;

%imp(06,10);
%imp(07,11);
%imp(08,12);

dm log 'clear';


%macro imp2(y1,y2);

	libname ds&y2. "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\20&y1.-20&y2. ACS";

	data ct&y1._&y2.;
	  set ds&y2..pact&y1._&y2.(keep=esriid B05001i1 B05001i6 B05002i1 B05002i13 B05001m1 B05001m6 B05002m1 B05002m13);

		geoid_ct = input(esriid, BEST.);

		drop esriid;

		rename
			B05001i1 = B05001001
			B05001i6 = B05001006
			B05002i1 = B05002001
			B05002i13 = B05002013
			B05001m1 = B05001001s
			B05001m6 = B05001006s
			B05002m1 = B05002001s
			B05002m13 = B05002013s
		;

		not_citizen_moe_ct = 
			B05001m6 /*Total Population in the United States: not U.S. Citizens*/ /
			B05001m1 /*Total Population in the United States*/;

		label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

		foreign_born_moe_ct = 
			B05002m13 /*Total Population in the United States: Foreign Born*/ /
			B05002m1 /*Total Population in the United States*/;

		label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";

		year1 = "20&y1.";
		year2 = "20&y2.";

	run;

	proc sort data = ct&y1._&y2.; by geoid_ct year1; run;

%mend;

%imp2(09,13);
%imp2(10,14);
%imp2(11,15);
*%imp2(12,16);
%imp2(13,17);
%imp2(14,18);
*%imp2(15,19);







proc import 
	datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2012-2016 ACS\ct12_16_moe_foreign_notcitizen.csv"
	out = ct12_16_moe
	dbms = csv
	replace;
run;
quit;

data ct12_16_moe;
  set ct12_16_moe;

	geoid = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
	geoid_ct = input(geoid, BEST.);

	not_citizen_moe_ct = 
		ACS16_5yr_B05001006s /*Total Population in the United States: not U.S. Citizens*/ /
		ACS16_5yr_B05001001s /*Total Population in the United States*/;

	label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

	foreign_born_moe_ct = 
		ACS16_5yr_B05002013s /*Total Population in the United States: Foreign Born*/ /
		ACS16_5yr_B05002001s /*Total Population in the United States*/;

	label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";

	year1 = "2012";
	year2 = "2016";

	year = 2014;

	keep geoid geoid_ct year1 year2 year not_citizen_moe_ct foreign_born_moe_ct;

run;

proc sort data = ct12_16_moe; by geoid_ct year; run;














proc import 
	datafile = "S:\Epi & Biostat\Research\Jones CRCS Team\PFAS Water Foundation Grant\Census\Data\American Community Survey\2015-2019 ACS\ct15_19_moe_foreign_notcitizen_moved_gini.csv"
	out = ct15_19_moe
	dbms = csv
	replace;
run;
quit;

data ct15_19_moe;
  set ct15_19_moe;

	geoid = cats(Geo_STATE,Geo_COUNTY,Geo_TRACT);
	geoid_ct = input(geoid, BEST.);

	not_citizen_moe_ct = 
		ACS19_5yr_B05001006s /*Total Population in the United States: not U.S. Citizens*/ /
		ACS19_5yr_B05001001s /*Total Population in the United States*/;

	label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

	foreign_born_moe_ct = 
		ACS19_5yr_B05002013s /*Total Population in the United States: Foreign Born*/ /
		ACS19_5yr_B05002001s /*Total Population in the United States*/;

	label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";

	gini_moe_ct = ACS19_5yr_B19083001s; /* [Std. Error: Households: Gini Index */
	label gini_moe_ct = "[Margin of Error]Gini index of inequality (Census Tracts)";

	moved_1yr_moe_ct = 
		(ACS19_5yr_B07003001s /* Population 1 Year and Over in the United States */ - ACS19_5yr_B07003004s /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) /
		 ACS19_5yr_B07003001s /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_moe_ct = "[Margin of Error]Proportion of population who moved houses within a year (Census Tracts";

	year1 = "2015";
	year2 = "2019";

	year = 2017;

	keep geoid geoid_ct year1 year2 year not_citizen_moe_ct foreign_born_moe_ct gini_moe_ct moved_1yr_moe_ct;

run;

proc sort data = ct15_19_moe; by geoid_ct year; run;








%macro sortct(ds);
	libname d2 "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";
	proc sort data = d2.&ds.;
	by geoid_ct year1;
	run;
%mend;

proc sort data = ds.acs_raw_newvars_ct;
by geoid_ct year1;
run;

%sortct(CT06_10);
%sortct(CT07_11);
%sortct(CT08_12);
%sortct(acs_09_13_ct_citizen_foreignborn);
%sortct(acs_10_14_ct_citizen_foreignborn);
%sortct(acs_11_15_ct_citizen_foreignborn);
%sortct(acs_12_16_ct);
%sortct(acs_13_17_ct_citizen_foreignborn);
%sortct(acs_14_18_ct_citizen_foreignborn);
%sortct(acs_15_19_ct);


proc contents data = d2.acs_15_19_ct_gini_movedonly varnum; run;

proc contents data = d2.CT06_10 varnum; run;

/* DO I NEED THE 15/19 GINI MOVED DS? */

data acs_raw_newvars_ct_wmissingdep;
  merge 
	ds.acs_raw_newvars_ct
/*	d2.acs_15_19_ct_gini_movedonly (rename = geoid = geoid_ct)*/
	d2.CT06_10
	d2.CT07_11
	d2.CT08_12
	d2.acs_09_13_ct_citizen_foreignborn
	d2.acs_10_14_ct_citizen_foreignborn
	d2.acs_11_15_ct_citizen_foreignborn
	d2.acs_12_16_ct
	d2.acs_13_17_ct_citizen_foreignborn
	d2.acs_14_18_ct_citizen_foreignborn
	d2.acs_15_19_ct
	;
	by geoid_ct year1;

	gini_ct = B19083001; /* Households: Gini Index */
	label gini_ct = "Gini index of inequality (Census Tracts)";

*	gini_moe_ct = B19083001s; /* [Std. Error: Households: Gini Index */
*	label gini_moe_ct = "[Margin of Error]Gini index of inequality (Census Tracts)";

	moved_1yr_ct = 
		(B07003001 /* Population 1 Year and Over in the United States */ - B07003004 /* Population 1 Year and Over in the United States: Same House 1 Year Ago */) /
		 B07003001 /* Population 1 Year and Over in the United States */ ;

	label moved_1yr_ct = "Proportion of population who moved houses within a year (Census Tracts";

	/*Citizenship*/

	not_citizen_ct = 
		B05001006 /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001 /*Total Population in the United States*/;

	label not_citizen_ct = "Proportion who are not U.S. Citizens ";

	not_citizen_moe_ct = 
		B05001006s /*Total Population in the United States: not U.S. Citizens*/ /
		B05001001s /*Total Population in the United States*/;

	label not_citizen_moe_ct = "[Margin of Error]Proportion who are not U.S. Citizens ";

	foreign_born_ct = 
		B05002013 /*Total Population in the United States: Foreign Born*/ /
		B05002001 /*Total Population in the United States*/;

	label foreign_born_ct = "Proportion who are foreign born ";

	foreign_born_moe_ct = 
		B05002013s /*Total Population in the United States: Foreign Born*/ /
		B05002001s /*Total Population in the United States*/;

	label foreign_born_moe_ct = "[Margin of Error]Proportion who are foreign born ";

	med_yearbuilt_ct = B25035001; /*Housing Units: Median Year Structure Built*/

	label med_yearbuilt_ct = "Median year homes in geographic unit were built";

	if year1 eq "2006" then year = 2008;
	if year1 eq "2007" then year = 2009;
	if year1 eq "2008" then year = 2010;
	if year1 eq "2009" then year = 2011;
	if year1 eq "2010" then year = 2012;
	if year1 eq "2011" then year = 2013;
	if year1 eq "2012" then year = 2014;
	if year1 eq "2013" then year = 2015;
	if year1 eq "2014" then year = 2016;
	if year1 eq "2015" then year = 2017;

	if moved_1yr_ct eq . then moved_1yr_ct = 0.1265713;
	if not_citizen_ct eq . then not_citizen_ct = 0.0292014;
	if foreign_born_ct eq . then foreign_born_ct = 0.0592782;
	if med_yearbuilt_ct eq . then med_yearbuilt_ct = 1959.00;

	keep geoid_ct year B19083001 gini_ct B07003001 B07003004 moved_1yr_ct B05001006 B05001001 not_citizen_ct B05001006s B05001001s not_citizen_moe_ct B05002013 B05002001 foreign_born_ct B05002013s B05002001s foreign_born_moe_ct B25035001 med_yearbuilt_ct gini_moe_ct moved_1yr_moe_ct;
run;

proc sort data = acs_raw_newvars_ct_wmissingdep; by geoid_ct year; run;

data acs_raw_newvars_ct_wmissingdep;
  merge 
	acs_raw_newvars_ct_wmissingdep
	ct12_16_moe
	ct15_19_moe
	;
	by geoid_ct year;
run;


/*proc print data = acs_raw_newvars_ct_wmissingdep (obs=100);*/
/*var year B19083001 gini_ct B07003001 B07003004 moved_1yr_ct B05001006 B05001001 not_citizen_ct B05002013 B05002001 foreign_born_ct B25035001 med_yearbuilt_ct;*/
/*where year in (2014 2015);*/
/*run;*/

proc sort data = acs_raw_newvars_ct_wmissingdep; by year; run;

proc means data = acs_raw_newvars_ct_wmissingdep nmiss mean median std min max;
var not_citizen_moe_ct foreign_born_moe_ct gini_moe_ct moved_1yr_moe_ct;
run;

/*
Years with missing not citizen and foreign born:
2017
2014
*/


proc export 
	data = acs_raw_newvars_ct_wmissingdep
	outfile = "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS\acs_raw_newvars_ct_wmissingdep.txt"
	dbms=tab
	replace;
run;
quit;




/* Vars to nbr avg? gini_ct moved_1yr_ct med_yearbuilt_ct not_citizen_ct foreign_born_ct*/




proc contents data = ds.acs_raw_newvars_ct varnum; run;
proc contents data = ds.acs_15_19_ct_gini_movedonly varnum; run;
proc contents data = CT06_10 varnum; run;



data ds.acs_newvars_ct; 
  set ds.acs_raw_newvars_ct;
run;


proc means data = ds.acs_raw_newvars_ct n nmiss mean min max;
var gini_ct moved_1yr_ct;
by year1;
run;


proc print data = ds.acs_raw_newvars_ct (obs=100);
var year1 B19083001 gini_ct B07003001 B07003004 moved_1yr_ct;
run;





/**********************************************************************************************/

/* Merge block group and census tract data */

libname ds "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

proc sort data = ds.acs_raw_newvars;
by geoid_ct year1;
run;

proc sort data = ds.acs_raw_newvars_ct;
by geoid_ct year1;
run;

data ds.acs_bg_ct;
  merge ds.acs_raw_newvars ds.acs_raw_newvars_ct;
  by geoid_ct year1;
	geoid_cnty = input(substr(geoid_bg,1,5), 8.);
run;

libname out "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";

data ds.acs_bg_ct_vars;
  set ds.acs_bg_ct;
	keep geoid geoid_bg geoid_ct geoid_cnty year1 year2 total_pop total_pop_moe age_45_74 age_45_74_moe age_ge65 age_ge65_moe male female male_moe female_moe white black asian_pacislander other white_moe black_moe asian_pacislander_moe other_moe hisp hisp_moe noenrolledinschool_3plus noenrolledinschool_3plus_moe nohsgrad_25plus nohsgrad_25plus_moe unemployed unemployed_moe med_houseincome med_houseincome_moe households_w_publicassist hhouseholds_w_publicassist_moe socsecinsur socsecinsur_moe belowpovertyline belowpovertyline_moe famkids_poverty famkids_poverty_moe householder45plus_poverty householder45plus_poverty2 householder45plus_poverty_moe householder45plus_poverty2_moe percapita_income percapita_income_moe gini gini_moe not_citizen not_citizen_moe foreign_born foreign_born_moe foreign_lang foreign_lang_moe commute_60minplus commute_60minplus_moe publtrans_bike_walk publtrans_bike_walk_moe veteran veteran_moe nonfam_households nonfam_households_moe singledad singlemom singledad_moe singlemom_moe house_units house_units_moe renter_occupied renter_occupied_moe vacant vacant_moe no_mortgage no_mortgage_moe occupantsperroom occupantsperroom_moe no_telephone no_telephone_moe no_vehicle no_vehicle_moe no_heat no_heat_moe lack_plumbing lack_plumbing_moe lack_kitchen lack_kitchen_moe med_yearbuilt med_yearbuilt_moe  gini moved_1yr total_pop_ct age_45_74_ct age_ge65_ct male_ct female_ct white_ct black_ct asian_pacislander_ct other_ct hisp_ct noenrolledinschool_3plus_ct nohsgrad_25plus_ct unemployed_ct households_w_publicassist_ct socsecinsur_ct belowpovertyline_ct famkids_poverty_ct /*householder45plus_poverty*/ householder45plus_poverty2_ct med_houseincome_ct percapita_income_ct /*gini not_citizen*/ foreign_lang_ct commute_60minplus_ct publtrans_bike_walk_ct veteran_ct nonfam_households_ct singledad_ct singlemom_ct house_units_ct renter_occupied_ct vacant_ct no_mortgage_ct occupantsperroom_ct no_telephone_ct no_vehicle_ct no_heat_ct lack_plumbing_ct lack_kitchen_ct med_yearbuilt_ct;
run;







/**********************************************************************************************/

/* Correcting Missing Census Data */

/* Options:

1) Delete block groups with missing data
2) Take the average from the surrounding block groups
3) Impute the missing block groups from the census tract or county

*/

*1) Delete block groups with missing data;
/*
data ds.acs_bg_nomiss;
  set ds.acs_bg_ct;
	array m(*) total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty2 med_houseincome percapita_income foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt gini moved_1yr;
	do i = 1 to dim(m);
		if m(i) eq . then delete;
	end;
	keep geoid geoid_bg geoid_ct geoid_cnty year1 year2 total_pop total_pop_moe age_45_74 age_45_74_moe age_ge65 age_ge65_moe male female male_moe female_moe white black asian_pacislander other white_moe black_moe asian_pacislander_moe other_moe hisp hisp_moe noenrolledinschool_3plus noenrolledinschool_3plus_moe nohsgrad_25plus nohsgrad_25plus_moe unemployed unemployed_moe med_houseincome med_houseincome_moe households_w_publicassist hhouseholds_w_publicassist_moe socsecinsur socsecinsur_moe belowpovertyline belowpovertyline_moe famkids_poverty famkids_poverty_moe householder45plus_poverty householder45plus_poverty2 householder45plus_poverty_moe householder45plus_poverty2_moe percapita_income percapita_income_moe gini gini_moe not_citizen not_citizen_moe foreign_born foreign_born_moe foreign_lang foreign_lang_moe commute_60minplus commute_60minplus_moe publtrans_bike_walk publtrans_bike_walk_moe veteran veteran_moe nonfam_households nonfam_households_moe singledad singlemom singledad_moe singlemom_moe house_units house_units_moe renter_occupied renter_occupied_moe vacant vacant_moe no_mortgage no_mortgage_moe occupantsperroom occupantsperroom_moe no_telephone no_telephone_moe no_vehicle no_vehicle_moe no_heat no_heat_moe lack_plumbing lack_plumbing_moe lack_kitchen lack_kitchen_moe med_yearbuilt med_yearbuilt_moe  gini moved_1yr total_pop_ct age_45_74_ct age_ge65_ct male_ct female_ct white_ct black_ct asian_pacislander_ct other_ct hisp_ct noenrolledinschool_3plus_ct nohsgrad_25plus_ct unemployed_ct households_w_publicassist_ct socsecinsur_ct belowpovertyline_ct famkids_poverty_ct householder45plus_poverty2_ct med_houseincome_ct percapita_income_ct foreign_lang_ct commute_60minplus_ct publtrans_bike_walk_ct veteran_ct nonfam_households_ct singledad_ct singlemom_ct house_units_ct renter_occupied_ct vacant_ct no_mortgage_ct occupantsperroom_ct no_telephone_ct no_vehicle_ct no_heat_ct lack_plumbing_ct lack_kitchen_ct med_yearbuilt_ct;
run;
*/
*obs before = 87,660, after = 79557;


*2) Take the average from the surrounding block groups;

proc import 
	 out = pa_bg_nbrs 
     datafile= "C:\Users\tuk04132\OneDrive - Temple University\Documents\ACS Data Test\PA 2010 BlkGrp Spatial Weights Matrix - Queen for SAS.txt" 
     dbms=dlm replace;
     delimiter='20'x; 
     getnames=noO;
     datarow=2; 
	 guessingrows=max;
run;

data pa_bg_nbrs_odd;
  set pa_bg_nbrs;
	if mod(_n_,2) ne 0 then output;
run;

data pa_bg_nbrs_odd;
  set pa_bg_nbrs_odd;
  	n = _n_;
	geoid_bg = var1;
	keep n geoid_bg;
run;

data pa_bg_nbrs_even;
  set pa_bg_nbrs;
	if mod(_n_,2) eq 0 then output;
run;

data pa_bg_nbrs_even;
  set pa_bg_nbrs_even;
  	n = _n_;
run;

data pa_bg_nbrs2;
 format geoid_bg;
 merge pa_bg_nbrs_odd pa_bg_nbrs_even;
 by n;
 nbrs = compress(strip(catx(" ", VAR1, VAR2, VAR3, VAR4, VAR5, VAR6, VAR7, VAR8, VAR9, VAR10, VAR11, VAR12, VAR13, VAR14, VAR15, VAR16, VAR17, VAR18, VAR19, VAR20, VAR21, VAR22, VAR23, VAR24, VAR25, VAR26, VAR27, VAR28, VAR29, VAR30, VAR31, VAR32, VAR33, VAR34, VAR35, VAR36, VAR37, VAR38, VAR39)),".");
 drop n;
run;

proc sort data = pa_bg_nbrs2;
by geoid_bg;
run;

data temp;
  set ds.acs_bg_ct_vars (keep=geoid geoid_bg geoid_ct geoid_cnty year1 year2 total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt);
run;

proc sort data = temp;
by geoid_bg year1;
run;

data ds.pa_bg_nbrs3;
  merge temp pa_bg_nbrs2 (drop= VAR1 VAR2 VAR3 VAR4 VAR5 VAR6 VAR7 VAR8 VAR9 VAR10 VAR11 VAR12 VAR13 VAR14 VAR15 VAR16 VAR17 VAR18 VAR19 VAR20 VAR21 VAR22 VAR23 VAR24 VAR25 VAR26 VAR27 VAR28 VAR29 VAR30 VAR31 VAR32 VAR33 VAR34 VAR35 VAR36 VAR37 VAR38 VAR39);
  by geoid_bg;
run;



%macro nbr;
%do j = 1 %to 9740;
%global nbr&j. geo&j.;
	data _null_;
	  set pa_bg_nbrs2;
		if _n_ eq &j. then call symput("nbr&j.",nbrs);
		if _n_ eq &j. then call symput("geo&j.",geoid_bg);
	run;
%end;
%mend;
%nbr;

proc sort data = ds.pa_bg_nbrs3;
by year1;
run;


options nomprint nosymbolgen;

%let year = 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015;
%let bgvarlist = total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;

%macro interp;
		%do i = 1 %to 9740;
			dm log "clear";

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = ds.pa_bg_nbrs3 mean maxdec=2;
				var &bgvarlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

			ods output close;

			%do j = 1 %to %sysfunc(countw(&year.));

				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
/*
					drop 

						%do h = 1 %to %sysfunc(countw(&bgvarlist.));

							VName_%scan(&bgvarlist., &h.)
							Label_%scan(&bgvarlist., &h.)

						%end;

					;
				run;
*/
			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));

					bg&&geo&i.._%scan(&year., &k.)

				%end;
			  ;
				rename 

					%do h = 1 %to %sysfunc(countw(&bgvarlist.));

						%scan(&bgvarlist., &h.)_Mean = %scan(&bgvarlist., &h.)

					%end;
				;
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));

					bg&&geo&i.._%scan(&year., &a.)

				%end;
			  ;
			run;
			quit;

			dm "odsresults; clear";

		%end;

			data ds.bg_interp_r;
			  set
				%do l = 1 %to 9740;

					bg&&geo&l.

				%end;
			  ;
			run;

			proc datasets library=work;
			   delete 
				%do b = 1 %to 9740;

					bg&&geo&b.

				%end;
			  ;
			run;
			quit;

			dm "odsresults; clear";

%mend;
%interp;


data ds.bg_interp_r;
  set ds.bg_interp_r;
	drop vname: label:;
run;

* adding suffix;

proc sql noprint;
   select cats(name,'=',name,'x')
          into :list
          separated by ' '
          from dictionary.columns
          where libname = 'DS' and memname = 'BG_INTERP_R';
quit;

proc sql noprint;
   select cats(name,'=',name,'i')
          into :list2
          separated by ' '
          from dictionary.columns
          where libname = 'DS' and memname = 'BG_INTERP_R';
quit;

proc sql noprint;
   select cats(name,'i')
          into :list3
          separated by ' '
          from dictionary.columns
          where libname = 'DS' and memname = 'BG_INTERP_R';
quit;

data bg_interp_r;
  set ds.bg_interp_r;
	array z(*) total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty householder45plus_poverty2 med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;
	do i = 1 to dim(z);
		if z(i) eq . then z(i) = 0;
	end;
	rename &list.;
	drop i;
run;

data bg_interp_r;
  set bg_interp_r;
	rename geoid_bgx = geoid_bg year1x = year1;
run;

proc contents data = bg_interp_r varnum;
run;

proc sort data = bg_interp_r;
by geoid_bg year1;
run;

proc sort data = temp;
by geoid_bg year1;
run;

data pa_bg_nbrs_avg;
  merge temp bg_interp_r (in=a);
  by geoid_bg year1;
  if a;
	array bg(*) total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty householder45plus_poverty2 med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;
	array bgx(*) total_popx age_45_74x age_ge65x malex femalex whitex blackx asian_pacislanderx otherx hispx noenrolledinschool_3plusx nohsgrad_25plusx unemployedx households_w_publicassistx socsecinsurx belowpovertylinex famkids_povertyx householder45plus_povertyx householder45plus_poverty2x med_houseincomex percapita_incomex foreign_langx commute_60minplusx publtrans_bike_walkx veteranx nonfam_householdsx singledadx singlemomx house_unitsx renter_occupiedx vacantx no_mortgagex occupantsperroomx no_telephonex no_vehiclex no_heatx lack_plumbingx lack_kitchenx med_yearbuilti;

	do i = 1 to dim(bg);
		if bg(i) eq . then bg(i) = bgx(i);
	end;

  rename &list2.;
  keep geoid geoid_bg geoid_ct geoid_cnty year1 year2 total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty householder45plus_poverty householder45plus_poverty2 med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;

run;

data ds.pa_bg_nbrs_avg;
  set pa_bg_nbrs_avg;
    rename geoid_bgi=geoid_bg year1i=year1;
run;

/*proc contents data = ds.pa_bg_nbrs_avg varnum;*/
/*run;*/
/**/
/*proc means data = ds.pa_bg_nbrs_avg nmiss;*/
/*var _numeric_;*/
/*run;*/







*3) Impute the missing block groups from the census tract or county;
libname acs "S:\Epi & Biostat\Research\Jones CRCS Team\Ryan\Dissertation\Data\ACS";
data ds.acs_bg_impute;
  set ds.acs_bg_ct;
	array bgs(*) total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty /*householder45plus_poverty*/ householder45plus_poverty2 med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;
	array ct(*) total_pop_ct age_45_74_ct age_ge65_ct male_ct female_ct white_ct black_ct asian_pacislander_ct other_ct hisp_ct noenrolledinschool_3plus_ct nohsgrad_25plus_ct unemployed_ct households_w_publicassist_ct socsecinsur_ct belowpovertyline_ct famkids_poverty_ct /*householder45plus_poverty*/ householder45plus_poverty2_ct med_houseincome_ct percapita_income_ct /*gini not_citizen*/ foreign_lang_ct commute_60minplus_ct publtrans_bike_walk_ct veteran_ct nonfam_households_ct singledad_ct singlemom_ct house_units_ct renter_occupied_ct vacant_ct no_mortgage_ct occupantsperroom_ct no_telephone_ct no_vehicle_ct no_heat_ct lack_plumbing_ct lack_kitchen_ct med_yearbuilt_ct;
	do i = 1 to dim(bgs);
		if bgs(i) eq . then bgs(i) = ct(i);
	end;
	keep geoid geoid_bg geoid_ct geoid_cnty year1 year2 total_pop total_pop_moe age_45_74 age_45_74_moe age_ge65 age_ge65_moe male female male_moe female_moe white black asian_pacislander other white_moe black_moe asian_pacislander_moe other_moe hisp hisp_moe noenrolledinschool_3plus noenrolledinschool_3plus_moe nohsgrad_25plus nohsgrad_25plus_moe unemployed unemployed_moe med_houseincome med_houseincome_moe households_w_publicassist hhouseholds_w_publicassist_moe socsecinsur socsecinsur_moe belowpovertyline belowpovertyline_moe famkids_poverty famkids_poverty_moe householder45plus_poverty householder45plus_poverty2 householder45plus_poverty_moe householder45plus_poverty2_moe percapita_income percapita_income_moe gini gini_moe not_citizen not_citizen_moe foreign_born foreign_born_moe foreign_lang foreign_lang_moe commute_60minplus commute_60minplus_moe publtrans_bike_walk publtrans_bike_walk_moe veteran veteran_moe nonfam_households nonfam_households_moe singledad singlemom singledad_moe singlemom_moe house_units house_units_moe renter_occupied renter_occupied_moe vacant vacant_moe no_mortgage no_mortgage_moe occupantsperroom occupantsperroom_moe no_telephone no_telephone_moe no_vehicle no_vehicle_moe no_heat no_heat_moe lack_plumbing lack_plumbing_moe lack_kitchen lack_kitchen_moe med_yearbuilt med_yearbuilt_moe  gini moved_1yr total_pop_ct age_45_74_ct age_ge65_ct male_ct female_ct white_ct black_ct asian_pacislander_ct other_ct hisp_ct noenrolledinschool_3plus_ct nohsgrad_25plus_ct unemployed_ct households_w_publicassist_ct socsecinsur_ct belowpovertyline_ct famkids_poverty_ct /*householder45plus_poverty*/ householder45plus_poverty2_ct med_houseincome_ct percapita_income_ct /*gini not_citizen*/ foreign_lang_ct commute_60minplus_ct publtrans_bike_walk_ct veteran_ct nonfam_households_ct singledad_ct singlemom_ct house_units_ct renter_occupied_ct vacant_ct no_mortgage_ct occupantsperroom_ct no_telephone_ct no_vehicle_ct no_heat_ct lack_plumbing_ct lack_kitchen_ct med_yearbuilt_ct;
run;

proc contents data = ds.acs_bg_ct varnum;
run;

proc print data = ds.acs_raw (obs=5);
where year1 eq "2015";
run;


proc sort data = ds.acs_bg_impute;
by year1;
run;

proc means data = ds.acs_bg_impute nmiss;
var total_pop age_45_74 age_ge65 male female white black asian_pacislander other hisp noenrolledinschool_3plus nohsgrad_25plus unemployed households_w_publicassist socsecinsur belowpovertyline famkids_poverty /*householder45plus_poverty*/ householder45plus_poverty2 med_houseincome percapita_income /*gini not_citizen*/ foreign_lang commute_60minplus publtrans_bike_walk veteran nonfam_households singledad singlemom house_units renter_occupied vacant no_mortgage occupantsperroom no_telephone no_vehicle no_heat lack_plumbing lack_kitchen med_yearbuilt;
run;




/* AVERAGE MARGIN OF ERROR FOR DEPRIVATION INDICATORS FROM NEIGHBORS */
dm log 'clear';
options nosource nonotes nomprint nosymbolgen;
proc import 
	 out = pa_bg_nbrs 
     datafile= "C:\Users\tuk04132\OneDrive - Temple University\Documents\ACS Data Test\PA 2010 BlkGrp Spatial Weights Matrix - Queen for SAS.txt" 
     dbms=dlm replace;
     delimiter='20'x; 
     getnames=noO;
     datarow=2; 
	 guessingrows=max;
run;

data pa_bg_nbrs_odd;
  set pa_bg_nbrs;
	if mod(_n_,2) ne 0 then output;
run;

data pa_bg_nbrs_odd;
  set pa_bg_nbrs_odd;
  	n = _n_;
	geoid_bg = var1;
	keep n geoid_bg;
run;

data pa_bg_nbrs_even;
  set pa_bg_nbrs;
	if mod(_n_,2) eq 0 then output;
run;

data pa_bg_nbrs_even;
  set pa_bg_nbrs_even;
  	n = _n_;
run;

data pa_bg_nbrs2;
 format geoid_bg;
 merge pa_bg_nbrs_odd pa_bg_nbrs_even;
 by n;
 nbrs = compress(strip(catx(" ", VAR1, VAR2, VAR3, VAR4, VAR5, VAR6, VAR7, VAR8, VAR9, VAR10, VAR11, VAR12, VAR13, VAR14, VAR15, VAR16, VAR17, VAR18, VAR19, VAR20, VAR21, VAR22, VAR23, VAR24, VAR25, VAR26, VAR27, VAR28, VAR29, VAR30, VAR31, VAR32, VAR33, VAR34, VAR35, VAR36, VAR37, VAR38, VAR39)),".");
 drop n;
run;

proc sort data = pa_bg_nbrs2;
by geoid_bg;
run;

data temp;
  set ds.acs_depvars_moe;
	rename geoid = geoid_bg;
	if year1 eq "2006" then year = 2008;
	if year1 eq "2007" then year = 2009;
	if year1 eq "2008" then year = 2010;
	if year1 eq "2009" then year = 2011;
	if year1 eq "2010" then year = 2012;
	if year1 eq "2011" then year = 2013;
	if year1 eq "2012" then year = 2014;
	if year1 eq "2013" then year = 2015;
	if year1 eq "2014" then year = 2016;
	if year1 eq "2015" then year = 2017;
	keep geoid year1 year2 noenrolledinschool_3plus_u households_w_publicassist_u householder45plus_poverty_u noenrolledinschool_3plus_l households_w_publicassist_l householder45plus_poverty_l;
run;

/*proc contents data = temp varnum; run;*/

proc sort data = temp;
by geoid_bg year1;
run;

data pa_bg_nbrs3;
  merge temp pa_bg_nbrs2 (drop= VAR1 VAR2 VAR3 VAR4 VAR5 VAR6 VAR7 VAR8 VAR9 VAR10 VAR11 VAR12 VAR13 VAR14 VAR15 VAR16 VAR17 VAR18 VAR19 VAR20 VAR21 VAR22 VAR23 VAR24 VAR25 VAR26 VAR27 VAR28 VAR29 VAR30 VAR31 VAR32 VAR33 VAR34 VAR35 VAR36 VAR37 VAR38 VAR39);
  by geoid_bg;
run;

%macro nbr;
%do j = 1 %to 9740;
%global nbr&j. geo&j.;
	data _null_;
	  set pa_bg_nbrs2;
		if _n_ eq &j. then call symput("nbr&j.",nbrs);
		if _n_ eq &j. then call symput("geo&j.",geoid_bg);
	run;
%end;
%mend;
%nbr;

proc sort data = pa_bg_nbrs3;
by year1;
run;

%let year = 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015;
*%let varlist = total_pop_u age_45_74_u age_ge65_u male_u female_u white_u black_u asian_pacislander_u other_u hisp_u /*noenrolledinschool_3plus_u*/ nohsgrad_25plus_u unemployed_u med_houseincome_u /*households_w_publicassist_u*/ socsecinsur_u belowpovertyline_u famkids_poverty_u /*householder45plus_poverty_u householder45plus_poverty2_u*/ percapita_income_u foreign_lang_u commute_60minplus_u publtrans_bike_walk_u veteran_u nonfam_households_u singledad_u singlemom_u house_units_u renter_occupied_u vacant_u no_mortgage_u occupantsperroom_u no_telephone_u no_vehicle_u no_heat_u lack_plumbing_u lack_kitchen_u gini_u_ct moved_1yr_u_ct not_citizen_u_ct foreign_born_u_ct total_pop_l age_45_74_l age_ge65_l male_l female_l white_l black_l asian_pacislander_l other_l hisp_l /*noenrolledinschool_3plus_l*/ nohsgrad_25plus_l unemployed_l med_houseincome_l /*households_w_publicassist_l*/ socsecinsur_l belowpovertyline_l famkids_poverty_l /*householder45plus_poverty_l householder45plus_poverty2_l*/ percapita_income_l foreign_lang_l commute_60minplus_l publtrans_bike_walk_l veteran_l nonfam_households_l singledad_l singlemom_l house_units_l renter_occupied_l vacant_l no_mortgage_l occupantsperroom_l no_telephone_l no_vehicle_l no_heat_l lack_plumbing_l lack_kitchen_l gini_l_ct moved_1yr_l_ct not_citizen_l_ct foreign_born_l_ct;
%let varlist = noenrolledinschool_3plus_u households_w_publicassist_u householder45plus_poverty_u noenrolledinschool_3plus_l households_w_publicassist_l householder45plus_poverty_l;

%macro interp;
	options nosource nonotes nomprint nosymbolgen;
		%do i = 1 %to 1000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 1001 %to 2000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 2001 %to 3000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 3001 %to 4000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 4001 %to 5000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 5001 %to 6000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 6001 %to 7000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 7001 %to 8000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 8001 %to 9000;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

		%do i = 9001 %to 9740;

			ods output Means.ByGroup1.Summary = bg&&geo&i.._2006;
			ods output Means.ByGroup2.Summary = bg&&geo&i.._2007;
			ods output Means.ByGroup3.Summary = bg&&geo&i.._2008;
			ods output Means.ByGroup4.Summary = bg&&geo&i.._2009;
			ods output Means.ByGroup5.Summary = bg&&geo&i.._2010;
			ods output Means.ByGroup6.Summary = bg&&geo&i.._2011;
			ods output Means.ByGroup7.Summary = bg&&geo&i.._2012;
			ods output Means.ByGroup8.Summary = bg&&geo&i.._2013;
			ods output Means.ByGroup9.Summary = bg&&geo&i.._2014;
			ods output Means.ByGroup10.Summary = bg&&geo&i.._2015;

			proc means data = pa_bg_nbrs3 mean maxdec=2;
				var &varlist.;
				by year1;
				where geoid_bg in (&&nbr&i.);
			run;

/*			ods output close;*/

			%do j = 1 %to %sysfunc(countw(&year.));
				data bg&&geo&i.._%scan(&year., &j.);
				  format geoid_bg;
				  set bg&&geo&i.._%scan(&year., &j.);
					geoid_bg = &&geo&i.;
				run;

			%end;

			data bg&&geo&i.;
			  set
				%do k = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &k.)
				%end;
			  ;
/*				rename */
/*					%do h = 1 %to %sysfunc(countw(&varlist.));*/
/*						%scan(&varlist., &h.)_Mean = %scan(&varlist., &h.)*/
/*					%end;*/
/*				;*/
			run;

			proc datasets library=work;
			   delete 
				%do a = 1 %to %sysfunc(countw(&year.));
					bg&&geo&i.._%scan(&year., &a.)
				%end;
			  ;
			run;
			quit;

		%end;

			data ds.bg_interp_r_moe01_mvars;
			  set
				%do l = 1 %to 1000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe02_mvars;
			  set
				%do l = 1001 %to 2000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe03_mvars;
			  set
				%do l = 2001 %to 3000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe04_mvars;
			  set
				%do l = 3001 %to 4000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe05_mvars;
			  set
				%do l = 4001 %to 5000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe06_mvars;
			  set
				%do l = 5001 %to 6000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe07_mvars;
			  set
				%do l = 6001 %to 7000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe08_mvars;
			  set
				%do l = 7001 %to 8000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe09_mvars;
			  set
				%do l = 8001 %to 9000;
					bg&&geo&l.
				%end;
			  ;
			run;

			data ds.bg_interp_r_moe10_mvars;
			  set
				%do l = 9001 %to 9740;
					bg&&geo&l.
				%end;
			  ;
			run;

/*			proc datasets library=work;*/
/*			   delete */
/*				%do b = 1 %to 9740;*/
/*					bg&&geo&b.*/
/*				%end;*/
/*			  ;*/
/*			run;*/
/*			quit;*/

/*			dm "odsresults; clear";*/
	options source notes nomprint nosymbolgen;
%mend;
%interp;

 
/*households_w_publicassist_l_Mean*/
/*noenrolledinschool_3plus_l_Mean*/
/*householder45plus_poverty_l_Mean*/
/*households_w_publicassist_u_Mean*/
/*noenrolledinschool_3plus_u_Mean*/
/*householder45plus_poverty_u_Mean*/



/* Margin of Error Data Set */

data bg_interp_r_moe_mvars;
  set 
	ds.bg_interp_r_moe01_mvars
	ds.bg_interp_r_moe02_mvars
	ds.bg_interp_r_moe03_mvars
	ds.bg_interp_r_moe04_mvars
	ds.bg_interp_r_moe05_mvars
	ds.bg_interp_r_moe06_mvars
	ds.bg_interp_r_moe07_mvars
	ds.bg_interp_r_moe08_mvars
	ds.bg_interp_r_moe09_mvars
	ds.bg_interp_r_moe10_mvars
;
	drop vname: label:;
run;

/*proc contents data = bg_interp_r_moe varnum short; run;*/

* removing and adding suffix;

proc sql noprint;
   select cats(name,'=',substr(name,1,length(name)-5),'x')
          into :list
          separated by ' '
          from dictionary.columns
          where libname = 'WORK' and memname = 'BG_INTERP_R_MOE_MVARS';
quit;

data bg_interp_r_moe2_mvars;
  set bg_interp_r_moe_mvars;
*	array z(*) total_pop_u_Mean age_45_74_u_Mean age_ge65_u_Mean male_u_Mean female_u_Mean white_u_Mean black_u_Mean asian_pacislander_u_Mean other_u_Mean hisp_u_Mean nohsgrad_25plus_u_Mean unemployed_u_Mean med_houseincome_u_Mean socsecinsur_u_Mean belowpovertyline_u_Mean famkids_poverty_u_Mean percapita_income_u_Mean foreign_lang_u_Mean commute_60minplus_u_Mean publtrans_bike_walk_u_Mean veteran_u_Mean nonfam_households_u_Mean singledad_u_Mean singlemom_u_Mean house_units_u_Mean renter_occupied_u_Mean vacant_u_Mean no_mortgage_u_Mean occupantsperroom_u_Mean no_telephone_u_Mean no_vehicle_u_Mean no_heat_u_Mean lack_plumbing_u_Mean lack_kitchen_u_Mean gini_u_ct_Mean moved_1yr_u_ct_Mean not_citizen_u_ct_Mean foreign_born_u_ct_Mean total_pop_l_Mean age_45_74_l_Mean age_ge65_l_Mean male_l_Mean female_l_Mean white_l_Mean black_l_Mean asian_pacislander_l_Mean other_l_Mean hisp_l_Mean nohsgrad_25plus_l_Mean unemployed_l_Mean med_houseincome_l_Mean socsecinsur_l_Mean belowpovertyline_l_Mean famkids_poverty_l_Mean percapita_income_l_Mean foreign_lang_l_Mean commute_60minplus_l_Mean publtrans_bike_walk_l_Mean veteran_l_Mean nonfam_households_l_Mean singledad_l_Mean singlemom_l_Mean house_units_l_Mean renter_occupied_l_Mean vacant_l_Mean no_mortgage_l_Mean occupantsperroom_l_Mean no_telephone_l_Mean no_vehicle_l_Mean no_heat_l_Mean lack_plumbing_l_Mean lack_kitchen_l_Mean gini_l_ct_Mean moved_1yr_l_ct_Mean not_citizen_l_ct_Mean foreign_born_l_ct_Mean;
	array z(*) noenrolledinschool_3plus_u_Mean households_w_publicassist_u_Mean householder45plus_poverty_u_Mean noenrolledinschool_3plus_l_Mean households_w_publicassist_l_Mean householder45plus_poverty_l_Mean;
	do i = 1 to dim(z);
		if z(i) eq . then z(i) = 0;
	end;
	rename &list.;
	drop i;
run;

proc sql noprint;
   select cats(substr(name,1,length(name)-1),'=',substr(name,1,length(name)-1),'i')
          into :list2
          separated by ' '
          from dictionary.columns
          where libname = 'WORK' and memname = 'BG_INTERP_R_MOE_MVARS';
quit;

/*proc contents data = bg_interp_r_moe2 varnum; run;*/

data bg_interp_r_moe_mvars;
  set bg_interp_r_moe2_mvars;
	rename geox = geoid_bg year1x = year1;
run;

/*proc contents data = bg_interp_r_moe varnum; run;*/

/*proc print data = bg_interp_r_moe (obs=100); run;*/

proc sort data = bg_interp_r_moe_mvars;
by geoid_bg year1;
run;

proc sort data = temp;
by geoid_bg year1;
run;

data pa_bg_nbrs_avg_moe_mvars;
  merge temp bg_interp_r_moe_mvars (in=a);
  by geoid_bg year1;
  if a;
/*	array bg(*) total_pop_u age_45_74_u age_ge65_u male_u female_u white_u black_u asian_pacislander_u other_u hisp_u nohsgrad_25plus_u unemployed_u med_houseincome_u socsecinsur_u belowpovertyline_u famkids_poverty_u percapita_income_u foreign_lang_u commute_60minplus_u publtrans_bike_walk_u veteran_u nonfam_households_u singledad_u singlemom_u house_units_u renter_occupied_u vacant_u no_mortgage_u occupantsperroom_u no_telephone_u no_vehicle_u no_heat_u lack_plumbing_u lack_kitchen_u gini_u_ct moved_1yr_u_ct not_citizen_u_ct foreign_born_u_ct total_pop_l age_45_74_l age_ge65_l male_l female_l white_l black_l asian_pacislander_l other_l hisp_l nohsgrad_25plus_l unemployed_l med_houseincome_l socsecinsur_l belowpovertyline_l famkids_poverty_l percapita_income_l foreign_lang_l commute_60minplus_l publtrans_bike_walk_l veteran_l nonfam_households_l singledad_l singlemom_l house_units_l renter_occupied_l vacant_l no_mortgage_l occupantsperroom_l no_telephone_l no_vehicle_l no_heat_l lack_plumbing_l lack_kitchen_l gini_l_ct moved_1yr_l_ct not_citizen_l_ct foreign_born_l_ct;*/
/*	array bgx(*) total_pop_ux age_45_74_ux age_ge65_ux male_ux female_ux white_ux black_ux asian_pacislander_ux other_ux hisp_ux nohsgrad_25plus_ux unemployed_ux med_houseincome_ux socsecinsur_ux belowpovertyline_ux famkids_poverty_ux percapita_income_ux foreign_lang_ux commute_60minplus_ux publtrans_bike_walk_ux veteran_ux nonfam_households_ux singledad_ux singlemom_ux house_units_ux renter_occupied_ux vacant_ux no_mortgage_ux occupantsperroom_ux no_telephone_ux no_vehicle_ux no_heat_ux lack_plumbing_ux lack_kitchen_ux gini_u_ctx moved_1yr_u_ctx not_citizen_u_ctx foreign_born_u_ctx total_pop_lx age_45_74_lx age_ge65_lx male_lx female_lx white_lx black_lx asian_pacislander_lx other_lx hisp_lx nohsgrad_25plus_lx unemployed_lx med_houseincome_lx socsecinsur_lx belowpovertyline_lx famkids_poverty_lx percapita_income_lx foreign_lang_lx commute_60minplus_lx publtrans_bike_walk_lx veteran_lx nonfam_households_lx singledad_lx singlemom_lx house_units_lx renter_occupied_lx vacant_lx no_mortgage_lx occupantsperroom_lx no_telephone_lx no_vehicle_lx no_heat_lx lack_plumbing_lx lack_kitchen_lx gini_l_ctx moved_1yr_l_ctx not_citizen_l_ctx foreign_born_l_ctx;*/

	array bg(*) noenrolledinschool_3plus_u households_w_publicassist_u householder45plus_poverty_u noenrolledinschool_3plus_l households_w_publicassist_l householder45plus_poverty_l;
	array bgx(*) noenrolledinschool_3plus_ux households_w_publicassist_ux householder45plus_poverty_ux noenrolledinschool_3plus_lx households_w_publicassist_lx householder45plus_poverty_lx;

	do i = 1 to dim(bg);
		if bg(i) eq . then bg(i) = bgx(i);
	end;
	rename &list2.;
  keep geoid geoid_bg geoid_ct geoid_cnty year1 year2 noenrolledinschool_3plus_u households_w_publicassist_u householder45plus_poverty_u noenrolledinschool_3plus_l households_w_publicassist_l householder45plus_poverty_l;

run;

/*noenrolledinschool_3plus_ui, householder45plus_poverty_ui, households_w_publicassist_ui*/

/*proc print data = pa_bg_nbrs_avg_moe (obs=100); run;*/

data ds.pa_bg_nbrs_avg_moe;
  set pa_bg_nbrs_avg_moe;
    rename year1i=year1;
run;

/*proc contents data = ds.pa_bg_nbrs_avg_moe varnum; run;*/

/*proc means data = ds.pa_bg_nbrs_avg nmiss;*/
/*var _numeric_;*/
/*run;*/


