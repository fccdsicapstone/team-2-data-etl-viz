library(tidyverse)
library(lme4)
library(plm)

##Read in the data from pulling it from the pyton script
full_2014_data <- read_csv("full_2014_data.csv") %>% select(-X1) %>% mutate(file_year = 2014) %>% mutate(avg_down_spd = coalesce(avg_down_spd, 0))
full_2015_data <- read_csv("full_2015_data.csv")%>% select(-X1) %>% mutate(file_year = 2015) %>% mutate(avg_down_spd = coalesce(avg_down_spd, 0))
full_2016_data <- read_csv("full_2016_data.csv")%>% select(-X1) %>% mutate(file_year = 2016) %>% mutate(avg_down_spd = coalesce(avg_down_spd, 0))

#Just rbind all of it
all_data <- rbind(full_2014_data, full_2015_data, full_2016_data)

#ACS data has -666666666 for missing values. Replace it with NA. 
all_data <- all_data %>% mutate(median_home_value = ifelse(median_home_value == -666666666, NA, median_home_value), 
                                median_household_income_in_the_past_12_months = ifelse(median_household_income_in_the_past_12_months == -666666666, 
                                                                                       NA, median_household_income_in_the_past_12_months))
#This is all commented out. If you want to replace NA with the best available aggreagation of the 
#value at the census tract or county level. 
# all_data <- all_data %>% mutate(tract_number = substr(as.character(block_group_code), 1, 11))
# 
# 
# df_census_tract <- all_data  %>% group_by(tract_number, file_year
# ) %>% summarize(census_tract_median_home_value = median(median_home_value, na.rm = T), 
#                 census_tract_median_household_income_in_the_past_12_months = median(median_household_income_in_the_past_12_months, na.rm = T)
# ) %>% select(tract_number, file_year, census_tract_median_home_value, census_tract_median_household_income_in_the_past_12_months)
# 
# df_county <- all_data  %>% group_by(state_county_code, file_year
# ) %>% summarize(county_median_home_value = median(median_home_value, na.rm = T), 
#                 county_median_household_income_in_the_past_12_months = median(median_household_income_in_the_past_12_months, na.rm = T) 
# ) %>% select(state_county_code, file_year, county_median_home_value, county_median_household_income_in_the_past_12_months)
# 
# all_data <- all_data %>% left_join(df_census_tract
# ) %>% left_join(df_county
# ) %>% mutate(median_home_value = coalesce(as.integer(median_home_value), as.integer(census_tract_median_home_value), as.integer(county_median_home_value)), 
#              median_household_income_in_the_past_12_months = coalesce(as.integer(median_household_income_in_the_past_12_months), as.integer(census_tract_median_household_income_in_the_past_12_months), 
#                                                                       as.integer(county_median_household_income_in_the_past_12_months)))

#Split up all the data gain
full_2016_data <- all_data %>% filter(file_year == 2016)
full_2015_data <- all_data %>% filter(file_year == 2015)
full_2014_data <- all_data %>% filter(file_year == 2014)

#Making a pooled version, just so we can get summary statistics on changes between 2014-2016
service_2016 <- full_2016_data %>% select(block_group_code, avg_down_spd, perc_blk_no_service, 
                                          median_household_income_in_the_past_12_months, median_home_value, 
                                          unemployment_rate, prop_uninsured, prop_all_22_to_24
) %>% rename(avg_down_spd_2016 = avg_down_spd, perc_blk_no_service_2016 = perc_blk_no_service, 
             median_income_2016 = median_household_income_in_the_past_12_months, 
             median_home_value_2016 = median_home_value, 
             unemployment_rate_2016 = unemployment_rate,
             prop_uninsured_2016 = prop_uninsured,
             prop_all_22_to_24_2016 = prop_all_22_to_24
)

service_2015 <- full_2015_data %>% select(block_group_code, avg_down_spd, perc_blk_no_service, 
                                          median_household_income_in_the_past_12_months, median_home_value,
                                          unemployment_rate, prop_uninsured, prop_all_22_to_24
) %>% rename(avg_down_spd_2015 = avg_down_spd, perc_blk_no_service_2015 = perc_blk_no_service, 
             median_income_2015 = median_household_income_in_the_past_12_months, 
             median_home_value_2015 = median_home_value, 
             unemployment_rate_2015 = unemployment_rate,
             prop_uninsured_2015 = prop_uninsured,
             prop_all_22_to_24_2015 = prop_all_22_to_24
)

service_2014 <- full_2014_data %>% select(block_group_code, avg_down_spd, perc_blk_no_service, 
                                          median_household_income_in_the_past_12_months, median_home_value, 
                                          unemployment_rate, prop_uninsured, prop_all_22_to_24
) %>% rename(avg_down_spd_2014 = avg_down_spd, perc_blk_no_service_2014 = perc_blk_no_service, 
             median_income_2014 = median_household_income_in_the_past_12_months, 
             median_home_value_2014 = median_home_value, 
             unemployment_rate_2014 = unemployment_rate,
             prop_uninsured_2014 = prop_uninsured,
             prop_all_22_to_24_2014 = prop_all_22_to_24)

all_service <- left_join(left_join(service_2016, service_2015), service_2014)

all_service <- all_service %>% mutate(speed_delta_1415 = avg_down_spd_2015 - avg_down_spd_2014, 
                                      speed_delta_1516 = avg_down_spd_2016 - avg_down_spd_2015, 
                                      speed_delta_1416 = avg_down_spd_2016 - avg_down_spd_2014, 
                                      perc_no_serv_delta_1415 = perc_blk_no_service_2015 - perc_blk_no_service_2014, 
                                      perc_no_serv_delta_1516 = perc_blk_no_service_2016 - perc_blk_no_service_2015, 
                                      perc_no_serv_delta_1416 = perc_blk_no_service_2016 - perc_blk_no_service_2014, 
                                      median_income_delta = median_income_2016 - median_income_2014, 
                                      median_home_value_delta1416 = median_home_value_2016 - median_home_value_2014, 
                                      median_home_value_delta1415 = median_home_value_2015/median_home_value_2014,
                                      median_home_value_delta1516 = median_home_value_2016/median_home_value_2015,
                                      uninsured_delta = prop_uninsured_2016 - prop_uninsured_2014, 
                                      unemployment_delta = unemployment_rate_2016- unemployment_rate_2014, 
                                      young_delta = prop_all_22_to_24_2016- prop_all_22_to_24_2014)

#List of block groups that are either rural or urban
rural_blockgroups <- all_data %>% group_by(block_group_code) %>% summarise(rural = ifelse(mean(perc_urban, na.rm= T) <= .2, 1, 0)
) %>% filter(rural == 1) %>% distinct(block_group_code)

urban_blockgroups <- all_data %>% group_by(block_group_code) %>% summarise(urban = ifelse(mean(perc_urban, na.rm= T) >= .8, 1, 0)
) %>% filter(urban == 1) %>% distinct(block_group_code)

#Rural and Urban Pooled
rural_pooled <- all_service %>% filter(block_group_code %in% rural_blockgroups$block_group_code) 
urban_pooled <- all_service %>% filter(block_group_code %in% urban_blockgroups$block_group_code) 

#Rural and Urban not pooled
rural_service <- all_data %>% filter(block_group_code %in% rural_blockgroups$block_group_code) %>% mutate(over_10mbps = ifelse(avg_down_spd >= 10, 1, 0))
urban_service <- all_data %>% filter(block_group_code %in% urban_blockgroups$block_group_code) %>% mutate(over_10mbps = ifelse(avg_down_spd >= 10, 1, 0))

#Linear Models
lm_form_income <- log(median_household_income_in_the_past_12_months) ~ over_10mbps + perc_urban + elevation_mean + 
  road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
  factor(file_year)

lm_form_home_value <- log(median_home_value) ~ over_10mbps + perc_urban + elevation_mean + 
  road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
  factor(file_year) + log(median_household_income_in_the_past_12_months)

lm_form_income_fbr <- log(median_household_income_in_the_past_12_months) ~ perc_tech50_avail + perc_urban + elevation_mean + 
  road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
  factor(file_year)

lm_form_home_value_fbr <- log(median_home_value) ~ perc_tech50_avail + perc_urban + elevation_mean + 
  road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
  factor(file_year) + log(median_household_income_in_the_past_12_months)

#Linear Rural
linear_income <- lm(lm_form_income, data = rural_service)
summary(linear_income)

linear_home_value <- lm(lm_form_home_value, data = rural_service)
summary(linear_home_value)

#Linear Urban
linear_income_fbr_urban <- lm(lm_form_income_fbr, data = urban_service)
summary(linear_income_fbr_urban)

linear_home_value_fbr_urban <- lm(lm_form_home_value_fbr, data = urban_service)
summary(linear_home_value_fbr_urban)

#Fixed Effects Rural
fe_income <- plm::plm(formula =  lm_form_income, data = rural_service, effect = "twoways", model = "within", index = c("block_group_code", "file_year"))
summary(fe_income)

fe_home_value <- plm::plm(formula =  lm_form_home_value, data = rural_service, effect = "twoways", model = "within", index = c("block_group_code", "file_year"))
summary(fe_home_value)

#Fixed Effects Urban
fe_income_fbr_urban <- plm::plm(formula =  lm_form_income_fbr, data = urban_service, effect = "twoways", model = "within", index = c("block_group_code", "file_year"))
summary(fe_income_fbr_urban)

fe_home_value_fbr_urban <- plm::plm(formula =  lm_form_home_value_fbr, data = urban_service, effect = "twoways", model = "within", index = c("block_group_code", "file_year"))
summary(fe_home_value_fbr_urban)

#Mixed Effects Rural
mixed_home_value = lmer(log(median_home_value) ~ over_10mbps + perc_urban + elevation_mean + 
                          road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                          log(median_household_income_in_the_past_12_months) + (file_year|block_group_code) + factor(file_year), data=rural_service)

mixed_home_value.null = lmer(log(median_home_value) ~ perc_urban + elevation_mean + 
                               road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                               log(median_household_income_in_the_past_12_months) + (file_year|block_group_code) + factor(file_year), data=rural_service)

anova(mixed_home_value.null,mixed_home_value)

mixed_income = lmer(log(median_household_income_in_the_past_12_months) ~ over_10mbps + perc_urban + elevation_mean + 
                      road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                      + (file_year|block_group_code) + factor(file_year), data=rural_service)

mixed_income.null = lmer(log(median_household_income_in_the_past_12_months) ~ perc_urban + elevation_mean + 
                           road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                           + (file_year|block_group_code) + factor(file_year), data=rural_service)

anova(mixed_income.null,mixed_income)

#Mixed Effects Urban
mixed_home_value_fbr_urban = lmer(log(median_home_value) ~ perc_tech50_avail + perc_urban + elevation_mean + 
                                    road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                                    log(median_household_income_in_the_past_12_months) + (log(median_household_income_in_the_past_12_months)|block_group_code)  + (file_year|block_group_code) + factor(file_year), data=urban_service)

mixed_home_value.null_fbr_ruban = lmer(log(median_home_value) ~ perc_urban + elevation_mean + 
                                         road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                                         log(median_household_income_in_the_past_12_months) + (file_year|block_group_code) + factor(file_year), data=urban_service)

anova(mixed_home_value.null_fbr_ruban,mixed_home_value_fbr_urban)

mixed_income_fbr_urban = lmer(log(median_household_income_in_the_past_12_months) ~ perc_tech50_avail + perc_urban + elevation_mean + 
                                road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                                + (file_year|block_group_code) + factor(file_year) + log(median_home_value), data=urban_service)

mixed_income.null_fbr_urban = lmer(log(median_household_income_in_the_past_12_months) ~ perc_urban + elevation_mean + 
                                     road_density +prop_white + prop_black+  prop_hisp + prop_educ_min_hs + prop_educ_college_educ  + unemployment_rate + prop_home_owners + population_density + 
                                     + (file_year|block_group_code) + factor(file_year), data=urban_service)

anova(mixed_income.null_fbr_urban,mixed_income_fbr_urban)

#Mixed Effects Urban


