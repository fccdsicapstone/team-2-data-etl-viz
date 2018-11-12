-- Join fcc_all_year_latest with geo data
CREATE OR REPLACE TABLE broadband.fcc_allyear_blocklevel_with_geo_agg AS(
select file_year,
       c.block_code as block_code, 
       n_of_hoco,
       n_of_service_providers,
       avg_down_spd,
       avg_up_spd,
       urban_rural, urban_type, total_length,    land_area, water_area,latitude,    longitude, elevation_mean, elevation_std, elevation_range,
       c.state_county_code as state_county_code, 
       SUBSTR(c.block_code,1,12) block_group_code,
       state,
       county,
       CASE
           WHEN n_of_hoco IS NULL THEN 0
           ELSE 1
       END AS has_service,
       n_of_techs,
       n_of_tech10_servs,
       n_of_tech11_servs,
       n_of_tech12_servs,
       n_of_tech20_servs,
       n_of_tech30_servs,
       n_of_tech40_servs,
       n_of_tech41_servs,
       n_of_tech42_servs,
       n_of_tech43_servs,
       n_of_tech50_servs,
       n_of_tech70_servs,
       n_of_tech90_servs
from
(select file_year, block_code, block_group_code, count(distinct hoco_final) as n_of_hoco, 
  count(distinct tech_code) as n_of_techs,
  SUM(CASE WHEN tech_code = 10 THEN 1 ELSE 0 END) AS n_of_tech10_servs,
  SUM(CASE WHEN tech_code = 11 THEN 1 ELSE 0 END) AS n_of_tech11_servs,
  SUM(CASE WHEN tech_code = 12 THEN 1 ELSE 0 END) AS n_of_tech12_servs,
  SUM(CASE WHEN tech_code = 20 THEN 1 ELSE 0 END) AS n_of_tech20_servs,
  SUM(CASE WHEN tech_code = 30 THEN 1 ELSE 0 END) AS n_of_tech30_servs,
  SUM(CASE WHEN tech_code = 40 THEN 1 ELSE 0 END) AS n_of_tech40_servs,
  SUM(CASE WHEN tech_code = 41 THEN 1 ELSE 0 END) AS n_of_tech41_servs,
  SUM(CASE WHEN tech_code = 42 THEN 1 ELSE 0 END) AS n_of_tech42_servs,
  SUM(CASE WHEN tech_code = 43 THEN 1 ELSE 0 END) AS n_of_tech43_servs,
  SUM(CASE WHEN tech_code = 50 THEN 1 ELSE 0 END) AS n_of_tech50_servs,
  SUM(CASE WHEN tech_code = 70 THEN 1 ELSE 0 END) AS n_of_tech70_servs,
  SUM(CASE WHEN tech_code = 90 THEN 1 ELSE 0 END) AS n_of_tech90_servs,
  count(*) as n_of_service_providers, AVG(max_down) as avg_down_spd, AVG(max_up) as avg_up_spd, MAX(max_up) as max_up_spd, MAX(max_down) as max_down_spd
from `fccdsicapstone-218522.broadband.fcc_allyear_latest` 
group by file_year, block_code, block_group_code) as a
FULL OUTER JOIN `fccdsicapstone-218522.broadband.census_block` c on a.block_code = c.block_code)
