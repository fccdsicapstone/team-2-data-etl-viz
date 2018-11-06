CREATE OR REPLACE TABLE broadband.fcc_tech_speed_2017 AS(
       SELECT t.tech_code, tc.tech_name, max(max_down_median) AS max_down_median, max(max_up_median) AS max_up_median
       FROM
                (SELECT tech_code, PERCENTILE_CONT(max_down, 0.5) OVER (PARTITION BY tech_code) max_down_median, PERCENTILE_CONT(max_up, 0.5) OVER (PARTITION BY tech_code) AS max_up_median
                FROM `fccdsicapstone-218522.broadband.fcc2017_latest`) t
                LEFT JOIN `fccdsicapstone-218522.broadband.tech_code` tc ON t.tech_code = tc.tech_code
       GROUP BY t.tech_code, tc.tech_name
       ORDER BY t.tech_code)
