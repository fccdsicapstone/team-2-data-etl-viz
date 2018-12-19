SELECT f4.block_group_code, f4.perc_high_spd high14, f5.perc_high_spd high15, f6.perc_high_spd high16
FROM broadband.fcc_acs_with_geo_and_props_2014_table f4
     RIGHT JOIN broadband.fcc_acs_with_geo_and_props_2015_table f5 ON f4.block_group_code = f5.block_group_code
     RIGHT JOIN broadband.fcc_acs_with_geo_and_props_2016_table f6 ON f5.block_group_code = f6.block_group_code
WHERE (f4.perc_high_spd = 0 AND f5.perc_high_spd > 0 AND f6.perc_high_spd > 0) OR
      (f4.perc_high_spd = 0 AND f5.perc_high_spd = 0 AND f6.perc_high_spd > 0)
