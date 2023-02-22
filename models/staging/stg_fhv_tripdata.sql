{{ config(materialized='view') }}

SELECT
    CAST(dispatching_base_num AS STRING) AS dispatching_base_num,
    CAST(pickup_datetime AS TIMESTAMP) AS pickup_datetime,
    CAST(dropOff_datetime AS TIMESTAMP) AS dropoff_datetime,
    CAST(PUlocationID AS INTEGER) AS pulocationid,
    CAST(DOlocationID AS INTEGER) AS dolocationid,
    CAST(SR_Flag AS STRING) AS sr_flag,
    CAST(Affiliated_base_number AS STRING) AS affiliated_base_number
FROM {{ source('staging', 'fhv_tripdata') }}

{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}