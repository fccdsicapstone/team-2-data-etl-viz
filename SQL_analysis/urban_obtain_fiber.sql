SELECT f4.block_group_code, f4.perc_urban, f4.population pop14, f5.population pop15, f6.population pop16, f4.median_home_value home_value14, f5.median_home_value home_value15, f6.median_home_value home_value16, f4.avg_n_of_tech50_servs fiber14, f5.avg_n_of_tech50_servs fiber15, f6.avg_n_of_tech50_servs fiber16
FROM broadband.fcc_acs_with_geo_2014 f4
     RIGHT JOIN broadband.fcc_acs_with_geo_2015 f5 ON f4.block_group_code = f5.block_group_code
     RIGHT JOIN broadband.fcc_acs_with_geo_2016 f6 ON f5.block_group_code = f6.block_group_code
WHERE ((f4.avg_n_of_tech50_servs IS NULL AND f5.avg_n_of_tech50_servs > 0 AND f6.avg_n_of_tech50_servs > 0) OR
      (f4.avg_n_of_tech50_servs = 0 AND f5.avg_n_of_tech50_servs > 0 AND f6.avg_n_of_tech50_servs > 0) OR
      (f4.avg_n_of_tech50_servs IS NULL AND f5.avg_n_of_tech50_servs IS NULL AND f6.avg_n_of_tech50_servs > 0) OR
      (f4.avg_n_of_tech50_servs IS NULL AND f5.avg_n_of_tech50_servs = 0 AND f6.avg_n_of_tech50_servs > 0) OR
      (f4.avg_n_of_tech50_servs = 0 AND f5.avg_n_of_tech50_servs = 0 AND f6.avg_n_of_tech50_servs > 0) OR
      (f4.avg_n_of_tech50_servs = 0 AND f5.avg_n_of_tech50_servs IS NULL AND f6.avg_n_of_tech50_servs > 0)) AND
      f4.perc_urban > 0.8 AND f6.median_home_value != -666666666
