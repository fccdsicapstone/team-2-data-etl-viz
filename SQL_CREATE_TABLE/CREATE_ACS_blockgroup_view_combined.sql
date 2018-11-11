-- This works well if there is no duplicates in the block_group_code column
-- Unfortunatly, there are duplicates. This will make more duplicates, since it's a inner join.

CREATE OR REPLACE VIEW broadband.acs_blockgroup_combined AS(
       SELECT a.block_group_code, '2014' AS year, * EXCEPT (block_group_code)
       FROM `fccdsicapstone-218522.broadband.acs_blockgroup_2014` a, `fccdsicapstone-218522.broadband.acs_blockgroup2_2014` b
       WHERE a.block_group_code = b.block_group_code
       
       UNION ALL
       
       SELECT a.block_group_code, '2015' AS year, * EXCEPT (block_group_code)
       FROM `fccdsicapstone-218522.broadband.acs_blockgroup_2015` a, `fccdsicapstone-218522.broadband.acs_blockgroup2_2015` b
       WHERE a.block_group_code = b.block_group_code       
       
       UNION ALL
       
       SELECT a.block_group_code, '2016' AS year, * EXCEPT (block_group_code)
       FROM `fccdsicapstone-218522.broadband.acs_blockgroup_2016` a, `fccdsicapstone-218522.broadband.acs_blockgroup2_2016` b
       WHERE a.block_group_code = b.block_group_code
 )
