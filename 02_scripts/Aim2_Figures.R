
##### Load Libraries

library(tidyverse)
library(rlang)
library(ggspatial)
library(tidycensus)
library(tigris)
library(rgdal)
library(sp)
library(sf)
library(spData)
library(spdep)
library(ggplot2)
library(stringr)
library(cowplot)
library(RColorBrewer)
library(gridExtra)
library(rlang)
library(haven)
library(maptools)
library(plyr)
library(plotrix)

##### Load Data

pa_bg_nbrs_avg_moe <- read_sas("00_raw_data/pa_bg_nbrs_avg_moe.sas7bdat")
save(pa_bg_nbrs_avg_moe, file = "01_clean_data/pa_bg_nbrs_avg_moe.Rdata")

pa_bg_nbrs_avg_moe_mvars <- read_sas("00_raw_data/pa_bg_nbrs_avg_moe_mvars.sas7bdat")
save(pa_bg_nbrs_avg_moe_mvars, file = "01_clean_data/pa_bg_nbrs_avg_moe_mvars.Rdata")

# load("01_clean_data/crc_sorted8.Rdata")
# load("01_clean_data/bg.long.df.rr.rds")

# geoid_ct <- read_tsv("00_raw_data/geoid_ct.txt")[1:9740,]
# crc_sorted8_wgct <- left_join(crc_sorted8, geoid_ct, by=c('geoid'='geoid'))
# acs <- read_tsv("00_raw_data/acs_raw_newvars_ct_wmissingdep.txt")
# full.dep.ds <- left_join(crc_sorted8_wgct,acs, by=c('geoid_ct'='geoid_ct', 'year'='year'))

#imputing mean Gini for NA values
# summary(full.dep.ds$gini_ct)
# mean.gini <- 0.4179
# full.dep.ds$gini_ct <- ifelse(is.na(full.dep.ds$gini_ct),mean.gini,full.dep.ds$gini_ct)

# load("01_clean_data/wqs.model.vars.Rdata")
# 
# Aim2.fig.ds <- left_join(full.dep.ds, wqs.model.vars, by=c('geoid'='geoid', 'year'='year')) %>% dplyr::select(geoid, year, crc.x, mm2sfca_45_spar, crcsadh_sigcol, crcsadh_fobt, ruca2010, ruca_b, ruca_3_mvu, ruca_3_rvu, femalei, malei, asian_pacislanderi, blacki, otheri, whitei, hispi, age_ge65i, veterani, foreign_born_ct, not_citizen_ct, nohsgrad_25plusi, noenrolledinschool_3plusi, singledadi, singlemomi, nonfam_householdsi, moved_1yr_ct, commute_60minplusi, publtrans_bike_walki, foreign_langi, belowpovertylinei, householder45plus_povertyi, famkids_povertyi, unemployedi, med_houseincomei, percapita_incomei, gini_ct, households_w_publicassisti, socsecinsuri,  vacanti, occupantsperroomi, renter_occupiedi, no_mortgagei, no_telephonei, no_vehiclei, no_heati, lack_plumbingi, lack_kitcheni, house_unitsi, wqs)
# ruca_v_mvu, ruca_v_rvu, 

# rm(full.dep.ds,acs,crc_sorted8,crc_sorted8_wgct,geoid_ct,wqs.model.vars)

# load("01_clean_data/bg_rate_spatial_df.Rdata")
# bg.rate.spatial.df <- mutate(bg.rate.spatial.df, geoid = as.double(GEOID))

# load("01_clean_data/bg_rate_long_df.Rdata")

cb_2018_42_bg_500k <- readOGR("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 4. Aim 1 - Access/Aim1_RProject/Aim1_RProject/01_clean_data/cb_2018_42_bg_500k.shp")
nopopgeo <- c(420089800001, 421019806001, 420459800001, 421019805001, 420490124000, 420039808001, 421019804001, 420039812001)
cb_2018_42_bg_500k <- cb_2018_42_bg_500k[ ! cb_2018_42_bg_500k$GEOID %in% nopopgeo, ]


# Spatial

Aim2.fig.ds.avg <- aggregate(x= Aim2.fig.ds$wqs, by = list(Aim2.fig.ds$geoid), FUN = mean) %>% rename(geoid = Group.1, wqs_avg = x)

bg.rate.spatial.df.fig <- left_join(x=bg.rate.spatial.df, y=Aim2.fig.ds.avg, by='geoid', keep.x=TRUE)

pa_counties <- counties(state = "42", cb = TRUE, class = "sf")

counties_phil_pitt <- filter(pa_counties, COUNTYFP %in% c("003","101"))


##### PA Map of WQS Index Results

## Based on Quintiles ##

######################################

# Creating quintile categorical vars first

# Download PA block groups 2010 geography

options(tigris_use_cache = TRUE)
options(tigris_class = "sf")

pa_bg <- block_groups(state="PA", cb=TRUE, year=2010)

# Creating new 12 character geoid to merge with ds

pa_bg2 <- pa_bg %>% mutate(geoid = as.numeric(str_sub(GEO_ID, 10)))

# Creating final ds for figures, overall, philly, pitt

nopopgeo <- c(420179800001, 421019806001, 420459800001, 421019805001, 420490124000, 420039808001, 421019804001, 420039812001)
pa_bg2 <- pa_bg2[ ! pa_bg2$geoid %in% nopopgeo, ]

pa_joined <- left_join(pa_bg2, Aim2.fig.ds.avg, by = c("geoid" = "geoid"))

q <- quantile(pa_joined$wqs_avg, probs=c(0,.2,.4,.6,.8,1))
cut.q <- c(0,q)

q9 <- quantile(pa_joined$wqs_avg.x, probs=c(0,.11,.22,.33,.44,.55,.66,.77,.88,.99,1))
cut.q9 <- c(0,q9)

pa_joined <- pa_joined %>%
  mutate(wqs_avg.q = cut(wqs_avg, q, label=FALSE, include.lowest=TRUE)) %>%
  mutate(wqs_avg.q9 = cut(wqs_avg.x, q9, label=FALSE, include.lowest=TRUE))

# pa_joined <- left_join(pa_bg2, filter(Aim2.fig.ds, year==2008), by = c("geoid" = "geoid"))
# 
# q <- quantile(pa_joined$wqs, probs=c(0,.2,.4,.6,.8,1))
# cut.q <- c(0,q)
# 
# pa_joined <- pa_joined %>%
  # mutate(wqs.q = cut(wqs, q, label=FALSE, include.lowest=TRUE))


# pa_joined <- left_join(pa_bg2, bg.rate.spatial.df, by = c("geoid" = "geoid"))
pa_joined <- left_join(pa_joined, Aim2.fig.ds.avg, by = c("geoid" = "geoid")) %>%
  mutate(wqs_avg.q = cut(Aim2.fig.ds.avg$wqs_avg, q, label=FALSE, include.lowest=TRUE))

# pa_bg_philly <- dplyr::filter(pa_joined, COUNTYFP.x == "101")
# pa_bg_pitt <- dplyr::filter(pa_joined, COUNTYFP.x == "003")




## Harmonizing projections for maps

# pa_joined_3083 <- st_transform(pa_joined, crs = 3083)
# pa_bg_philly_3083 <- st_transform(pa_bg_philly, crs = 3083)
# pa_bg_pitt_3083 <- st_transform(pa_bg_pitt, crs = 3083)



# Creating boundary around philly/pitt

# pa_bg_philly_3083_bb = st_as_sfc(st_bbox(pa_bg_philly_3083))
# pa_bg_philly_3083_bb = st_buffer(pa_bg_philly_3083_bb, dist = 10000)

# pa_bg_pitt_3083_bb = st_as_sfc(st_bbox(pa_bg_pitt_3083))
# pa_bg_pitt_3083_bb = st_buffer(pa_bg_pitt_3083_bb, dist = 1000)



# checking boundary boxes

# ggplot() +
#   geom_sf(data = pa_joined_3083, fill = "white", size = 0.2) +
#   geom_sf(data = pa_bg_philly_3083_bb, fill = NA, color = "blue", size = 1.2) +
#   geom_sf(data = pa_bg_pitt_3083_bb, fill = NA, color = "blue", size = 1.2) +
#   theme_void()
# brewer.pal(3, name = "RdBu")




## Map of Access Quantiles

cols <- c("#eff3ff","#bdd7e7","#6baed6","#3182bd","#08519c")
cols2 <- c("#ca0020","#f4a582","#bababa","#92c5de","#0571b0")
cols3 <- c("#0571b0","#92c5de","#bababa","#f4a582","#ca0020")
cols.reds <- c("#feedde","#fdbe85","#fd8d3c","#e6550d","#a63603")
cols.red.blue <- c("#2166ac","#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")
cols.blues <- c("#eff3ff","#bdd7e7","#6baed6","#3182bd","#08519c")
cols.greys <- c("#f7f7f7","#cccccc","#969696","#636363","#252525")

cols9.pink <- c("#f7f4f9","#e7e1ef","#d4b9da","#c994c7","#df65b0","#e7298a","#ce1256","#980043","#67001f")


# scale_fill_manual(values = cols3, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
# scale_color_manual(values = cols3, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
  


pa1 <- ggplot(pa_joined) +
  geom_sf(color = NA, aes(fill = as.factor(wqs_avg.q9))) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  geom_sf(data = pa_counties, fill = NA, color = "grey25", size = 0.5) +
  scale_fill_manual(values = cols9.pink, labels = c('Q1','Q2','Q3','Q4','Q5','Q6','Q7','Q8','Q9'), limits= c("1","2","3","4","5","6","7","8","9"), drop=FALSE, na.value = "white") + 
  scale_color_manual(values = cols9.pink, limits= c("1","2","3","4","5","6","7","8","9"), drop=FALSE, na.value = "white") +   
  guides(fill=guide_legend(title="Deprivation Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5-2. Map of Pennsylvania Deprivation at the Block Group Level, from 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0.5),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
    )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))
  
# print(pa1)

pa1 <- pa1 + 
  geom_rect(
  xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
  ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
  xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
  ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
  fill = NA, 
  colour = "black",
  size = 0.6
) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )

ggdraw(pa1) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(2,4)],
          datum=NA, expand = FALSE) + 
      theme(legend.position = "none", plot.caption = element_blank()) 
    },
    x = 0.655, y = 0.31,
    width = 0.3, height = 0.3) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank())
    },
    x = 0.66, y = 0.643,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.805, y = 0.303,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.808, y = 0.635,
    family = "Times New Roman"
  ) 
ggsave("03_figures/WQS Avg w PA Inset.png", height=4, width=6, units="in")









#####################################################################################

pa1 <- ggplot(pa_joined) +
  geom_sf(color = NA, aes(fill = as.factor(wqs_avg.q))) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  geom_sf(data = pa_counties, fill = NA, color = "grey25", size = 0.5) +
  scale_fill_manual(values = cols3, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols3, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  guides(fill=guide_legend(title="Area-level Deprivation Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5-2. Area-level Deprivation at the Block Group Level in Pennsylvania\nAveraged from 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))

philly <- ggplot(filter(pa_joined, COUNTY == "101")) +
  geom_sf(aes(fill = as.factor(wqs_avg.q)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  geom_sf(data = filter(pa_counties, COUNTYFP == "101"), fill = NA, color = "grey25", size = 1) +
  scale_fill_manual(values = cols3, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols3, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "transparent", color = NA),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position="none"
  )
print(philly)

pitt <- ggplot() +
  geom_sf(data = filter(pa_joined, COUNTY == "003"), aes(fill = as.factor(wqs_avg.q)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  geom_sf(data = filter(pa_counties, COUNTYFP == "003"), fill = NA, color = "grey25", size = 1) +
  scale_fill_manual(values = cols3, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols3, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "transparent", color = NA),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position="none"
  )
print(pitt)


pa1 <- pa1 + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  ) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )


ggdraw(pa1) +
  draw_plot(
    philly,
    x = 0.525, y = 0.25,
    width = 0.6, height = 0.6) +
  draw_plot(
    pitt,
    x = 0.635, y = 0.65,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.9, y = 0.42,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.93, y = 0.87,
    family = "Times New Roman"
  ) 
ggsave("03_figures/WQS Avg w PA Inset - nobox.png", height=4, width=6, units="in")






#####################################################################################
#####################################################################################
#####################################################################################

q <- quantile(Aim2.fig.ds$wqs, probs=c(0,.2,.4,.6,.8,1))

Aim2.fig.ds$wqs.q <- cut(Aim2.fig.ds$wqs, q, label=FALSE, include.lowest=TRUE)

bg_rate_2008 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2008), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2009 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2009), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2010 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2010), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2011 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2011), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2012 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2012), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2013 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2013), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2014 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2014), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2015 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2015), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2016 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2016), by.x="GEOID", by.y="geoid", all = TRUE)
bg_rate_2017 <- merge(x=cb_2018_42_bg_500k, y=filter(dplyr::select(Aim2.fig.ds, geoid, year, wqs.q), year==2017), by.x="GEOID", by.y="geoid", all = TRUE)

bg_rate_long <- rbind(bg_rate_2008, bg_rate_2009, bg_rate_2010, bg_rate_2011, bg_rate_2012, bg_rate_2013, bg_rate_2014, bg_rate_2015, bg_rate_2016, bg_rate_2017)

bg_rate_long@data$id <- bg_rate_long@data$GEOID
bg_rate_long.points = fortify(bg_rate_long, region="id")
bg_rate_long.df = join(bg_rate_long.points, bg_rate_long@data, by="id")

bg_rate_long.df$wqs.q.na <- ifelse(bg_rate_long.df$wqs.q==0, NA, bg_rate_long.df$wqs.q)

ggplot(bg_rate_long.df[complete.cases(bg_rate_long.df$year), ]) + 
  aes(long,lat,group=group,color=as.factor(wqs.q),fill=as.factor(wqs.q)) + 
  geom_polygon() +
  scale_fill_manual(values = cols3, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols3, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  coord_map(projection="mercator") + 
  guides(fill=guide_legend(title="Area-level Deprivation Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  facet_wrap(~year, nrow=2, ncol=5) +
  labs(caption="Figure 1. Annual Area-level Deprivation at the Block Group-level in Pennsylvania\nfrom 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    strip.text = element_text(family="Times New Roman"),
    strip.background = element_blank()
  )
ggsave("Appendix. Annual Area-level Deprivation.png", width=9, height=4, units="in")

#####################################################################################
#####################################################################################
#####################################################################################















# philly1 <- ggplot(pa_bg_philly, aes(fill = as.factor(wqs_avg.q))) +
#   geom_sf(color = NA) + # removes boundary lines around polygons
# #  coord_sf(crs=3083, datum=NA) + # sets projection for map
#   theme_void() + # removes all background from map
#   scale_fill_manual(values = cols3) +
#   theme(legend.position="none")
# print(philly1)

# pitt1 <- ggplot(pa_bg_pitt, aes(fill = as.factor(wqs.q))) +
#   geom_sf(color = NA) + # removes boundary lines around polygons
# #  coord_sf(crs=3083, datum=NA) + # sets projection for map
#   theme_void() + # removes all background from map
#   scale_fill_manual(values = cols3) +
#   theme(legend.position="none")
# print(pitt1)

# pa1 + 
#   coord_sf(
#     xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTYFP.x == "101"))[c(1,3)],
#     ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTYFP.x == "101"))[c(2,4)],
#     expand = FALSE)

# pa1 + 
#   coord_sf(
#     xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTYFP.x == "003"))[c(1,3)],
#     ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTYFP.x == "003"))[c(2,4)],
#     expand = FALSE)






## Map of Overall CRC Relative Risk

cols.rr <- c("#2166ac","#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")
cols.rr5 <- c("#2166ac","#67a9cf","#d1e5f0","#ef8a62","#b2182b")
cols.rr4 <- c("#67a9cf","#d1e5f0","#fddbc7","#ef8a62")

cols <- c("#eff3ff","#bdd7e7","#6baed6","#3182bd","#08519c")
cols2 <- c("#ca0020","#f4a582","#bababa","#92c5de","#0571b0")
cols3 <- c("#0571b0","#92c5de","#bababa","#f4a582","#ca0020")
cols.reds <- c("#feedde","#fdbe85","#fd8d3c","#e6550d","#a63603")
cols.red.blue <- c("#2166ac","#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")
cols.blues <- c("#eff3ff","#bdd7e7","#6baed6","#3182bd","#08519c")
cols.greys <- c("#f7f7f7","#cccccc","#969696","#636363","#252525")

cols.resid <- c("#2166ac","#67a9cf","#d1e5f0","#bababa","#ca0020")


# bg.long.df.rr.08 <- filter(bg.long.df.rr, year==2008)
# dep.rr.08.sptl <- bg.long.df.rr.08[!duplicated(bg.long.df.rr.08[ , "GEOID"]), ] %>% dplyr::select(GEOID, relrisk.geoid, relrisk.q)
# dep.rr.08.sptl$relrisk.q <- as.factor(cut(dep.rr.08.sptl$relrisk.geoid, quantile(dep.rr.08.sptl$relrisk.geoid, probs=c(0,.2,.4,.6,.8,1)), label=FALSE, include.lowest=TRUE))
# quantile(dep.rr.08.sptl$relrisk.geoid, probs=c(0,.2,.4,.6,.8,1))
# '[1.07 - 1.26]','[1.26 - 1.34]','[1.34 - 1.44]','[1.44 - 1.60]','[1.60 - 2.98]'
# dep.rr.08.sptl$geoid <- as.numeric(dep.rr.08.sptl$GEOID)


wqs.model.pred.rr <- exp(wqs.model.vars$wqs.pred.values)[87580:97310]

wqs.model.pred.rr.ds <- cbind(pa_joined, wqs.model.pred.rr) %>%
  mutate(wqs.pred.q = cut(wqs.model.pred.rr.ds$wqs.model.pred.rr, quantile(wqs.model.pred.rr.ds$wqs.model.pred.rr, probs=c(0,.2,.4,.6,.8,1)), label=FALSE, include.lowest=TRUE))




bg.spatial.df.rr.08 <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/bg.spatial.df.rr.08.rds")
bg.spatial.df.rr.17 <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/bg.spatial.df.rr.17.rds")

df.rr.08 <- distinct(dplyr::select(bg.spatial.df.rr.08, GEOID, rr.2008, rr.q.08))

df.rr.08$geoid <- as.numeric(df.rr.08$GEOID)

df.rr.17 <- distinct(dplyr::select(bg.spatial.df.rr.17, GEOID, rr.2017, rr.q.17))

df.rr.17$geoid <- as.numeric(df.rr.17$GEOID)

df.rr.08.17 <- left_join(x=df.rr.08, y=df.rr.17, by='geoid', keep.x=TRUE)

pa_joined2 <- left_join(x=pa_joined, y=df.rr.08.17, by='geoid', keep.x=TRUE)

pa_bg_philly <- dplyr::filter(pa_joined2, COUNTYFP == "101")
pa_bg_pitt <- dplyr::filter(pa_joined2, COUNTYFP == "003")

# quantile(dep.rr.08.sptl$relrisk.geoid, probs=c(0,.2,.4,.6,.8,1))

colnames(resid.risk.ds) <- c("r2008", "r2009", "r2010", "r2011", "r2012", "r2013", "r2014", "r2015", "r2016", "r2017")

rr.resid.08 = cut(resid.risk.ds[,"r2008"], c(0.4410663,0.6676030,0.7471550,0.8083974,1.7775204,221.3989054), label=FALSE, include.lowest=TRUE)
rr.resid.08.v2 = cut(resid.risk.ds[,"r2008"], c(0,.75,1,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.resid.17 = cut(resid.risk.ds[,"r2017"], c(0.4410663,0.6676030,0.7471550,0.8083974,1.7775204,221.3989054), label=FALSE, include.lowest=TRUE)
rr.resid.17.v2 = cut(resid.risk.ds[,"r2017"], c(0,.75,1,1.25,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined2,rr.resid.08,rr.resid.17,rr.resid.08.v2,rr.resid.17.v2)

# '[1.01 - 1.25]','[1.25 - 1.50]','[1.50 - 1.75]','[1.75+]'

# 2008

# scale_fill_manual(values = cols.reds, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
# scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
# scale_fill_manual(values=cols.rr5, labels = c('[<0.50]','[0.50-0.75]', '[0.75, 1.00]', '[1.00, 1.50]', '[>1.50]','No CRC'), limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +
# scale_color_manual(values=cols.rr5, limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +
  
pa1 <- ggplot(pa_joined3) +
  geom_sf(aes(fill = as.factor(rr.resid.08.v2)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  geom_sf(data = pa_counties, fill = NA, color = "grey25", size = 0.5) +
  scale_fill_manual(values=cols.rr4, labels = c('[<0.75]', '[0.75, 1.00]', '[1.00, 1.75]', '[>1.75]','No CRC'), limits= c("1","2","3","4"), na.value="grey", drop=FALSE) +
  scale_color_manual(values=cols.rr4, limits= c("1","2","3","4"), na.value="grey", drop=FALSE) +
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5-4a. Map of Pennsylvania Relative Risk of CRC Incidence\nat the Block Group Level (2008)") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))

pa1 <- pa1 + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  ) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )

ggdraw(pa1) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank()) 
    },
    x = 0.655, y = 0.31,
    width = 0.3, height = 0.3) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank())
    },
    x = 0.66, y = 0.643,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.805, y = 0.303,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.808, y = 0.635,
    family = "Times New Roman"
  ) 
ggsave("03_figures/Dep RR w PA Inset - 2008 - resid.v2.png", height=4, width=6, units="in")








# 2017

pa1 <- ggplot(pa_joined3) +
  geom_sf(aes(fill = as.factor(rr.resid.17.v2)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  geom_sf(data = pa_counties, fill = NA, color = "grey25", size = 0.5) +
  scale_fill_manual(values=cols.rr4, labels = c('[<0.75]', '[0.75, 1.00]', '[1.00, 1.75]', '[>1.75]','No CRC'), limits= c("1","2","3","4"), na.value="grey", drop=FALSE) +
  scale_color_manual(values=cols.rr4, limits= c("1","2","3","4"), na.value="grey", drop=FALSE) +
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5-4b. Map of Pennsylvania Relative Risk of CRC Incidence\nat the Block Group Level (2017)") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))

pa1 <- pa1 + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  ) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )

ggdraw(pa1) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank()) 
    },
    x = 0.655, y = 0.31,
    width = 0.3, height = 0.3) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank())
    },
    x = 0.66, y = 0.643,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.805, y = 0.303,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.808, y = 0.635,
    family = "Times New Roman"
  ) 
ggsave("03_figures/Dep RR w PA Inset - 2017 - resid.v2.png", height=4, width=6, units="in")





################################################################################

cols.rr <- c("#2166ac","#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")
cols.rr5 <- c("#2166ac","#67a9cf","#d1e5f0","#ef8a62","#b2182b")
cols.rr5r <- c("#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")
cols.rr4 <- c("#67a9cf","#d1e5f0","#fddbc7","#ef8a62")

# scale_fill_manual(values = cols.reds, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
# scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
# scale_fill_manual(values=cols.rr5, labels = c('[<0.50]','[0.50-0.75]', '[0.75, 1.00]', '[1.00, 1.50]', '[>1.50]','No CRC'), limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +
# scale_color_manual(values=cols.rr5, limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +



colnames(resid.risk.ds) <- c("r2008", "r2009", "r2010", "r2011", "r2012", "r2013", "r2014", "r2015", "r2016", "r2017")
resid.ds<- as.data.frame(resid.risk.ds)
resid.rr.avg <- apply(resid.ds,1,mean)

rr.resid.avg = cut(resid.rr.avg, c(0,.75,1,1.25,1.50,1000), label=FALSE, include.lowest=TRUE)
rr.resid.avg.q = cut(resid.rr.avg, quantile(resid.rr.avg, probs=c(0,.2,.4,.6,.8,1)), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined2,rr.resid.08,rr.resid.17,rr.resid.08.v2,rr.resid.17.v2,rr.resid.avg,rr.resid.avg.q)

# scale_fill_manual(values=cols.rr5r, labels = c('[<0.75]', '[0.75, 1.00]', '[1.00, 1.25]', '[1.25, 1.50]', '[>1.50]','No CRC'), limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +
# scale_color_manual(values=cols.rr5r, limits= c("1","2","3","4","5"), na.value="grey", drop=FALSE) +
  
cols.rr5r <- c("#67a9cf","#d1e5f0","#fddbc7","#ef8a62","#b2182b")

pa1 <- ggplot(pa_joined3) +
  geom_sf(aes(fill = as.factor(rr.resid.avg.q)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  geom_sf(data = pa_counties, fill = NA, color = "grey25", size = 0.5) +
  scale_fill_manual(values = cols.rr5r, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols.rr5r, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5-4. Average Relative Risk of CRC Incidence at the Block Group-level\nin Pennsylvania, from 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))


philly <- ggplot(filter(pa_joined3, COUNTY == "101")) +
  geom_sf(aes(fill = as.factor(rr.resid.avg.q)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  geom_sf(data = filter(pa_counties, COUNTYFP == "101"), fill = NA, color = "grey25", size = 1) +
  scale_fill_manual(values = cols.rr5r, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols.rr5r, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "transparent", color = NA),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position="none"
  )
print(philly)

pitt <- ggplot() +
  geom_sf(data = filter(pa_joined3, COUNTY == "003"), aes(fill = as.factor(rr.resid.avg.q)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  geom_sf(data = filter(pa_counties, COUNTYFP == "003"), fill = NA, color = "grey25", size = 1) +
  scale_fill_manual(values = cols.rr5r, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols.rr5r, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "transparent", color = NA),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position="none"
  )
print(pitt)



pa1 <- pa1 + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  ) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )


ggdraw(pa1) +
  draw_plot(
     philly,
    x = 0.525, y = 0.25,
    width = 0.6, height = 0.6) +
  draw_plot(
    pitt,
    x = 0.635, y = 0.65,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.9, y = 0.42,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.93, y = 0.87,
    family = "Times New Roman"
  ) 
ggsave("03_figures/Dep RR w PA Inset - Avg - resid.v2 - nobox.png", height=4, width=6, units="in")


ggsave("03_figures/Dep RR w PA Inset - Avg - resid.v2.png", height=4, width=6, units="in")


################################################################################




#####################################################################################
#####################################################################################
#####################################################################################


colnames(resid.risk.ds) <- c("r2008", "r2009", "r2010", "r2011", "r2012", "r2013", "r2014", "r2015", "r2016", "r2017")
resid.ds<- as.data.frame(resid.risk.ds)
resid.rr.avg <- apply(resid.ds,1,mean)

rr.resid.avg = cut(resid.rr.avg, c(0,.75,1,1.25,1.50,1000), label=FALSE, include.lowest=TRUE)
rr.resid.avg.q = cut(resid.rr.avg, quantile(resid.rr.avg, probs=c(0,.2,.4,.6,.8,1)), label=FALSE, include.lowest=TRUE)

rr.08 <- data.frame(geoid = pa_joined$geoid, year = 2008, rr = resid.risk.ds[,"r2008"])
rr.09 <- data.frame(geoid = pa_joined$geoid, year = 2009, rr = resid.risk.ds[,"r2009"])
rr.10 <- data.frame(geoid = pa_joined$geoid, year = 2010, rr = resid.risk.ds[,"r2010"])
rr.11 <- data.frame(geoid = pa_joined$geoid, year = 2011, rr = resid.risk.ds[,"r2011"])
rr.12 <- data.frame(geoid = pa_joined$geoid, year = 2012, rr = resid.risk.ds[,"r2012"])
rr.13 <- data.frame(geoid = pa_joined$geoid, year = 2013, rr = resid.risk.ds[,"r2013"])
rr.14 <- data.frame(geoid = pa_joined$geoid, year = 2014, rr = resid.risk.ds[,"r2014"])
rr.15 <- data.frame(geoid = pa_joined$geoid, year = 2015, rr = resid.risk.ds[,"r2015"])
rr.16 <- data.frame(geoid = pa_joined$geoid, year = 2016, rr = resid.risk.ds[,"r2016"])
rr.17 <- data.frame(geoid = pa_joined$geoid, year = 2017, rr = resid.risk.ds[,"r2017"])

bg_rr_2008 <- merge(x=cb_2018_42_bg_500k, y=rr.08, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2009 <- merge(x=cb_2018_42_bg_500k, y=rr.09, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2010 <- merge(x=cb_2018_42_bg_500k, y=rr.10, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2011 <- merge(x=cb_2018_42_bg_500k, y=rr.11, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2012 <- merge(x=cb_2018_42_bg_500k, y=rr.12, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2013 <- merge(x=cb_2018_42_bg_500k, y=rr.13, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2014 <- merge(x=cb_2018_42_bg_500k, y=rr.14, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2015 <- merge(x=cb_2018_42_bg_500k, y=rr.15, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2016 <- merge(x=cb_2018_42_bg_500k, y=rr.16, by.x="GEOID", by.y="geoid", all = TRUE)
bg_rr_2017 <- merge(x=cb_2018_42_bg_500k, y=rr.17, by.x="GEOID", by.y="geoid", all = TRUE)

bg_rr_long <- rbind(bg_rr_2008, bg_rr_2009, bg_rr_2010, bg_rr_2011, bg_rr_2012, bg_rr_2013, bg_rr_2014, bg_rr_2015, bg_rr_2016, bg_rr_2017)

bg_rr_long$rr.q <- cut(bg_rr_long$rr, quantile(bg_rr_long$rr, probs=c(0,.2,.4,.6,.8,1), na.rm = TRUE), label=FALSE, include.lowest=TRUE)

bg_rr_long@data$id <- bg_rr_long@data$GEOID
bg_rr_long.points = fortify(bg_rr_long, region="id")
bg_rr_long.df = join(bg_rr_long.points, bg_rr_long@data, by="id")

# bg_rr_long.df$wqs.q.na <- ifelse(bg_rr_long.df$wqs.q==0, NA, bg_rr_long.df$wqs.q)

ggplot(bg_rr_long.df[complete.cases(bg_rr_long.df$year), ]) + 
  aes(long,lat,group=group,color=as.factor(rr.q),fill=as.factor(rr.q)) + 
  geom_polygon() +
  scale_fill_manual(values = cols.rr5r, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  scale_color_manual(values = cols.rr5r, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +
  coord_map(projection="mercator") + 
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  facet_wrap(~year, nrow=2, ncol=5) +
  labs(caption="Figure 1. Annual Relative Risk of CRC Incidence at the Block Group-level in Pennsylvania\nfrom 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0),
    legend.text = element_text(family="Times New Roman"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    strip.text = element_text(family="Times New Roman"),
    strip.background = element_blank()
  )
ggsave("Appendix. Annual RR of CRC Incidence.png", width=9, height=4, units="in")

#####################################################################################
#####################################################################################
#####################################################################################






























print(pa1)




##############################################################################
##############################################################################
##############################################################################

library(rlang)
# Maps by Stage

stage.map <- function(x,year,stage){
pa1 <- ggplot(pa_joined3) +
  geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  scale_fill_manual(values = cols.reds, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
  scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption=paste0("Figure 5.4. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",stage,")")) + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0.5),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )  + 
  expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))

pa1 <- pa1 + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  ) + 
  geom_rect(
    xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
    ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
    xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
    ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
    fill = NA, 
    colour = "black",
    size = 0.6
  )

ggdraw(pa1) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank()) 
    },
    x = 0.655, y = 0.31,
    width = 0.3, height = 0.3) +
  draw_plot(
    {
      pa1 + 
        coord_sf(
          xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(1,3)],
          ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(2,4)],
          datum=NA, expand = FALSE) + 
        theme(legend.position = "none", plot.caption = element_blank())
    },
    x = 0.66, y = 0.643,
    width = 0.3, height = 0.3) +
  geom_text() +
  annotate(
    "text",
    label = "Philadelphia",
    x = 0.805, y = 0.303,
    family = "Times New Roman"
  ) +
  annotate(
    "text",
    label = "Pittsburgh",
    x = 0.808, y = 0.635,
    family = "Times New Roman"
  ) 
ggsave(paste0("03_figures/Dep RR w PA Inset - ",year," - ",stage,".png"), height=4, width=6, units="in")
}

# fitted.relrisk_local   <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_local.rds")
# fitted.relrisk_reg     <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_reg.rds")
# fitted.relrisk_regdist <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_regdist.rds")
# fitted.relrisk_dist    <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_dist.rds")

rr.local.17   <- fitted.relrisk_local[87580:97310]
rr.reg.17     <- fitted.relrisk_reg[87580:97310]
rr.regdist.17 <- fitted.relrisk_regdist[87580:97310]
rr.dist.17    <- fitted.relrisk_dist[87580:97310]

rr.stage.17 <- as.data.frame(cbind(rr.local.17,rr.reg.17,rr.regdist.17,rr.dist.17))

colnames(rr.stage.17) <- c("rr.local.17","rr.reg.17","rr.regdist.17","rr.dist.17")

rr.stage.17 <- rr.stage.17 %>% 
                mutate(rr.local.17.q = cut(rr.local.17, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE),
                       rr.reg.17.q = cut(rr.reg.17, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE),
                       rr.regdist.17.q = cut(rr.regdist.17, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE),
                       rr.dist.17.q = cut(rr.dist.17, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
                       )

pa_joined3 <- cbind(pa_joined, rr.stage.17)
save(pa_joined3, file="01_clean_data/pa_joined3.Rdata")

# quantile(pa_joined2$rr.2017, probs=c(0,.2,.4,.6,.8,1))
# quantile(rr.local.17, probs=c(0,.2,.4,.6,.8,1))
# quantile(rr.reg.17, probs=c(0,.2,.4,.6,.8,1))
# quantile(rr.regdist.17, probs=c(0,.2,.4,.6,.8,1))
# quantile(rr.dist.17, probs=c(0,.2,.4,.6,.8,1))
# 
# # '[1.00 - 1.05]','[1.05 - 1.10]','[1.10 - 1.15]','[1.15 - 1.20]','[1.20+]'
# c(1.00,1.05,1.10,1.15,1.20,1000)


stage.map(rr.local.17.q,"2017","Local")
stage.map(rr.reg.17.q,"2017","Regional")
stage.map(rr.regdist.17.q,"2017","Regional_Distant")
stage.map(rr.dist.17.q,"2017","Distant")

histogrm()


























ggplot(pa_bg_philly) +
  geom_sf(aes(fill = as.factor(rr.q.08)), color = NA) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  scale_fill_manual(values = cols.reds, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
  scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5.1. Map of Pennsylvania Relative Risk of CRC Incidence at the Block Group Level (2008)") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0.5),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )



ggplot(pa_bg_pitt) +
  geom_sf(color = NA, aes(fill = as.factor(relrisk.q))) + # removes boundary lines around polygons
  coord_sf(datum=NA, expand=FALSE) + # sets projection for map
  # coord_sf(crs=3083, datum=NA, expand=FALSE) + 
  scale_fill_manual(values = cols.reds, labels = c('[1.07 - 1.26]','[1.26 - 1.34]','[1.34 - 1.44]','[1.44 - 1.60]','[1.60 - 2.98]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
  scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
  guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5.1. Map of Pennsylvania Relative Risk of CRC Incidence at the Block Group Level, from 2008 to 2017") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0.5),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  )






############################################################################
############################################################################
############################################################################

# Leaflet
library(leaflet)

# fitted.relrisk_dist <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_dist.rds")
risk.2017_dist <- fitted.relrisk_dist[87580:97310]

residuals2017 <- filter(wqs.model.vars.stage, year==2017)
cb_2018_42_bg_500k$geoid <- as.numeric(cb_2018_42_bg_500k$GEOID)
residuals2017.bg <- merge(x=cb_2018_42_bg_500k, y=residuals2017, by.x="GEOID", by.y="geoid", all.x=FALSE)
residuals2017.bg$risk.2017_dist <- risk.2017_dist
residuals2017.bg.ll <- spTransform(residuals2017.bg, CRS("+proj=longlat +datum=WGS84 +no_defs"))

colours <- colorNumeric(palette = "YlOrBr", domain = residuals2017.bg@data$risk.2017_dist, reverse=FALSE)
leaflet(data=residuals2017.bg) %>%
  addTiles() %>%
  addPolygons(fillColor = ~colours(risk.2017_dist),
              color="",
              fillOpacity = 0.7, weight = 1, smoothFactor = 0.5,
              opacity = 1.0) %>%
  addLegend(pal = colours, values = risk.2017_dist,
            opacity = 1, title="Risk") %>%
  addScaleBar(position="bottomleft")




###############################################################################
###############################################################################
###############################################################################
###############################################################################

#### Miscellaneous maps

## Map figure function

rr.map <- function(ds,x,year,description){
  pa1 <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[0% < 20%]','[20% < 40%]','[40% < 60%]','[60% < 80%]','[80% - 100%]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk Quintiles", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )  + 
    expand_limits(x = c(-80.5,-72), y = c(39.7, 42.1))
  
  pa1 <- pa1 + 
    geom_rect(
      xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[1],
      ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[2],
      xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[3],
      ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[4],
      fill = NA, 
      colour = "black",
      size = 0.6
    ) + 
    geom_rect(
      xmin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[1],
      ymin = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[2],
      xmax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[3],
      ymax = st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[4],
      fill = NA, 
      colour = "black",
      size = 0.6
    )
  
  ggdraw(pa1) +
    draw_plot(
      {
        pa1 + 
          coord_sf(
            xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(1,3)],
            ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "101"))[c(2,4)],
            datum=NA, expand = FALSE) + 
          theme(legend.position = "none", plot.caption = element_blank()) 
      },
      x = 0.655, y = 0.31,
      width = 0.3, height = 0.3) +
    draw_plot(
      {
        pa1 + 
          coord_sf(
            xlim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(1,3)],
            ylim = sf::st_bbox(dplyr::filter(pa_joined, COUNTY == "003"))[c(2,4)],
            datum=NA, expand = FALSE) + 
          theme(legend.position = "none", plot.caption = element_blank())
      },
      x = 0.66, y = 0.643,
      width = 0.3, height = 0.3) +
    geom_text() +
    annotate(
      "text",
      label = "Philadelphia",
      x = 0.805, y = 0.303,
      family = "Times New Roman"
    ) +
    annotate(
      "text",
      label = "Pittsburgh",
      x = 0.808, y = 0.635,
      family = "Times New Roman"
    ) 
  ggsave(paste0("03_figures/Dep RR w PA Inset - ",year," - ",description,".png"), height=4, width=6, units="in")
}


###############################################################################
###############################################################################

# Null model

rr.map.null <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.null.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR - null model - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_null <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_null.rds")

rr.08.null <- fitted.relrisk_null[1:9731]
rr.09.null <- fitted.relrisk_null[9732:19462]
rr.10.null <- fitted.relrisk_null[19463:29193]
rr.11.null <- fitted.relrisk_null[29194:38924]
rr.12.null <- fitted.relrisk_null[38925:48655]
rr.13.null <- fitted.relrisk_null[48656:58386]
rr.14.null <- fitted.relrisk_null[58387:68117]
rr.15.null <- fitted.relrisk_null[68118:77848]
rr.16.null <- fitted.relrisk_null[77849:87579]
rr.17.null <- fitted.relrisk_null[87580:97310]

rr.08.null.q <- cut(rr.08.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.null.q <- cut(rr.09.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.null.q <- cut(rr.10.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.null.q <- cut(rr.11.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.null.q <- cut(rr.12.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.null.q <- cut(rr.13.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.null.q <- cut(rr.14.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.null.q <- cut(rr.15.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.null.q <- cut(rr.16.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.null.q <- cut(rr.17.null, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.null <- cbind(rr.08.null, rr.09.null, rr.10.null, rr.11.null, rr.12.null, rr.13.null, rr.14.null, rr.15.null, rr.16.null, rr.17.null)

rr.null.q <- cbind(rr.08.null.q, rr.09.null.q, rr.10.null.q, rr.11.null.q, rr.12.null.q, rr.13.null.q, rr.14.null.q, rr.15.null.q, rr.16.null.q, rr.17.null.q)

rr.null.avg <- rowMeans(rr.null)

rr.null.avg.q <- cut(rr.null.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.null, rr.null.q, rr.null.avg, rr.null.avg.q)

gg.null.08 <- rr.map.null(pa_joined3,rr.08.null.q,2008,"null")
gg.null.09 <- rr.map.null(pa_joined3,rr.09.null.q,2009,"null")
gg.null.10 <- rr.map.null(pa_joined3,rr.10.null.q,2010,"null")
gg.null.11 <- rr.map.null(pa_joined3,rr.11.null.q,2011,"null")
gg.null.12 <- rr.map.null(pa_joined3,rr.12.null.q,2012,"null")
gg.null.13 <- rr.map.null(pa_joined3,rr.13.null.q,2013,"null")
gg.null.14 <- rr.map.null(pa_joined3,rr.14.null.q,2014,"null")
gg.null.15 <- rr.map.null(pa_joined3,rr.15.null.q,2015,"null")
gg.null.16 <- rr.map.null(pa_joined3,rr.16.null.q,2016,"null")
gg.null.17 <- rr.map.null(pa_joined3,rr.17.null.q,2017,"null")

gg.null.avg <- rr.map.null(pa_joined3,rr.null.avg.q,"Avg","null")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Null Model",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.null.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.null.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.null.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.null.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.null.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.null.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.null.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.null.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.null.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.null.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.null.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_null.png", height=9, width = 6, units = "in")




###############################################################################

# Age/Sex null model

rr.map.agesexonly <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.agesexonly.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR - Age/Sex Only - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_agesexonly <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_agesexonly.rds")

rr.08.agesexonly <- fitted.relrisk_agesexonly[1:9731]
rr.09.agesexonly <- fitted.relrisk_agesexonly[9732:19462]
rr.10.agesexonly <- fitted.relrisk_agesexonly[19463:29193]
rr.11.agesexonly <- fitted.relrisk_agesexonly[29194:38924]
rr.12.agesexonly <- fitted.relrisk_agesexonly[38925:48655]
rr.13.agesexonly <- fitted.relrisk_agesexonly[48656:58386]
rr.14.agesexonly <- fitted.relrisk_agesexonly[58387:68117]
rr.15.agesexonly <- fitted.relrisk_agesexonly[68118:77848]
rr.16.agesexonly <- fitted.relrisk_agesexonly[77849:87579]
rr.17.agesexonly <- fitted.relrisk_agesexonly[87580:97310]

rr.08.agesexonly.q <- cut(rr.08.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.agesexonly.q <- cut(rr.09.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.agesexonly.q <- cut(rr.10.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.agesexonly.q <- cut(rr.11.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.agesexonly.q <- cut(rr.12.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.agesexonly.q <- cut(rr.13.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.agesexonly.q <- cut(rr.14.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.agesexonly.q <- cut(rr.15.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.agesexonly.q <- cut(rr.16.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.agesexonly.q <- cut(rr.17.agesexonly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.agesexonly <- cbind(rr.08.agesexonly, rr.09.agesexonly, rr.10.agesexonly, rr.11.agesexonly, rr.12.agesexonly, rr.13.agesexonly, rr.14.agesexonly, rr.15.agesexonly, rr.16.agesexonly, rr.17.agesexonly)

rr.agesexonly.q <- cbind(rr.08.agesexonly.q, rr.09.agesexonly.q, rr.10.agesexonly.q, rr.11.agesexonly.q, rr.12.agesexonly.q, rr.13.agesexonly.q, rr.14.agesexonly.q, rr.15.agesexonly.q, rr.16.agesexonly.q, rr.17.agesexonly.q)

rr.agesexonly.avg <- rowMeans(rr.agesexonly)

rr.agesexonly.avg.q <- cut(rr.agesexonly.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.agesexonly, rr.agesexonly.q, rr.agesexonly.avg, rr.agesexonly.avg.q)

gg.agesexonly.08 <- rr.map.agesexonly(pa_joined3,rr.08.agesexonly.q,2008,"agesexonly")
gg.agesexonly.09 <- rr.map.agesexonly(pa_joined3,rr.09.agesexonly.q,2009,"agesexonly")
gg.agesexonly.10 <- rr.map.agesexonly(pa_joined3,rr.10.agesexonly.q,2010,"agesexonly")
gg.agesexonly.11 <- rr.map.agesexonly(pa_joined3,rr.11.agesexonly.q,2011,"agesexonly")
gg.agesexonly.12 <- rr.map.agesexonly(pa_joined3,rr.12.agesexonly.q,2012,"agesexonly")
gg.agesexonly.13 <- rr.map.agesexonly(pa_joined3,rr.13.agesexonly.q,2013,"agesexonly")
gg.agesexonly.14 <- rr.map.agesexonly(pa_joined3,rr.14.agesexonly.q,2014,"agesexonly")
gg.agesexonly.15 <- rr.map.agesexonly(pa_joined3,rr.15.agesexonly.q,2015,"agesexonly")
gg.agesexonly.16 <- rr.map.agesexonly(pa_joined3,rr.16.agesexonly.q,2016,"agesexonly")
gg.agesexonly.17 <- rr.map.agesexonly(pa_joined3,rr.17.agesexonly.q,2017,"agesexonly")

gg.agesexonly.avg <- rr.map.agesexonly(pa_joined3,rr.agesexonly.avg.q,"Avg","agesexonly")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Age/Sex Only Model",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.agesexonly.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.agesexonly.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.agesexonly.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.agesexonly.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.agesexonly.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.agesexonly.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.agesexonly.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.agesexonly.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.agesexonly.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.agesexonly.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.agesexonly.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_agesexonly.png", height=9, width = 6, units = "in")



###############################################################################

# Philly deprivation only

rr.map.philly <- function(ds,x,year,description){
  gg <- ggplot(ds) +
          geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
          coord_sf(datum=NA, expand=FALSE) + # sets projection for map
          scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
          scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
          guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
          labs(caption=paste0("Figure 5.X. Map of Philadelphia Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
          theme(
            panel.background = element_rect(fill = "white"),
            title = element_text(family="Times New Roman", face="bold"),
            plot.caption.position = "panel",
            plot.caption = element_text(size=11,hjust=0.5),
            legend.text = element_text(family="Times New Roman", hjust = 0.5),
            axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.title.y=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks.y=element_blank(),
            legend.position = "bottom"
          ) 
  assign(paste0("gg.philly.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/Dep RR w PA Inset - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_philly_agesex <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_philly_agesex.rds")

rr.08.philly <- fitted.relrisk_philly_agesex[1:1333]
rr.09.philly <- fitted.relrisk_philly_agesex[1334:2666]
rr.10.philly <- fitted.relrisk_philly_agesex[2667:3999]
rr.11.philly <- fitted.relrisk_philly_agesex[4000:5332]
rr.12.philly <- fitted.relrisk_philly_agesex[5333:6665]
rr.13.philly <- fitted.relrisk_philly_agesex[6666:7998]
rr.14.philly <- fitted.relrisk_philly_agesex[7999:9331]
rr.15.philly <- fitted.relrisk_philly_agesex[9332:10664]
rr.16.philly <- fitted.relrisk_philly_agesex[10665:11997]
rr.17.philly <- fitted.relrisk_philly_agesex[11998:13330]

rr.08.philly.q <- cut(rr.08.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.philly.q <- cut(rr.09.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.philly.q <- cut(rr.10.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.philly.q <- cut(rr.11.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.philly.q <- cut(rr.12.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.philly.q <- cut(rr.13.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.philly.q <- cut(rr.14.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.philly.q <- cut(rr.15.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.philly.q <- cut(rr.16.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.philly.q <- cut(rr.17.philly, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.philly <- cbind(rr.08.philly, rr.09.philly, rr.10.philly, rr.11.philly, rr.12.philly, rr.13.philly, rr.14.philly, rr.15.philly, rr.16.philly, rr.17.philly)

rr.philly.q <- cbind(rr.08.philly.q, rr.09.philly.q, rr.10.philly.q, rr.11.philly.q, rr.12.philly.q, rr.13.philly.q, rr.14.philly.q, rr.15.philly.q, rr.16.philly.q, rr.17.philly.q)

rr.philly.avg <- rowMeans(rr.philly)

rr.philly.avg.q <- cut(rr.philly.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3.philly <- filter(pa_joined3, pa_joined3$COUNTY == "101")

pa_joined3.philly <- cbind(pa_joined3.philly, rr.philly, rr.philly.q, rr.philly.avg, rr.philly.avg.q)

gg.philly.08 <- rr.map.philly(pa_joined3.philly,rr.08.philly.q,2008,"Philly")
gg.philly.09 <- rr.map.philly(pa_joined3.philly,rr.09.philly.q,2009,"Philly")
gg.philly.10 <- rr.map.philly(pa_joined3.philly,rr.10.philly.q,2010,"Philly")
gg.philly.11 <- rr.map.philly(pa_joined3.philly,rr.11.philly.q,2011,"Philly")
gg.philly.12 <- rr.map.philly(pa_joined3.philly,rr.12.philly.q,2012,"Philly")
gg.philly.13 <- rr.map.philly(pa_joined3.philly,rr.13.philly.q,2013,"Philly")
gg.philly.14 <- rr.map.philly(pa_joined3.philly,rr.14.philly.q,2014,"Philly")
gg.philly.15 <- rr.map.philly(pa_joined3.philly,rr.15.philly.q,2015,"Philly")
gg.philly.16 <- rr.map.philly(pa_joined3.philly,rr.16.philly.q,2016,"Philly")
gg.philly.17 <- rr.map.philly(pa_joined3.philly,rr.17.philly.q,2017,"Philly")

gg.philly.avg <- rr.map.philly(pa_joined3.philly,rr.philly.avg.q,"Avg","Philly")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "Philadelphia Relative Risk of CRC Incidence at the Block Group Level by Year",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
          gg.philly.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.philly.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
          gg.philly.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.philly.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
          gg.philly.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.philly.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
          gg.philly.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.philly.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
          gg.philly.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.philly.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
          ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.5, label_y = 0.15
        )

legend <- get_legend(
  gg.philly.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_philly.png", height=9, width = 6, units = "in")





###############################################################################

# Philly age/sex only

rr.map.phillyagesex <- function(ds,x,year,description){
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Philadelphia Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    ) 
  assign(paste0("gg.phillyagesex.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/Dep RR w PA Inset - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_philly_agesexonly <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_philly_agesexonly.rds")

rr.08.phillyagesex <- fitted.relrisk_philly_agesexonly[1:1333]
rr.09.phillyagesex <- fitted.relrisk_philly_agesexonly[1334:2666]
rr.10.phillyagesex <- fitted.relrisk_philly_agesexonly[2667:3999]
rr.11.phillyagesex <- fitted.relrisk_philly_agesexonly[4000:5332]
rr.12.phillyagesex <- fitted.relrisk_philly_agesexonly[5333:6665]
rr.13.phillyagesex <- fitted.relrisk_philly_agesexonly[6666:7998]
rr.14.phillyagesex <- fitted.relrisk_philly_agesexonly[7999:9331]
rr.15.phillyagesex <- fitted.relrisk_philly_agesexonly[9332:10664]
rr.16.phillyagesex <- fitted.relrisk_philly_agesexonly[10665:11997]
rr.17.phillyagesex <- fitted.relrisk_philly_agesexonly[11998:13330]

rr.08.phillyagesex.q <- cut(rr.08.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.phillyagesex.q <- cut(rr.09.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.phillyagesex.q <- cut(rr.10.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.phillyagesex.q <- cut(rr.11.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.phillyagesex.q <- cut(rr.12.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.phillyagesex.q <- cut(rr.13.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.phillyagesex.q <- cut(rr.14.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.phillyagesex.q <- cut(rr.15.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.phillyagesex.q <- cut(rr.16.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.phillyagesex.q <- cut(rr.17.phillyagesex, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.phillyagesex <- cbind(rr.08.phillyagesex, rr.09.phillyagesex, rr.10.phillyagesex, rr.11.phillyagesex, rr.12.phillyagesex, rr.13.phillyagesex, rr.14.phillyagesex, rr.15.phillyagesex, rr.16.phillyagesex, rr.17.phillyagesex)

rr.phillyagesex.q <- cbind(rr.08.phillyagesex.q, rr.09.phillyagesex.q, rr.10.phillyagesex.q, rr.11.phillyagesex.q, rr.12.phillyagesex.q, rr.13.phillyagesex.q, rr.14.phillyagesex.q, rr.15.phillyagesex.q, rr.16.phillyagesex.q, rr.17.phillyagesex.q)

rr.phillyagesex.avg <- rowMeans(rr.phillyagesex)

rr.phillyagesex.avg.q <- cut(rr.phillyagesex.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3.phillyagesex <- filter(pa_joined3, pa_joined3$COUNTY == "101")

pa_joined3.phillyagesex <- cbind(pa_joined3.phillyagesex, rr.phillyagesex, rr.phillyagesex.q, rr.phillyagesex.avg, rr.phillyagesex.avg.q)

gg.phillyagesex.08 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.08.phillyagesex.q,2008,"phillyagesex")
gg.phillyagesex.09 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.09.phillyagesex.q,2009,"phillyagesex")
gg.phillyagesex.10 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.10.phillyagesex.q,2010,"phillyagesex")
gg.phillyagesex.11 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.11.phillyagesex.q,2011,"phillyagesex")
gg.phillyagesex.12 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.12.phillyagesex.q,2012,"phillyagesex")
gg.phillyagesex.13 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.13.phillyagesex.q,2013,"phillyagesex")
gg.phillyagesex.14 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.14.phillyagesex.q,2014,"phillyagesex")
gg.phillyagesex.15 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.15.phillyagesex.q,2015,"phillyagesex")
gg.phillyagesex.16 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.16.phillyagesex.q,2016,"phillyagesex")
gg.phillyagesex.17 <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.17.phillyagesex.q,2017,"phillyagesex")

gg.phillyagesex.avg <- rr.map.phillyagesex(pa_joined3.phillyagesex,rr.phillyagesex.avg.q,"Avg","phillyagesex")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "Philly RR of CRC Incidence at the Block Group Level by Year (Age/Sex Only)",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.phillyagesex.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.phillyagesex.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.phillyagesex.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.phillyagesex.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.phillyagesex.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.phillyagesex.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.phillyagesex.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.phillyagesex.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.phillyagesex.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.phillyagesex.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.5, label_y = 0.15
)

legend <- get_legend(
  gg.phillyagesex.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_phillyagesex.png", height=9, width = 6, units = "in")



###############################################################################

# Margin of error - upper

rr.map.moeupper <- function(ds,x,year,description){

gg <- ggplot(ds) +
        geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
        coord_sf(datum=NA, expand=FALSE) + # sets projection for map
        scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
        scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
        guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
        labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
        theme(
          panel.background = element_rect(fill = "white"),
          title = element_text(family="Times New Roman", face="bold"),
          plot.caption.position = "panel",
          plot.caption = element_text(size=11,hjust=0.5),
          legend.text = element_text(family="Times New Roman", hjust = 0.5),
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          legend.position = "bottom"
        )
  assign(paste0("gg.moeupper.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR MOE - Upper - ",year," - ",description,".png"), height=4, width=6, units="in")
}

# fitted.relrisk_moeupper <- exp(readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_moeupper.rds"))

rr.08.moeupper <- fitted.relrisk_moeupper[1:9731]
rr.09.moeupper <- fitted.relrisk_moeupper[9732:19462]
rr.10.moeupper <- fitted.relrisk_moeupper[19463:29193]
rr.11.moeupper <- fitted.relrisk_moeupper[29194:38924]
rr.12.moeupper <- fitted.relrisk_moeupper[38925:48655]
rr.13.moeupper <- fitted.relrisk_moeupper[48656:58386]
rr.14.moeupper <- fitted.relrisk_moeupper[58387:68117]
rr.15.moeupper <- fitted.relrisk_moeupper[68118:77848]
rr.16.moeupper <- fitted.relrisk_moeupper[77849:87579]
rr.17.moeupper <- fitted.relrisk_moeupper[87580:97310]

rr.08.moeupper.q <- cut(rr.08.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.moeupper.q <- cut(rr.09.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.moeupper.q <- cut(rr.10.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.moeupper.q <- cut(rr.11.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.moeupper.q <- cut(rr.12.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.moeupper.q <- cut(rr.13.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.moeupper.q <- cut(rr.14.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.moeupper.q <- cut(rr.15.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.moeupper.q <- cut(rr.16.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.moeupper.q <- cut(rr.17.moeupper, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.moeupper <- cbind(rr.08.moeupper, rr.09.moeupper, rr.10.moeupper, rr.11.moeupper, rr.12.moeupper, rr.13.moeupper, rr.14.moeupper, rr.15.moeupper, rr.16.moeupper, rr.17.moeupper)

rr.moeupper.q <- cbind(rr.08.moeupper.q, rr.09.moeupper.q, rr.10.moeupper.q, rr.11.moeupper.q, rr.12.moeupper.q, rr.13.moeupper.q, rr.14.moeupper.q, rr.15.moeupper.q, rr.16.moeupper.q, rr.17.moeupper.q)

rr.moeupper.avg <- rowMeans(rr.moeupper)

rr.moeupper.avg.q <- cut(rr.moeupper.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.moeupper, rr.moeupper.q, rr.moeupper.avg, rr.moeupper.avg.q)

gg.moeupper.08 <- rr.map.moeupper(pa_joined3,rr.08.moeupper.q,2008,"moeupper")
gg.moeupper.09 <- rr.map.moeupper(pa_joined3,rr.09.moeupper.q,2009,"moeupper")
gg.moeupper.10 <- rr.map.moeupper(pa_joined3,rr.10.moeupper.q,2010,"moeupper")
gg.moeupper.11 <- rr.map.moeupper(pa_joined3,rr.11.moeupper.q,2011,"moeupper")
gg.moeupper.12 <- rr.map.moeupper(pa_joined3,rr.12.moeupper.q,2012,"moeupper")
gg.moeupper.13 <- rr.map.moeupper(pa_joined3,rr.13.moeupper.q,2013,"moeupper")
gg.moeupper.14 <- rr.map.moeupper(pa_joined3,rr.14.moeupper.q,2014,"moeupper")
gg.moeupper.15 <- rr.map.moeupper(pa_joined3,rr.15.moeupper.q,2015,"moeupper")
gg.moeupper.16 <- rr.map.moeupper(pa_joined3,rr.16.moeupper.q,2016,"moeupper")
gg.moeupper.17 <- rr.map.moeupper(pa_joined3,rr.17.moeupper.q,2017,"moeupper")

gg.moeupper.avg <- rr.map.moeupper(pa_joined3,rr.moeupper.avg.q,"Avg","moeupper")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - MOE - Upper",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.moeupper.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moeupper.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moeupper.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moeupper.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moeupper.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moeupper.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moeupper.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moeupper.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moeupper.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moeupper.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

# legend <- get_legend(
#   gg.moeupper.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
# )

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_moeupper.png", height=9, width = 6, units = "in")



###############################################################################

# Margin of error - lower

rr.map.moelower <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.moelower.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR MOE - lower - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_moelower <- exp(readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_moelower.rds"))

rr.08.moelower <- fitted.relrisk_moelower[1:9731]
rr.09.moelower <- fitted.relrisk_moelower[9732:19462]
rr.10.moelower <- fitted.relrisk_moelower[19463:29193]
rr.11.moelower <- fitted.relrisk_moelower[29194:38924]
rr.12.moelower <- fitted.relrisk_moelower[38925:48655]
rr.13.moelower <- fitted.relrisk_moelower[48656:58386]
rr.14.moelower <- fitted.relrisk_moelower[58387:68117]
rr.15.moelower <- fitted.relrisk_moelower[68118:77848]
rr.16.moelower <- fitted.relrisk_moelower[77849:87579]
rr.17.moelower <- fitted.relrisk_moelower[87580:97310]

rr.08.moelower.q <- cut(rr.08.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.moelower.q <- cut(rr.09.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.moelower.q <- cut(rr.10.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.moelower.q <- cut(rr.11.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.moelower.q <- cut(rr.12.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.moelower.q <- cut(rr.13.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.moelower.q <- cut(rr.14.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.moelower.q <- cut(rr.15.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.moelower.q <- cut(rr.16.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.moelower.q <- cut(rr.17.moelower, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.moelower <- cbind(rr.08.moelower, rr.09.moelower, rr.10.moelower, rr.11.moelower, rr.12.moelower, rr.13.moelower, rr.14.moelower, rr.15.moelower, rr.16.moelower, rr.17.moelower)

rr.moelower.q <- cbind(rr.08.moelower.q, rr.09.moelower.q, rr.10.moelower.q, rr.11.moelower.q, rr.12.moelower.q, rr.13.moelower.q, rr.14.moelower.q, rr.15.moelower.q, rr.16.moelower.q, rr.17.moelower.q)

rr.moelower.avg <- rowMeans(rr.moelower)

rr.moelower.avg.q <- cut(rr.moelower.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.moelower, rr.moelower.q, rr.moelower.avg, rr.moelower.avg.q)

gg.moelower.08 <- rr.map.moelower(pa_joined3,rr.08.moelower.q,2008,"moelower")
gg.moelower.09 <- rr.map.moelower(pa_joined3,rr.09.moelower.q,2009,"moelower")
gg.moelower.10 <- rr.map.moelower(pa_joined3,rr.10.moelower.q,2010,"moelower")
gg.moelower.11 <- rr.map.moelower(pa_joined3,rr.11.moelower.q,2011,"moelower")
gg.moelower.12 <- rr.map.moelower(pa_joined3,rr.12.moelower.q,2012,"moelower")
gg.moelower.13 <- rr.map.moelower(pa_joined3,rr.13.moelower.q,2013,"moelower")
gg.moelower.14 <- rr.map.moelower(pa_joined3,rr.14.moelower.q,2014,"moelower")
gg.moelower.15 <- rr.map.moelower(pa_joined3,rr.15.moelower.q,2015,"moelower")
gg.moelower.16 <- rr.map.moelower(pa_joined3,rr.16.moelower.q,2016,"moelower")
gg.moelower.17 <- rr.map.moelower(pa_joined3,rr.17.moelower.q,2017,"moelower")

gg.moelower.avg <- rr.map.moelower(pa_joined3,rr.moelower.avg.q,"Avg","moelower")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - MOE - lower",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.moelower.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moelower.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moelower.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moelower.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moelower.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moelower.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moelower.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moelower.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.moelower.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.moelower.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.moelower.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_moelower.png", height=9, width = 6, units = "in")



###############################################################################

# Predicted Values from WQS GLM Model

rr.map.wqspred <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.05 - 1.20]','[1.20 - 1.35]','[1.35 - 1.50]','[1.50 - 1.75]','[1.75+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.wqspred.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR WQS Pred - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_wqspred <- exp(readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_wqspred.rds"))

rr.08.wqspred <- fitted.relrisk_wqspred[1:9731]
rr.09.wqspred <- fitted.relrisk_wqspred[9732:19462]
rr.10.wqspred <- fitted.relrisk_wqspred[19463:29193]
rr.11.wqspred <- fitted.relrisk_wqspred[29194:38924]
rr.12.wqspred <- fitted.relrisk_wqspred[38925:48655]
rr.13.wqspred <- fitted.relrisk_wqspred[48656:58386]
rr.14.wqspred <- fitted.relrisk_wqspred[58387:68117]
rr.15.wqspred <- fitted.relrisk_wqspred[68118:77848]
rr.16.wqspred <- fitted.relrisk_wqspred[77849:87579]
rr.17.wqspred <- fitted.relrisk_wqspred[87580:97310]

rr.08.wqspred.q <- cut(rr.08.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.09.wqspred.q <- cut(rr.09.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.10.wqspred.q <- cut(rr.10.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.11.wqspred.q <- cut(rr.11.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.12.wqspred.q <- cut(rr.12.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.13.wqspred.q <- cut(rr.13.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.14.wqspred.q <- cut(rr.14.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.15.wqspred.q <- cut(rr.15.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.16.wqspred.q <- cut(rr.16.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)
rr.17.wqspred.q <- cut(rr.17.wqspred, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

rr.wqspred <- cbind(rr.08.wqspred, rr.09.wqspred, rr.10.wqspred, rr.11.wqspred, rr.12.wqspred, rr.13.wqspred, rr.14.wqspred, rr.15.wqspred, rr.16.wqspred, rr.17.wqspred)

rr.wqspred.q <- cbind(rr.08.wqspred.q, rr.09.wqspred.q, rr.10.wqspred.q, rr.11.wqspred.q, rr.12.wqspred.q, rr.13.wqspred.q, rr.14.wqspred.q, rr.15.wqspred.q, rr.16.wqspred.q, rr.17.wqspred.q)

rr.wqspred.avg <- rowMeans(rr.wqspred)

rr.wqspred.avg.q <- cut(rr.wqspred.avg, c(1.05,1.20,1.35,1.50,1.75,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.wqspred, rr.wqspred.q, rr.wqspred.avg, rr.wqspred.avg.q)

gg.wqspred.08 <- rr.map.wqspred(pa_joined3,rr.08.wqspred.q,2008,"wqspred")
gg.wqspred.09 <- rr.map.wqspred(pa_joined3,rr.09.wqspred.q,2009,"wqspred")
gg.wqspred.10 <- rr.map.wqspred(pa_joined3,rr.10.wqspred.q,2010,"wqspred")
gg.wqspred.11 <- rr.map.wqspred(pa_joined3,rr.11.wqspred.q,2011,"wqspred")
gg.wqspred.12 <- rr.map.wqspred(pa_joined3,rr.12.wqspred.q,2012,"wqspred")
gg.wqspred.13 <- rr.map.wqspred(pa_joined3,rr.13.wqspred.q,2013,"wqspred")
gg.wqspred.14 <- rr.map.wqspred(pa_joined3,rr.14.wqspred.q,2014,"wqspred")
gg.wqspred.15 <- rr.map.wqspred(pa_joined3,rr.15.wqspred.q,2015,"wqspred")
gg.wqspred.16 <- rr.map.wqspred(pa_joined3,rr.16.wqspred.q,2016,"wqspred")
gg.wqspred.17 <- rr.map.wqspred(pa_joined3,rr.17.wqspred.q,2017,"wqspred")

gg.wqspred.avg <- rr.map.wqspred(pa_joined3,rr.wqspred.avg.q,"Avg","wqspred")

## Plot Grid

title <- ggdraw() + 
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - WQS Pred",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.wqspred.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.wqspred.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.wqspred.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.wqspred.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.wqspred.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.wqspred.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.wqspred.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.wqspred.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.wqspred.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.wqspred.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.wqspred.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_wqspred.png", height=9, width = 6, units = "in")




###############################################################################

# local stage

rr.map.local <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.00 - 1.05]','[1.05- 1.10]','[1.10 - 1.15]','[1.15 - 1.20]','[1.20+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.local.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR Stage - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_local <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_local.rds")

rr.08.local <- fitted.relrisk_local[1:9731]
rr.09.local <- fitted.relrisk_local[9732:19462]
rr.10.local <- fitted.relrisk_local[19463:29193]
rr.11.local <- fitted.relrisk_local[29194:38924]
rr.12.local <- fitted.relrisk_local[38925:48655]
rr.13.local <- fitted.relrisk_local[48656:58386]
rr.14.local <- fitted.relrisk_local[58387:68117]
rr.15.local <- fitted.relrisk_local[68118:77848]
rr.16.local <- fitted.relrisk_local[77849:87579]
rr.17.local <- fitted.relrisk_local[87580:97310]

rr.08.local.q <- cut(rr.08.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.09.local.q <- cut(rr.09.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.10.local.q <- cut(rr.10.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.11.local.q <- cut(rr.11.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.12.local.q <- cut(rr.12.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.13.local.q <- cut(rr.13.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.14.local.q <- cut(rr.14.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.15.local.q <- cut(rr.15.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.16.local.q <- cut(rr.16.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.17.local.q <- cut(rr.17.local, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

rr.local <- cbind(rr.08.local, rr.09.local, rr.10.local, rr.11.local, rr.12.local, rr.13.local, rr.14.local, rr.15.local, rr.16.local, rr.17.local)

rr.local.q <- cbind(rr.08.local.q, rr.09.local.q, rr.10.local.q, rr.11.local.q, rr.12.local.q, rr.13.local.q, rr.14.local.q, rr.15.local.q, rr.16.local.q, rr.17.local.q)

rr.local.avg <- rowMeans(rr.local)

rr.local.avg.q <- cut(rr.local.avg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.local, rr.local.q, rr.local.avg, rr.local.avg.q)

gg.local.08 <- rr.map.local(pa_joined3,rr.08.local.q,2008,"local")
gg.local.09 <- rr.map.local(pa_joined3,rr.09.local.q,2009,"local")
gg.local.10 <- rr.map.local(pa_joined3,rr.10.local.q,2010,"local")
gg.local.11 <- rr.map.local(pa_joined3,rr.11.local.q,2011,"local")
gg.local.12 <- rr.map.local(pa_joined3,rr.12.local.q,2012,"local")
gg.local.13 <- rr.map.local(pa_joined3,rr.13.local.q,2013,"local")
gg.local.14 <- rr.map.local(pa_joined3,rr.14.local.q,2014,"local")
gg.local.15 <- rr.map.local(pa_joined3,rr.15.local.q,2015,"local")
gg.local.16 <- rr.map.local(pa_joined3,rr.16.local.q,2016,"local")
gg.local.17 <- rr.map.local(pa_joined3,rr.17.local.q,2017,"local")

gg.local.avg <- rr.map.local(pa_joined3,rr.local.avg.q,"Avg","local")

## Plot Grid

title <- ggdraw() +
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Local",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.local.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.local.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.local.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.local.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.local.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.local.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.local.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.local.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.local.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.local.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.local.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_local.png", height=9, width = 6, units = "in")




###############################################################################

# Regional

rr.map.reg <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.00 - 1.05]','[1.05- 1.10]','[1.10 - 1.15]','[1.15 - 1.20]','[1.20+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.reg.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR Stage - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_reg <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_reg.rds")

rr.08.reg <- fitted.relrisk_reg[1:9731]
rr.09.reg <- fitted.relrisk_reg[9732:19462]
rr.10.reg <- fitted.relrisk_reg[19463:29193]
rr.11.reg <- fitted.relrisk_reg[29194:38924]
rr.12.reg <- fitted.relrisk_reg[38925:48655]
rr.13.reg <- fitted.relrisk_reg[48656:58386]
rr.14.reg <- fitted.relrisk_reg[58387:68117]
rr.15.reg <- fitted.relrisk_reg[68118:77848]
rr.16.reg <- fitted.relrisk_reg[77849:87579]
rr.17.reg <- fitted.relrisk_reg[87580:97310]

rr.08.reg.q <- cut(rr.08.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.09.reg.q <- cut(rr.09.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.10.reg.q <- cut(rr.10.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.11.reg.q <- cut(rr.11.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.12.reg.q <- cut(rr.12.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.13.reg.q <- cut(rr.13.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.14.reg.q <- cut(rr.14.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.15.reg.q <- cut(rr.15.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.16.reg.q <- cut(rr.16.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.17.reg.q <- cut(rr.17.reg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

rr.reg <- cbind(rr.08.reg, rr.09.reg, rr.10.reg, rr.11.reg, rr.12.reg, rr.13.reg, rr.14.reg, rr.15.reg, rr.16.reg, rr.17.reg)

rr.reg.q <- cbind(rr.08.reg.q, rr.09.reg.q, rr.10.reg.q, rr.11.reg.q, rr.12.reg.q, rr.13.reg.q, rr.14.reg.q, rr.15.reg.q, rr.16.reg.q, rr.17.reg.q)

rr.reg.avg <- rowMeans(rr.reg)

rr.reg.avg.q <- cut(rr.reg.avg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.reg, rr.reg.q, rr.reg.avg, rr.reg.avg.q)

gg.reg.08 <- rr.map.reg(pa_joined3,rr.08.reg.q,2008,"reg")
gg.reg.09 <- rr.map.reg(pa_joined3,rr.09.reg.q,2009,"reg")
gg.reg.10 <- rr.map.reg(pa_joined3,rr.10.reg.q,2010,"reg")
gg.reg.11 <- rr.map.reg(pa_joined3,rr.11.reg.q,2011,"reg")
gg.reg.12 <- rr.map.reg(pa_joined3,rr.12.reg.q,2012,"reg")
gg.reg.13 <- rr.map.reg(pa_joined3,rr.13.reg.q,2013,"reg")
gg.reg.14 <- rr.map.reg(pa_joined3,rr.14.reg.q,2014,"reg")
gg.reg.15 <- rr.map.reg(pa_joined3,rr.15.reg.q,2015,"reg")
gg.reg.16 <- rr.map.reg(pa_joined3,rr.16.reg.q,2016,"reg")
gg.reg.17 <- rr.map.reg(pa_joined3,rr.17.reg.q,2017,"reg")

gg.reg.avg <- rr.map.reg(pa_joined3,rr.reg.avg.q,"Avg","reg")

## Plot Grid

title <- ggdraw() +
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Regional",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.reg.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.reg.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.reg.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.reg.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.reg.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.reg.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.reg.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.reg.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.reg.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.reg.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.reg.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_reg.png", height=9, width = 6, units = "in")




###############################################################################

# Distant

rr.map.dist <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.reds, labels = c('[1.00 - 1.05]','[1.05- 1.10]','[1.10 - 1.15]','[1.15 - 1.20]','[1.20+]'), limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.reds, limits= c("1","2","3","4","5"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Map of Pennsylvania Relative Risk of\nCRC Incidence at the Block Group Level (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.dist.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR Stage - ",year," - ",description,".png"), height=4, width=6, units="in")
}

fitted.relrisk_dist <- readRDS("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/fitted.relrisk_dist.rds")

rr.08.dist <- fitted.relrisk_dist[1:9731]
rr.09.dist <- fitted.relrisk_dist[9732:19462]
rr.10.dist <- fitted.relrisk_dist[19463:29193]
rr.11.dist <- fitted.relrisk_dist[29194:38924]
rr.12.dist <- fitted.relrisk_dist[38925:48655]
rr.13.dist <- fitted.relrisk_dist[48656:58386]
rr.14.dist <- fitted.relrisk_dist[58387:68117]
rr.15.dist <- fitted.relrisk_dist[68118:77848]
rr.16.dist <- fitted.relrisk_dist[77849:87579]
rr.17.dist <- fitted.relrisk_dist[87580:97310]

rr.08.dist.q <- cut(rr.08.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.09.dist.q <- cut(rr.09.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.10.dist.q <- cut(rr.10.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.11.dist.q <- cut(rr.11.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.12.dist.q <- cut(rr.12.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.13.dist.q <- cut(rr.13.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.14.dist.q <- cut(rr.14.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.15.dist.q <- cut(rr.15.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.16.dist.q <- cut(rr.16.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)
rr.17.dist.q <- cut(rr.17.dist, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

rr.dist <- cbind(rr.08.dist, rr.09.dist, rr.10.dist, rr.11.dist, rr.12.dist, rr.13.dist, rr.14.dist, rr.15.dist, rr.16.dist, rr.17.dist)

rr.dist.q <- cbind(rr.08.dist.q, rr.09.dist.q, rr.10.dist.q, rr.11.dist.q, rr.12.dist.q, rr.13.dist.q, rr.14.dist.q, rr.15.dist.q, rr.16.dist.q, rr.17.dist.q)

rr.dist.avg <- rowMeans(rr.dist)

rr.dist.avg.q <- cut(rr.dist.avg, c(1.00,1.05,1.10,1.15,1.20,1000), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.dist, rr.dist.q, rr.dist.avg, rr.dist.avg.q)

gg.dist.08 <- rr.map.dist(pa_joined3,rr.08.dist.q,2008,"dist")
gg.dist.09 <- rr.map.dist(pa_joined3,rr.09.dist.q,2009,"dist")
gg.dist.10 <- rr.map.dist(pa_joined3,rr.10.dist.q,2010,"dist")
gg.dist.11 <- rr.map.dist(pa_joined3,rr.11.dist.q,2011,"dist")
gg.dist.12 <- rr.map.dist(pa_joined3,rr.12.dist.q,2012,"dist")
gg.dist.13 <- rr.map.dist(pa_joined3,rr.13.dist.q,2013,"dist")
gg.dist.14 <- rr.map.dist(pa_joined3,rr.14.dist.q,2014,"dist")
gg.dist.15 <- rr.map.dist(pa_joined3,rr.15.dist.q,2015,"dist")
gg.dist.16 <- rr.map.dist(pa_joined3,rr.16.dist.q,2016,"dist")
gg.dist.17 <- rr.map.dist(pa_joined3,rr.17.dist.q,2017,"dist")

gg.dist.avg <- rr.map.dist(pa_joined3,rr.dist.avg.q,"Avg","dist")

## Plot Grid

title <- ggdraw() +
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Distant",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.dist.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.dist.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.dist.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.dist.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.dist.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.dist.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.dist.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.dist.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.dist.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.dist.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.dist.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_dist.png", height=9, width = 6, units = "in")




###############################################################################

# local vs distant state RR delta

stage.delta <- fitted.relrisk_dist - fitted.relrisk_local

# summary((stage.delta-mean(stage.delta))/sd(stage.delta))

stagedelta.std <- (stage.delta-mean(stage.delta))/sd(stage.delta)

rr.08.stagedelta <- stagedelta.std[1:9731]
rr.09.stagedelta <- stagedelta.std[9732:19462]
rr.10.stagedelta <- stagedelta.std[19463:29193]
rr.11.stagedelta <- stagedelta.std[29194:38924]
rr.12.stagedelta <- stagedelta.std[38925:48655]
rr.13.stagedelta <- stagedelta.std[48656:58386]
rr.14.stagedelta <- stagedelta.std[58387:68117]
rr.15.stagedelta <- stagedelta.std[68118:77848]
rr.16.stagedelta <- stagedelta.std[77849:87579]
rr.17.stagedelta <- stagedelta.std[87580:97310]

rr.08.stagedelta.q <- cut(rr.08.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.09.stagedelta.q <- cut(rr.09.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.10.stagedelta.q <- cut(rr.10.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.11.stagedelta.q <- cut(rr.11.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.12.stagedelta.q <- cut(rr.12.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.13.stagedelta.q <- cut(rr.13.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.14.stagedelta.q <- cut(rr.14.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.15.stagedelta.q <- cut(rr.15.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.16.stagedelta.q <- cut(rr.16.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
rr.17.stagedelta.q <- cut(rr.17.stagedelta, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)

cols.blue.red <- c("#0571b0","#92c5de","#f4a582","#ca0020")

rr.map.stagedelta <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.blue.red, labels = c('[0% - 25%]','[25% - 50%]','[50% - 75%]','[75% - 100%]'), limits= c("1","2","3","4"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.blue.red, limits= c("1","2","3","4"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk Quartiles", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Pennsylvania Standardized RR Delta (Dist - Local) (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.stagedelta.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/PA Dep RR Stage Delta - ",year," - ",description,".png"), height=4, width=6, units="in")
}

rr.stagedelta <- cbind(rr.08.stagedelta, rr.09.stagedelta, rr.10.stagedelta, rr.11.stagedelta, rr.12.stagedelta, rr.13.stagedelta, rr.14.stagedelta, rr.15.stagedelta, rr.16.stagedelta, rr.17.stagedelta)

rr.stagedelta.q <- cbind(rr.08.stagedelta.q, rr.09.stagedelta.q, rr.10.stagedelta.q, rr.11.stagedelta.q, rr.12.stagedelta.q, rr.13.stagedelta.q, rr.14.stagedelta.q, rr.15.stagedelta.q, rr.16.stagedelta.q, rr.17.stagedelta.q)

rr.stagedelta.avg <- rowMeans(rr.stagedelta)

rr.stagedelta.avg.q <- cut(rr.stagedelta.avg, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)

pa_joined3 <- cbind(pa_joined3, rr.stagedelta, rr.stagedelta.q, rr.stagedelta.avg, rr.stagedelta.avg.q)

gg.stagedelta.08 <- rr.map.stagedelta(pa_joined3,rr.08.stagedelta.q,2008,"stagedelta")
gg.stagedelta.09 <- rr.map.stagedelta(pa_joined3,rr.09.stagedelta.q,2009,"stagedelta")
gg.stagedelta.10 <- rr.map.stagedelta(pa_joined3,rr.10.stagedelta.q,2010,"stagedelta")
gg.stagedelta.11 <- rr.map.stagedelta(pa_joined3,rr.11.stagedelta.q,2011,"stagedelta")
gg.stagedelta.12 <- rr.map.stagedelta(pa_joined3,rr.12.stagedelta.q,2012,"stagedelta")
gg.stagedelta.13 <- rr.map.stagedelta(pa_joined3,rr.13.stagedelta.q,2013,"stagedelta")
gg.stagedelta.14 <- rr.map.stagedelta(pa_joined3,rr.14.stagedelta.q,2014,"stagedelta")
gg.stagedelta.15 <- rr.map.stagedelta(pa_joined3,rr.15.stagedelta.q,2015,"stagedelta")
gg.stagedelta.16 <- rr.map.stagedelta(pa_joined3,rr.16.stagedelta.q,2016,"stagedelta")
gg.stagedelta.17 <- rr.map.stagedelta(pa_joined3,rr.17.stagedelta.q,2017,"stagedelta")

gg.stagedelta.avg <- rr.map.stagedelta(pa_joined3,rr.stagedelta.avg.q,"Avg","stagedelta")

## Plot Grid

title <- ggdraw() +
  draw_label(
    "PA RR of CRC Incidence at the Block Group Level by Year - Delta RR (Dist - Local)",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.stagedelta.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.stagedelta.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.stagedelta.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.stagedelta.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.stagedelta.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.stagedelta.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.stagedelta.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.stagedelta.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  gg.stagedelta.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")), gg.stagedelta.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(.25, 0, .25, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.4, label_y = 1
)

legend <- get_legend(
  gg.stagedelta.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_stagedelta.png", height=9, width = 6, units = "in")

###############################################################################

# local vs distant RR delta - Philly only

rr.map.stagedelta.philly <- function(ds,x,year,description){
  
  gg <- ggplot(ds) +
    geom_sf(aes(fill = as.factor({{x}})), color = NA) + # removes boundary lines around polygons
    coord_sf(datum=NA, expand=FALSE) + # sets projection for map
    scale_fill_manual(values = cols.blue.red, labels = c('[0% - 25%]','[25% - 50%]','[50% - 75%]','[75% - 100%]'), limits= c("1","2","3","4"), drop=FALSE, na.value = "white") + 
    scale_color_manual(values = cols.blue.red, limits= c("1","2","3","4"), drop=FALSE, na.value = "white") +   
    guides(fill=guide_legend(title="Relative Risk Quartiles", title.position = "bottom", title.hjust = 0.5), color="none") +
    labs(caption=paste0("Figure 5.X. Philadelphia Standardized RR Delta (Dist - Local) (",year," - ",description,")")) + 
    theme(
      panel.background = element_rect(fill = "white"),
      title = element_text(family="Times New Roman", face="bold"),
      plot.caption.position = "panel",
      plot.caption = element_text(size=11,hjust=0.5),
      legend.text = element_text(family="Times New Roman", hjust = 0.5),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.position = "bottom"
    )
  assign(paste0("gg.stagedelta.philly.",year), gg, envir = globalenv())
  ggsave(paste0("03_figures/Philly Dep RR Stage Delta - ",year," - ",description,".png"), height=4, width=6, units="in")
}

pa_joined3.stagedelta.philly <- filter(pa_joined3, COUNTY=="101")

gg.stagedelta.philly.08 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.08.stagedelta.q,2008,"stagedelta")
gg.stagedelta.philly.09 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.09.stagedelta.q,2009,"stagedelta")
gg.stagedelta.philly.10 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.10.stagedelta.q,2010,"stagedelta")
gg.stagedelta.philly.11 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.11.stagedelta.q,2011,"stagedelta")
gg.stagedelta.philly.12 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.12.stagedelta.q,2012,"stagedelta")
gg.stagedelta.philly.13 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.13.stagedelta.q,2013,"stagedelta")
gg.stagedelta.philly.14 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.14.stagedelta.q,2014,"stagedelta")
gg.stagedelta.philly.15 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.15.stagedelta.q,2015,"stagedelta")
gg.stagedelta.philly.16 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.16.stagedelta.q,2016,"stagedelta")
gg.stagedelta.philly.17 <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.17.stagedelta.q,2017,"stagedelta")

gg.stagedelta.philly.avg <- rr.map.stagedelta.philly(pa_joined3.stagedelta.philly,rr.stagedelta.avg.q,"Avg","stagedelta")

## Plot Grid

title <- ggdraw() +
  draw_label(
    "Philly RR of CRC Incidence at the Block Group Level by Year - Delta RR (Dist - Local)",
    fontfamily = "Times New Roman",
    size = 12
  ) + theme(plot.margin = margin(0, 0, 0, 0))

grid <- plot_grid(
  gg.stagedelta.philly.2008 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.stagedelta.philly.2009 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.stagedelta.philly.2010 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.stagedelta.philly.2011 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.stagedelta.philly.2012 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.stagedelta.philly.2013 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.stagedelta.philly.2014 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.stagedelta.philly.2015 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  gg.stagedelta.philly.2016 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")), gg.stagedelta.philly.2017 + theme(legend.position="none", plot.caption=element_blank(), plot.margin = unit(c(0, 0, 0, 0), "cm")),
  ncol=2, nrow=5, labels = c("2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"), label_size = 11, label_fontfamily = "Times New Roman", label_x = 0.5, label_y = 0.15
)

legend <- get_legend(
  gg.stagedelta.philly.2008 + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plot_grid(
  title,
  grid,
  legend,
  ncol=1,
  rel_heights = c(1,15,1),
  rel_widths = c(1,1,1)
) + theme(plot.background = element_rect(fill="white", color = "white"))

ggsave("03_figures/gg_grid_stagedelta.philly.png", height=9, width = 6, units = "in")



###############################################################################

# local vs distant RR delta - Philly only [ANIMATED]

library(gganimate)
library(transformr)

# load("~/Documents/PhD (Temple)/Dissertation/Writing/Chapter 5. Aim 2 - Area-level Deprivation/Ch5_RProject/01_clean_data/crc_sorted9.Rdata")

geoid.year <- dplyr::select(crc_sorted8, geoid, year)

geoid.year.stagedelta <- cbind(geoid.year,stagedelta.std)

colnames(geoid.year.stagedelta) <- c("geoid","year","rr.d")

bg.rate.long.df.stagedelta.philly <- filter(merge(x=bg_rate_long.df, y=geoid.year.stagedelta, by.x=c("GEOID","year"), by.y=c("geoid","year"), all.x=TRUE),COUNTYFP=="101")

bg.rate.long.df.stagedelta.philly$rr.d.q <- cut(bg.rate.long.df.stagedelta.philly$rr.d, c(-5.9151,-0.5840,0,0.7732,1.7294), label=FALSE, include.lowest=TRUE)
                                            
ggplot(bg.rate.long.df.stagedelta.philly) +
  aes(long,lat,group=group, color = as.factor(rr.d.q), fill = as.factor(rr.d.q)) +
  geom_polygon() +
  scale_fill_manual(values = cols.blue.red, labels = c('[0% - 25%]','[25% - 50%]','[50% - 75%]','[75% - 100%]'), limits= c("1","2","3","4"), drop=FALSE, na.value = "white") + 
  scale_color_manual(values = cols.blue.red, limits= c("1","2","3","4"), drop=FALSE, na.value = "white") +   
  guides(fill=guide_legend(title="Relative Risk Quartiles", title.position = "bottom", title.hjust = 0.5), color="none") +
  labs(caption="Figure 5.X. Philadelphia Standardized RR Delta (Dist - Local)") + 
  theme(
    panel.background = element_rect(fill = "white"),
    title = element_text(family="Times New Roman", face="bold"),
    plot.caption.position = "panel",
    plot.caption = element_text(size=11,hjust=0.5),
    legend.text = element_text(family="Times New Roman", hjust = 0.5),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank(),
    legend.position = "bottom"
  ) +
  transition_states(year, state_length = 1)






### RR + 1 SD of WQS

1.33*(mean(Aim2.fig.ds$wqs)+sd(Aim2.fig.ds$wqs))






