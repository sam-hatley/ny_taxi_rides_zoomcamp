{{ config(materialized='view') }}

SELECT *
FROM {{ source('staging', 'green_tripdata') }}
LIMIT 100