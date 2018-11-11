-- Create a table of acs_blockgroup2_[year].csv
CREATE OR REPLACE TABLE broadband.acs_blockgroup2_2014(
       total_sex_by_age INT64,
       male_15_to_17 INT64,
       male_18_to_19 INT64,
       male_20 INT64,
       male_21 INT64,
       male_22_to_24 INT64,
       male_25_to_29 INT64,
       male_30_to_34 INT64,
       male_35_to_39 INT64,
       female_15_to_17 INT64,
       female_18_to_19 INT64,
       female_20 INT64,
       female_21 INT64,
       female_22_to_24 INT64,
       female_25_to_29 INT64,
       female_30_to_34 INT64,
       female_35_to_39 INT64,
       median_home_value INT64,
       health_insurance_total INT64,
       uninsured_under_18 INT64,
       uninsured_18_to_34 INT64,
       uninsured_35_to_64 INT64,
       uninsured_65_or_older INT64,
       state STRING,
       county STRING,
       tract STRING,
       block_group STRING)
