{{ config(materialized='view') }}

SELECT *
FROM trips_data_all.green_tripdata