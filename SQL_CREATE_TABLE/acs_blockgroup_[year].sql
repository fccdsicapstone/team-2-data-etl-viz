-- Create a table of acs_blockgroup_[year].csv 
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

CREATE OR REPLACE TABLE broadband.acs_blockgroup_2014 AS (
       SELECT FORMAT("%s", CONCAT(LPAD(state, 2, "0"), LPAD(county, 3, "0"), LPAD(tract, 6, "0"), block_group)) AS block_group_code, * EXCEPT(state, county, tract, block_group)
        FROM broadband.acs_blockgroup_2014)

CREATE OR REPLACE TABLE broadband.acs_blockgroup_2014 AS(
       SELECT DISTINCT *
       FROM broadband.acs_blockgroup_2014
)
