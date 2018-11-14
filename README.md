# Team 2 ETL, Exploratory Analysis and Visualization
Data ETL, Exploratory Analysis and Visualization of Team 2

# BigQuery Data Description

Table Name | Description
-----------|------------
fcc_tech_speed_[year] | Yearly median max download and upload speed by tech categories
fcc_tech_speed_blockgroup_[year] | Yearly median and mean max download and upload speed by tech categories at blockgroup level
acs_blockgroup_[year] | Yearly five-year-average ACS data at blockgroup level on race, education, median household income and employment
acs_blockgroup2_[year] | Yearly five-year-average ACS data at blockgroup level on sex and age (15-39), median home value and health insurance (uninsured)
acs_blockgroup_pop_[year] | Yearly five-year-average ACS data at blockgroup level on population
acs_blockgroup_comb_[year] | Yearly combined table of the three ACS tables above
fcc_acs_with_geo_[year] | Yearly combined FCC, ACS and GEO data for blockgroups that are presented in ACS data (p.s. There are some blockgroup that appear in ACS but not in GEO, and vice versa)
fcc_acs_with_geo_and_props_[year] | Similary to the one above, but with most of ACS data in propotions instead of counts (e.g. propotions of each race, propotions of education levels (See Davis' [data dictionary here](./fcc_acs_with_geo_and_props_\[year\]_summary.org))
census_block | TIGER Geographical data
