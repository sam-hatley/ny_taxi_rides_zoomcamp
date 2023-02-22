{{ config(materialized='table') }}

fhv_data AS (
    SELECT *
    FROM {{ ref('stg_fhv_tripdata') }}
), 

dim_zones AS (
    SELECT * 
    FROM {{ ref('dim_zones') }}
    where borough != 'Unknown'
)

SELECT 
    fhv_data.dispatching_bASe_num, 
    fhv_data.pulocationid, 
    pickup_zone.borough AS pickup_borough, 
    pickup_zone.zone AS pickup_zone, 
    fhv_data.dolocationid,
    dropoff_zone.borough AS dropoff_borough, 
    dropoff_zone.zone AS dropoff_zone,  
    fhv_data.pickup_datetime, 
    fhv_data.dropoff_datetime,
    fhv_data.pickup_datetime, 
    fhv_data.dropoff_datetime, 
    fhv_data.sr_flag, 
    fhv_data.affiliated_base_number
FROM fhv_data
INNER JOIN dim_zones AS pickup_zone
    ON fhv_data.pulocationid = pickup_zone.locationid
INNER JOIN dim_zones AS dropoff_zone
    ON fhv_data.dolocationid = dropoff_zone.locationid