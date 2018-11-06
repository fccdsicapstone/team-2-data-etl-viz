-- Create a table of acs_blockgroup.csv without first column being ROW
CREATE OR REPLACE TABLE broadband.acs_blockgroup_2014(
       race_total INT64,
       white INT64,
       black_or_african_american INT64,
       american_indian_and_alaska_native INT64,
       asian INT64,
       native_hawaiian_and_other_pacific_islander INT64,
       some_other_race_alone INT64,
       two_or_more_races INT64,
       ethnicity_total INT64,
       not_hispanic_or_latino INT64,
       hispanic_or_latino INT64,
       school_total INT64,
       enrolled_in_college__undergraduate_years INT64,
       graduate_or_professional_school INT64,
       not_enrolled_in_school INT64,
       educational_attainment_total INT64,
       regular_high_school_diploma INT64,
       ged_or_alternative_credential INT64,
       associate_s_degree INT64,
       bachelor_s_degree INT64,
       master_s_degree INT64,
       professional_school_degree INT64,
       doctorate_degree INT64,
       median_household_income_in_the_past_12_months NUMERIC,
       total_in_labor_force__civilian_labor_force INT64,
       civilian_labor_force_employed INT64,
       civilian_labor_force_unemployed INT64,
       tenure_total INT64,
       owner_occupied INT64,
       renter_occupied INT64,
       state STRING,
       county STRING,
       tract STRING,
       block_group STRING)


-- Create a table of acs_blockgroup.csv with first column being ROW
CREATE OR REPLACE TABLE broadband.acs_blockgroup_2015(
       row INT64,
       race_total INT64,
       white INT64,
       black_or_african_american INT64,
       american_indian_and_alaska_native INT64,
       asian INT64,
       native_hawaiian_and_other_pacific_islander INT64,
       some_other_race_alone INT64,
       two_or_more_races INT64,
       ethnicity_total INT64,
       not_hispanic_or_latino INT64,
       hispanic_or_latino INT64,
       school_total INT64,
       enrolled_in_college__undergraduate_years INT64,
       graduate_or_professional_school INT64,
       not_enrolled_in_school INT64,
       educational_attainment_total INT64,
       regular_high_school_diploma INT64,
       ged_or_alternative_credential INT64,
       associate_s_degree INT64,
       bachelor_s_degree INT64,
       master_s_degree INT64,
       professional_school_degree INT64,
       doctorate_degree INT64,
       median_household_income_in_the_past_12_months NUMERIC,
       total_in_labor_force__civilian_labor_force INT64,
       civilian_labor_force_employed INT64,
       civilian_labor_force_unemployed INT64,
       tenure_total INT64,
       owner_occupied INT64,
       renter_occupied INT64,
       state STRING,
       county STRING,
       tract STRING,
       block_group STRING)


-- CREATE a table of acs_blockgroup2.csv
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











