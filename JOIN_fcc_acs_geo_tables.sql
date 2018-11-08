CREATE OR REPLACE TABLE broadband.fcc_acs_with_geo_2014 AS(
SELECT file_year, 
       fcc.block_group_code,
       state_county_code, 
       state,county,
       AVG(n_of_hoco) AS avg_n_of_hoco,
       COUNT(DISTINCT block_code) AS n_of_blocks, 
       SUM(n_of_service_providers) AS n_of_service_providers,
       AVG(avg_down_spd) AS avg_down_spd,
       AVG(avg_up_spd) AS avg_up_spd,
       SUM(CASE WHEN urban_rural='U' THEN 1 ELSE 0 END)/COUNT(DISTINCT block_code) AS perc_urban,
       SUM(CASE WHEN urban_rural='U' THEN 1 ELSE 0 END) AS n_of_urban_blk,
       SUM(CASE WHEN urban_type='U' THEN 1 ELSE 0 END) AS n_of_U_urban_blk,
       SUM(CASE WHEN urban_type='C' THEN 1 ELSE 0 END) AS n_of_C_urban_blk,
       SUM(total_length) as total_length,
       SUM(land_area) as land_area,
       SUM(water_area) as water_area,
       AVG(elevation_mean) as elevation_mean,
       bg3.population, bg.* EXCEPT(block_group_code), bg2.* EXCEPT(block_group_code)
FROM broadband.fcc_allyear_blocklevel_with_geo_agg fcc
       INNER JOIN broadband.acs_blockgroup_2014 bg ON fcc.block_group_code = bg.block_group_code
       INNER JOIN broadband.acs_blockgroup2_2014 bg2 ON fcc.block_group_code = bg2.block_group_code
       INNER JOIN broadband.acs_blockgroup_pop_2014 bg3 ON fcc.block_group_code = bg3.block_group_code
WHERE fcc.file_year = 2014     
GROUP BY file_year, fcc.block_group_code, state_county_code,state,county, race_total,white,black_or_african_american,american_indian_and_alaska_native,asian,native_hawaiian_and_other_pacific_islander,some_other_race_alone,two_or_more_races,ethnicity_total,not_hispanic_or_latino,hispanic_or_latino,school_total,enrolled_in_college__undergraduate_years,graduate_or_professional_school,not_enrolled_in_school,educational_attainment_total,regular_high_school_diploma,ged_or_alternative_credential,associate_s_degree,bachelor_s_degree,master_s_degree,professional_school_degree,doctorate_degree,median_household_income_in_the_past_12_months,total_in_labor_force__civilian_labor_force,civilian_labor_force_employed,civilian_labor_force_unemployed,tenure_total,owner_occupied,renter_occupied,total_sex_by_age,male_15_to_17,male_18_to_19,male_20,male_21,male_22_to_24,male_25_to_29,male_30_to_34,male_35_to_39,female_15_to_17,female_18_to_19,female_20,female_21,female_22_to_24,female_25_to_29,female_30_to_34,female_35_to_39,median_home_value,health_insurance_total,uninsured_under_18,uninsured_18_to_34,uninsured_35_to_64,uninsured_65_or_older, bg3.population)
