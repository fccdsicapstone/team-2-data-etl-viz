-- Create table of acs_population_[year].csv
CREATE OR REPLACE TABLE broadband.acs_blockgroup_pop_2014(
       population INT64,
       state STRING,
       county STRING,
       tract STRING,
       block_group STRING)
