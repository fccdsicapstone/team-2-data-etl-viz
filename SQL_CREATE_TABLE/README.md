# Load ACS block group level data into BigQuery

After creating table in BigQuery run the following command to upload the data.

    bq load -F , --source_format CSV --skip_leading_rows 1 -E UTF-8 broadband.acs_blockgroup_2014 gs://fcc-data-storage/acs2014_blockgroup.csv
