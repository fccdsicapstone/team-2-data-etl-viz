CREATE OR REPLACE TABLE broadband.fcc_acs_with_geo_2014 AS(
SELECT a.*,
       AVG(n_of_hoco) AS avg_n_of_hoco,
       AVG(n_of_service_providers) AS avg_n_of_service_providers,
       AVG(avg_down_spd) AS avg_down_spd,
       AVG(avg_up_spd) AS avg_up_spd,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN has_service=1 THEN 0 ELSE 1 END)
       END AS n_blk_no_service,
       CASE
           WHEN COUNT(DISTINCT block_code)=0 THEN NULL
           ELSE SUM(CASE WHEN has_service=1 THEN 0 ELSE 1 END)/COUNT(DISTINCT block_code)
       END AS perc_blk_no_service,
       AVG(n_of_techs) AS avg_n_of_techs,
       AVG(n_of_tech10_servs) AS avg_n_of_tech10_servs,
       AVG(n_of_tech11_servs) AS avg_n_of_tech11_servs,
       AVG(n_of_tech12_servs) AS avg_n_of_tech12_servs,
       AVG(n_of_tech20_servs) AS avg_n_of_tech20_servs,
       AVG(n_of_tech30_servs) AS avg_n_of_tech30_servs,
       AVG(n_of_tech40_servs) AS avg_n_of_tech40_servs,
       AVG(n_of_tech41_servs) AS avg_n_of_tech41_servs,
       AVG(n_of_tech42_servs) AS avg_n_of_tech42_servs,
       AVG(n_of_tech43_servs) AS avg_n_of_tech43_servs,
       AVG(n_of_tech50_servs) AS avg_n_of_tech50_servs,
       AVG(n_of_tech70_servs) AS avg_n_of_tech70_servs,
       AVG(n_of_tech90_servs) AS avg_n_of_tech90_servs
FROM broadband.acs_with_geo_2014 a
     LEFT JOIN broadband.fcc_allyear_blocklevel_with_geo_agg_2014 f ON a.block_group_code = f.block_group_code
GROUP BY a.block_group_code,state_county_code,state,county,n_of_blocks,perc_urban,n_of_urban_blk,n_of_U_urban_blk,n_of_C_urban_blk,total_length,land_area,water_area,elevation_mean,race_total,white,black_or_african_american,american_indian_and_alaska_native,asian,native_hawaiian_and_other_pacific_islander,some_other_race_alone,two_or_more_races,ethnicity_total,not_hispanic_or_latino,hispanic_or_latino,school_total,enrolled_in_college__undergraduate_years,graduate_or_professional_school,not_enrolled_in_school,educational_attainment_total,regular_high_school_diploma,ged_or_alternative_credential,associate_s_degree,bachelor_s_degree,master_s_degree,professional_school_degree,doctorate_degree,median_household_income_in_the_past_12_months,total_in_labor_force__civilian_labor_force,civilian_labor_force_employed,civilian_labor_force_unemployed,tenure_total,owner_occupied,renter_occupied,total_sex_by_age,male_15_to_17,male_18_to_19,male_20,male_21,male_22_to_24,male_25_to_29,male_30_to_34,male_35_to_39,female_15_to_17,female_18_to_19,female_20,female_21,female_22_to_24,female_25_to_29,female_30_to_34,female_35_to_39,median_home_value,health_insurance_total,uninsured_under_18,uninsured_18_to_34,uninsured_35_to_64,uninsured_65_or_older,population)
