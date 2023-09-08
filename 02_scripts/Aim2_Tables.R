
##### Load Libraries

library(tidyverse)
library(rlang)
library(plotrix)

##### Load Data

load("/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/crc_sorted8.Rdata")

geoid_ct <- read_tsv("/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/00_raw_data/geoid_ct.txt")[1:9740,]
crc_sorted8_wgct <- left_join(crc_sorted8, geoid_ct, by=c('geoid'='geoid'))
acs <- read_tsv("/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/00_raw_data/acs_raw_newvars_ct_wmissingdep.txt")
full.dep.ds <- left_join(crc_sorted8_wgct,acs, by=c('geoid_ct'='geoid_ct', 'year'='year'))

#imputing mean Gini for NA values
summary(full.dep.ds$gini_ct)
mean.gini <- 0.4179
full.dep.ds$gini_ct <- ifelse(is.na(full.dep.ds$gini_ct),mean.gini,full.dep.ds$gini_ct)
summary(full.dep.ds$gini_ct)


##### Table 1

var.list <- c("crc.x", "femalei", "malei", "asian_pacislanderi", "blacki", "otheri", "whitei", "hispi", "age_ge65i", "veterani", "foreign_born_ct", "not_citizen_ct", "nohsgrad_25plusi", "noenrolledinschool_3plusi", "singledadi", "singlemomi", "nonfam_householdsi", "moved_1yr_ct", "commute_60minplusi", "publtrans_bike_walki", "foreign_langi", "belowpovertylinei", "householder45plus_povertyi", "famkids_povertyi", "unemployedi", "med_houseincomei", "percapita_incomei", "gini_ct", "households_w_publicassisti", "socsecinsuri", "vacanti", "occupantsperroomi", "renter_occupiedi", "no_mortgagei", "no_telephonei", "no_vehiclei", "no_heati", "lack_plumbingi", "lack_kitcheni", "house_unitsi", "crcsadh", "ruca_3_mvu", "ruca_3_rvu", "mm2sfca_45_spar")

d.stats.ds <- data.frame()

d.stats <- function(x){
  d.stats <- c(x,mean(full.dep.ds[[x]]),std.error(full.dep.ds[[x]]),min(full.dep.ds[[x]]),max(full.dep.ds[[x]]),sum(is.na(full.dep.ds[[x]])))
  d.stats.ds <- rbind(d.stats.ds,d.stats)
  colnames(d.stats.ds) <- c("Name","Mean","Std","Min","Max","NA")
  assign("d.stats.ds", d.stats.ds, envir=.GlobalEnv)
}

lapply(var.list, d.stats)

write_csv(d.stats.ds,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/d.stats.ds.csv")









years <- c("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

yr.ds.null <- function(x){
  ds.null <- data.frame()
  assign(paste0("d.stats.ds.yr.",x), ds.null, envir=.GlobalEnv)  
}

lapply(years, yr.ds.null)

d.stats.yr <- function(x,yr){
  crc_sorted <- filter(full.dep.ds,year==yr)
  d.stats <- c(x,yr,mean(crc_sorted[[x]]),std.error(crc_sorted[[x]]),min(crc_sorted[[x]]),max(crc_sorted[[x]]))
  d.stats.ds.yr <- rbind(get(paste0("d.stats.ds.yr.",yr)),d.stats)
  colnames(d.stats.ds.yr) <- c("Name","Year","Mean","Std","Min","Max")
  assign(paste0("d.stats.ds.yr.",yr), d.stats.ds.yr, envir=.GlobalEnv)
}

d.stats.yr.fn <- function(x){
  lapply(var.list, d.stats.yr, yr=x)  
}

lapply(years, d.stats.yr.fn)

#summary(filter(full.dep.ds,year==2008) %>% dplyr::select(femalei))

d.stats.ds.yr <- rbind(d.stats.ds.yr.2008,d.stats.ds.yr.2009,d.stats.ds.yr.2010,d.stats.ds.yr.2011,d.stats.ds.yr.2012,d.stats.ds.yr.2013,d.stats.ds.yr.2014,d.stats.ds.yr.2015,d.stats.ds.yr.2016,d.stats.ds.yr.2017)

write_csv(d.stats.ds.yr,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/d.stats.ds.yr.csv")





# d.stats.ds.yr.2008 <- data.frame()
# d.stats.ds.yr.2009 <- data.frame()
# d.stats.ds.yr.2010 <- data.frame()
# d.stats.ds.yr.2011 <- data.frame()
# d.stats.ds.yr.2012 <- data.frame()
# d.stats.ds.yr.2013 <- data.frame()
# d.stats.ds.yr.2014 <- data.frame()
# d.stats.ds.yr.2015 <- data.frame()
# d.stats.ds.yr.2016 <- data.frame()
# d.stats.ds.yr.2017 <- data.frame()

# lapply(var.list, d.stats.yr, yr="2008")
# lapply(var.list, d.stats.yr, yr="2009")
# lapply(var.list, d.stats.yr, yr="2010")
# lapply(var.list, d.stats.yr, yr="2011")
# lapply(var.list, d.stats.yr, yr="2012")
# lapply(var.list, d.stats.yr, yr="2013")
# lapply(var.list, d.stats.yr, yr="2014")
# lapply(var.list, d.stats.yr, yr="2015")
# lapply(var.list, d.stats.yr, yr="2016")
# lapply(var.list, d.stats.yr, yr="2017")



##### Bivariate Relationships

library(stats)
library(Hmisc)

# Pearson's Correlation (All Continuous Vars)

dep.ds <- full.dep.ds %>% 
              dplyr::select(crc.x, femalei, malei, asian_pacislanderi, blacki, otheri, whitei, hispi, age_ge65i, veterani, foreign_born_ct, not_citizen_ct,
                            nohsgrad_25plusi, noenrolledinschool_3plusi, singledadi, singlemomi, nonfam_householdsi, moved_1yr_ct,
                            commute_60minplusi, publtrans_bike_walki, foreign_langi, 
                            belowpovertylinei, householder45plus_povertyi, famkids_povertyi, unemployedi, med_houseincomei, percapita_incomei, gini_ct,
                            households_w_publicassisti, socsecinsuri, 
                            vacanti, occupantsperroomi, renter_occupiedi, no_mortgagei, no_telephonei, no_vehiclei, no_heati, lack_plumbingi, lack_kitcheni, house_unitsi,
                            crcsadh, mm2sfca_45_spar)

# r stat

pearson.r <- cor(dep.ds.08, method = "pearson")

write_csv(as.data.frame(pearson.r),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/pearsons.corr.csv")

spearman.r <- cor(dep.ds.08, method = "spearman")

write_csv(as.data.frame(spearman.r),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/spearmans.corr.csv")


# p-value

pearson.pval <- rcorr(as.matrix(dep.ds.08),type="pearson")

write_csv(as.data.frame(pearson.pval[["P"]]),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/pearsons.corr.pval.csv")

spearmon.pval <- rcorr(as.matrix(dep.ds.08),type="spearman")

write_csv(as.data.frame(spearmon.pval[["P"]]),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/spearmons.corr.pval.csv")






### YEARLY

years <- c("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

corr.yr.fn <- function(x){

    ds <- full.dep.ds %>% 
      filter(year==x) %>%
      dplyr::select(crc.x, femalei, malei, asian_pacislanderi, blacki, otheri, whitei, hispi, age_ge65i, veterani, foreign_born_ct, not_citizen_ct,
                    nohsgrad_25plusi, noenrolledinschool_3plusi, singledadi, singlemomi, nonfam_householdsi, moved_1yr_ct,
                    commute_60minplusi, publtrans_bike_walki, foreign_langi, 
                    belowpovertylinei, householder45plus_povertyi, famkids_povertyi, unemployedi, med_houseincomei, percapita_incomei, gini_ct,
                    households_w_publicassisti, socsecinsuri, 
                    vacanti, occupantsperroomi, renter_occupiedi, no_mortgagei, no_telephonei, no_vehiclei, no_heati, lack_plumbingi, lack_kitcheni, house_unitsi,
                    crcsadh, mm2sfca_45_spar)
    
    # r stat
    
    pearson.r <- cor(ds, method = "pearson")
    assign(paste0("pearson.r.",x),pearson.r, envir = .GlobalEnv)
    
    spearman.r <- cor(ds, method = "spearman")
    assign(paste0("spearman.r.",x),spearman.r, envir = .GlobalEnv)
    
    # p-value
    
    pearson.pval <- rcorr(as.matrix(ds),type="pearson")
    assign(paste0("pearson.pval.",x),pearson.pval, envir = .GlobalEnv)
    
    spearmon.pval <- rcorr(as.matrix(ds),type="spearman")
    assign(paste0("spearman.pval.",x),spearmon.pval, envir = .GlobalEnv)
    
}

lapply(years,corr.yr.fn)


pearson.r.yrly <- rbind(pearson.r.2008,pearson.r.2009,pearson.r.2010,pearson.r.2011,pearson.r.2012,pearson.r.2013,pearson.r.2014,pearson.r.2015,pearson.r.2016,pearson.r.2017)
write_csv(as.data.frame(pearson.r.yrly),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/pearsons.corr.yrly.csv")

pearson.pval.yrly <- rbind(as.data.frame(pearson.pval.2008[["P"]]),as.data.frame(pearson.pval.2009[["P"]]),as.data.frame(pearson.pval.2010[["P"]]),as.data.frame(pearson.pval.2011[["P"]]),as.data.frame(pearson.pval.2012[["P"]]),as.data.frame(pearson.pval.2013[["P"]]),as.data.frame(pearson.pval.2014[["P"]]),as.data.frame(pearson.pval.2015[["P"]]),as.data.frame(pearson.pval.2016[["P"]]),as.data.frame(pearson.pval.2017[["P"]]))
write_csv(pearson.pval.yrly,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/pearsons.pval.yrly.csv")


spearman.r.yrly <- rbind(spearman.r.2008,spearman.r.2009,spearman.r.2010,spearman.r.2011,spearman.r.2012,spearman.r.2013,spearman.r.2014,spearman.r.2015,spearman.r.2016,spearman.r.2017)
write_csv(as.data.frame(spearman.r.yrly),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/spearmans.corr.yrly.csv")

spearman.pval.yrly <- rbind(as.data.frame(spearman.pval.2008[["P"]]),as.data.frame(spearman.pval.2009[["P"]]),as.data.frame(spearman.pval.2010[["P"]]),as.data.frame(spearman.pval.2011[["P"]]),as.data.frame(spearman.pval.2012[["P"]]),as.data.frame(spearman.pval.2013[["P"]]),as.data.frame(spearman.pval.2014[["P"]]),as.data.frame(spearman.pval.2015[["P"]]),as.data.frame(spearman.pval.2016[["P"]]),as.data.frame(spearman.pval.2017[["P"]]))
write_csv(spearman.pval.yrly,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/spearmans.pval.yrly.csv")













# ANOVA + Kruskal Wallis (RUCA x All Continuous Vars)

# Prepping data

Aim2.ds <- full.dep.ds %>% 
  dplyr::select(crc.x, femalei, malei, asian_pacislanderi, blacki, otheri, whitei, hispi, age_ge65i, veterani, foreign_born_ct, not_citizen_ct,
                nohsgrad_25plusi, noenrolledinschool_3plusi, singledadi, singlemomi, nonfam_householdsi, moved_1yr_ct,
                commute_60minplusi, publtrans_bike_walki, foreign_langi, 
                belowpovertylinei, householder45plus_povertyi, famkids_povertyi, unemployedi, med_houseincomei, percapita_incomei, gini_ct,
                households_w_publicassisti, socsecinsuri, 
                vacanti, occupantsperroomi, renter_occupiedi, no_mortgagei, no_telephonei, no_vehiclei, no_heati, lack_plumbingi, lack_kitcheni, house_unitsi,
                crcsadh, mm2sfca_30_spar, ruca_3_mvu, ruca_3_rvu)

Aim2.ds.yr <- full.dep.ds %>% 
  dplyr::select(crc.x, year, femalei, malei, asian_pacislanderi, blacki, otheri, whitei, hispi, age_ge65i, veterani, foreign_born_ct, not_citizen_ct,
                nohsgrad_25plusi, noenrolledinschool_3plusi, singledadi, singlemomi, nonfam_householdsi, moved_1yr_ct,
                commute_60minplusi, publtrans_bike_walki, foreign_langi, 
                belowpovertylinei, householder45plus_povertyi, famkids_povertyi, unemployedi, med_houseincomei, percapita_incomei, gini_ct,
                households_w_publicassisti, socsecinsuri, 
                vacanti, occupantsperroomi, renter_occupiedi, no_mortgagei, no_telephonei, no_vehiclei, no_heati, lack_plumbingi, lack_kitcheni, house_unitsi,
                crcsadh, mm2sfca_30_spar, ruca_3_mvu, ruca_3_rvu)


# Making 3cat variable

Aim2.ds <- Aim2.ds %>%
             mutate(ruca_3cat = ifelse(ruca_3_mvu == 0 & ruca_3_rvu == 0, 1, 
                                ifelse(ruca_3_mvu == 1 & ruca_3_rvu == 0, 2, 3)))

Aim2.ds.yr <- Aim2.ds.yr %>%
            mutate(ruca_3cat = ifelse(ruca_3_mvu == 0 & ruca_3_rvu == 0, 1, 
                                ifelse(ruca_3_mvu == 1 & ruca_3_rvu == 0, 2, 3)))

# ruca_3cat = 1 -> Urban
# ruca_3cat = 2 -> Metro
# ruca_3cat = 3 -> Rural


#Perform the Kruskal-Wallis test

kw.vars <- colnames(Aim2.ds)[1:42]
#anova_results = vector("list",length(Variables_to_regress))
#names(anova_results) = Variables_to_regress

kw.pvalues <- data.frame()

for (i in kw.vars) {
  this_formula <- as.formula(paste(i,"~ ruca_3cat"))
  kw.model <- kruskal.test(this_formula, data=Aim2.ds)
  kw.pv <- data.frame(paste(i),kw.model[["p.value"]])
  kw.pvalues <- rbind(kw.pvalues,kw.pv)
  colnames(kw.pvalues) <- c("Name","Kruskal-Wallis P-values")
}

write_csv(kw.pvalues,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/kw.pvalues.csv")






### YEARLY

years <- c("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

kw.vars <- colnames(Aim2.ds)[1:42]

kw.yr.fn <- function(x){

    kw.pvalues <- data.frame()

    for (i in kw.vars) {
      this_formula <- as.formula(paste(i,"~ ruca_3cat"))
      kw.model <- kruskal.test(this_formula, data=filter(Aim2.ds.yr,year==x))
      kw.pv <- data.frame(paste(i),kw.model[["p.value"]])
      colnames(kw.pv) <- c("Name","Kruskal-Wallis P-values")
      kw.pvalues <- rbind(kw.pvalues,kw.pv)
      colnames(kw.pvalues) <- c("Name","Kruskal-Wallis P-values")
    }
    
    assign(paste0("kw.pvalues.",x), kw.pvalues, envir = .GlobalEnv)

}

lapply(years,kw.yr.fn)

kw.pvalues.yrly <- rbind(kw.pvalues.2008,kw.pvalues.2009,kw.pvalues.2010,kw.pvalues.2011,kw.pvalues.2012,kw.pvalues.2013,kw.pvalues.2014,kw.pvalues.2015,kw.pvalues.2016,kw.pvalues.2017)
write_csv(as.data.frame(kw.pvalues.yrly),"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/kw.pvalues.yrly.csv")



# ANOVA - syntax taken from stackexchange - https://stackoverflow.com/questions/60702814/create-a-table-with-looped-anova-results-r

library(car)

Variables_to_regress = colnames(Aim2.ds)[1:43]
anova_results = vector("list",length(Variables_to_regress))
names(anova_results) = Variables_to_regress

anova.pvalues <- data.frame()

for (i in Variables_to_regress) {
  this_formula = as.formula(paste(i,"~ ruca_3cat"))
  model = aov(formula=this_formula, data=Aim2.ds)
  anova_results[[i]] = Anova(model, data=Aim2.ds,type="III")
  pv <- data.frame(paste(i),data.frame(anova_results[[i]])[2,4])
  anova.pvalues <- rbind(anova.pvalues,pv)
  colnames(anova.pvalues) <- c("Name","ANOVA P-values")
}

write_csv(anova.pvalues,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/anova.pvalues.csv")


### YEARLY

years <- c("2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

Variables_to_regress = colnames(Aim2.ds)[1:42]
anova_results = vector("list",length(Variables_to_regress))
names(anova_results) = Variables_to_regress

anova.yr.fn <- function(x){
  
    anova.pvalues <- data.frame()
    
    for (i in Variables_to_regress) {
      this_formula = as.formula(paste(i,"~ ruca_3cat"))
      model = aov(formula=this_formula, data=filter(Aim2.ds.yr,year==x))
      anova_results[[i]] = Anova(model, data=filter(Aim2.ds.yr,year==x),type="III")
      pv <- data.frame(paste(i),data.frame(anova_results[[i]])[2,4])
      colnames(pv) <- c("Name","ANOVA P-values")
      anova.pvalues <- rbind(anova.pvalues,pv)
      colnames(anova.pvalues) <- c("Name","ANOVA P-values")
    }
    
    assign(paste0("anova.pvalues.",x), anova.pvalues, envir = .GlobalEnv)
    
}

lapply(years,anova.yr.fn)

anova.pvalues.yrly <- rbind(anova.pvalues.2008,anova.pvalues.2009,anova.pvalues.2010,anova.pvalues.2011,anova.pvalues.2012,anova.pvalues.2013,anova.pvalues.2014,anova.pvalues.2015,anova.pvalues.2016,anova.pvalues.2017)
write_csv(anova.pvalues.yrly,"/Users/rsnead91/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/03_output/anova.pvalues.yrly.csv")








