# Team 2 ETL, Exploratory Analysis and Visualization
Data ETL, Exploratory Analysis and Visualization of Team 2

# BigQuery Data Description

Table Name | Description
-----------|------------
acs_blockgroup_[year] | Yearly five-year-average ACS data at blockgroup level on race, education, median household income and employment
acs_blockgroup2_[year] | Yearly five-year-average ACS data at blockgroup level on sex and age (15-39), median home value and health insurance (uninsured)
acs_blockgroup_pop_[year] | Yearly five-year-average ACS data at blockgroup level on population
acs_blockgroup_comb_[year] | Yearly combined table of the three ACS tables above
acs_with_geo_[year] | Yearly ACS and GEO data for blockgoups that are in ACS data
census_block | TIGER data (GEO data)
fcc[year]_latest | Yearly cleaned up FCC data
fcc_allyear_blocklevel_with_geo_agg_[year] | Yearly FCC and GEO data for blocks that are in the GEO data
**fcc_acs_with_geo_[year]** | Yearly combined FCC, ACS and GEO data for blockgroups that are in ACS data (p.s. There are some blockgroup that appear in ACS but not in GEO, and vice versa)
**fcc_acs_with_geo_and_props_[year]** | Similary to the one above, but with most of ACS data in propotions instead of counts (e.g. propotions of each race, propotions of education levels (See Davis' [data dictionary here](./fcc_acs_with_geo_and_props_\[year\]_summary.org))
**fcc_tech_speed_[year]** | Yearly median max download and upload speed by tech categories
**fcc_tech_speed_blockgroup_[year]** | Yearly median and mean max download and upload speed by tech categories at blockgroup level
fund | Cleaned up version of funding data
tech_code | Tech code and its name

# Analysis and Modeling Scripts

The main [data modeling script](./DataModelingScript.R) can be accessed here.

Python and SQL scripts for analysis can be found in each directory of in this repo.

