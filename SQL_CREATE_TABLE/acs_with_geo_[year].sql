CREATE OR REPLACE TABLE broadband.acs_with_geo_2014 AS(
SELECT block_group_code,
       state_county_code,
       state,
       county,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE COUNT(DISTINCT block_code)
       END AS n_of_blocks,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN urban_rural='U' THEN 1 ELSE 0 END)/COUNT(DISTINCT block_code)
       END AS perc_urban,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN urban_rural='U' THEN 1 ELSE 0 END)
       END AS n_of_urban_blk,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN urban_type='U' THEN 1 ELSE 0 END)
       END AS n_of_U_urban_blk,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN urban_type='C' THEN 1 ELSE 0 END)
       END AS n_of_C_urban_blk,
       SUM(total_length) as total_length,
       SUM(land_area) as land_area,
       SUM(water_area) as water_area,
       AVG(elevation_mean) as elevation_mean,
       a.* EXCEPT(block_group_code)
FROM broadband.acs_blockgroup_comb_2014 a
     LEFT JOIN broadband.census_block c ON a.block_group_code = SUBSTR(c.block_code, 1, 12)
GROUP BY block_group_code,state_county_code,state,county, race_total,white,black_or_african_american,american_indian_and_alaska_native,asian,native_hawaiian_and_other_pacific_islander,some_other_race_alone,two_or_more_races,ethnicity_total,not_hispanic_or_latino,hispanic_or_latino,school_total,enrolled_in_college__undergraduate_years,graduate_or_professional_school,not_enrolled_in_school,educational_attainment_total,regular_high_school_diploma,ged_or_alternative_credential,associate_s_degree,bachelor_s_degree,master_s_degree,professional_school_degree,doctorate_degree,median_household_income_in_the_past_12_months,total_in_labor_force__civilian_labor_force,civilian_labor_force_employed,civilian_labor_force_unemployed,tenure_total,owner_occupied,renter_occupied,total_sex_by_age,male_15_to_17,male_18_to_19,male_20,male_21,male_22_to_24,male_25_to_29,male_30_to_34,male_35_to_39,female_15_to_17,female_18_to_19,female_20,female_21,female_22_to_24,female_25_to_29,female_30_to_34,female_35_to_39,median_home_value,health_insurance_total,uninsured_under_18,uninsured_18_to_34,uninsured_35_to_64,uninsured_65_or_older,population)
