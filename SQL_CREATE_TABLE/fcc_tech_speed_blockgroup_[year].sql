CREATE OR REPLACE TABLE broadband.fcc_tech_speed_blockgroup_2014 AS(
       SELECT median.*, mean.max_down_avg, mean.max_up_avg
       FROM
       (SELECT t.block_group_code, t.tech_code, tc.tech_name, max(max_down_median) AS max_down_median, max(max_up_median) AS max_up_median
       FROM
                (SELECT block_group_code, tech_code, PERCENTILE_CONT(max_down, 0.5) OVER (PARTITION BY  block_group_code, tech_code) max_down_median, PERCENTILE_CONT(max_up, 0.5) OVER (PARTITION BY block_group_code, tech_code) AS max_up_median
                FROM `fccdsicapstone-218522.broadband.fcc2014_latest`) t
                LEFT JOIN `fccdsicapstone-218522.broadband.tech_code` tc ON t.tech_code = tc.tech_code
       GROUP BY t.block_group_code, t.tech_code, tc.tech_name
       ORDER BY t.block_group_code, t.tech_code) median
       INNER JOIN
       (SELECT block_group_code, tech_code, AVG(max_down) max_down_avg, AVG(max_up) max_up_avg
        FROM `fccdsicapstone-218522.broadband.fcc2014_latest`
        GROUP BY block_group_code, tech_code) mean
        ON median.block_group_code = mean.block_group_code AND median.tech_code = mean.tech_code
       ORDER BY median.block_group_code, mean.tech_code)
