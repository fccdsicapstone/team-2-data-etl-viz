CREATE OR REPLACE TABLE broadband.acs_blockgroup_2015 AS (
       SELECT FORMAT("%s", CONCAT(LPAD(state, 2, "0"), LPAD(county, 3, "0"), LPAD(tract, 6, "0"), block_group)) AS block_group_code, * EXCEPT(row, state, county, tract, block_group)
        FROM broadband.acs_blockgroup_2015)

CREATE OR REPLACE TABLE broadband.acs_blockgroup_2014 AS (
       SELECT FORMAT("%s", CONCAT(LPAD(state, 2, "0"), LPAD(county, 3, "0"), LPAD(tract, 6, "0"), block_group)) AS block_group_code, * EXCEPT(state, county, tract, block_group)
        FROM broadband.acs_blockgroup_2014)

CREATE OR REPLACE TABLE broadband.acs_blockgroup2_2014 AS (
       SELECT FORMAT("%s", CONCAT(LPAD(state, 2, "0"), LPAD(county, 3, "0"), LPAD(tract, 6, "0"), block_group)) AS block_group_code, * EXCEPT(state, county, tract, block_group)
        FROM broadband.acs_blockgroup2_2014)
