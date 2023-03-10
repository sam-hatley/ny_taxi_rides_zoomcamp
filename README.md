## Week 4 Homework 

In this week, I'm negelecting to include this file, as the code is provided in [a separate repo](https://github.com/sam-hatley/ny_taxi_rides_zoomcamp).

>In this homework, we'll use the models developed during the week 4 videos and enhance the already presented dbt project using the already loaded Taxi data for fhv vehicles for year 2019 in our DWH.

>This means that in this homework we use the following data [Datasets list](https://github.com/DataTalksClub/nyc-tlc-data/)
>* Yellow taxi data - Years 2019 and 2020
>* Green taxi data - Years 2019 and 2020 
>* fhv data - Year 2019. 

>We will use the data loaded for:

>* Building a source table: `stg_fhv_tripdata`
>* Building a fact table: `fact_fhv_trips`
>* Create a dashboard 

>If you don't have access to GCP, you can do this locally using the ingested data from your Postgres database instead. If you have access to GCP, you don't need to do it for local Postgres - only if you want to.

> **Note**: if your answer doesn't match exactly, select the closest option

### Setup:

1. Added the following entry in [schema.yml](models/staging/schema.yml):
```yaml
tables:
    ...
    - name: fhv_tripdata
```

2. Added [sth_fhv_tripdata.sql](models/staging/stg_fhv_tripdata.sql)
```sql
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

...
```

3. Added [fact_fhv_trips.sql](models/core/fact_fhv_trips.sql), which was a basic rewrite of [fact_trips.sql](models/core/fact_trips.sql)

Also: although I defaulted `is_test_run` to `FALSE`, I made sure to add the entry `dbt run --var 'is_test_run: false'` to the job itself.  


### Question 1: 

>**What is the count of records in the model fact_trips after running all models with the test run variable disabled and filtering for 2019 and 2020 data only (pickup datetime)?** 

>You'll need to have completed the ["Build the first dbt models"](https://www.youtube.com/watch?v=UVI30Vxzd6c) video and have been able to run the models via the CLI. 
>You should find the views and models for querying in your DWH.

- 61648442

This can be done either from looker, or with an SQL query. My number was 61,568,714.


### Question 2: 

>**What is the distribution between service type filtering by years 2019 and 2020 data as done in the videos?**

>You will need to complete "Visualising the data" videos, either using [google data studio](https://www.youtube.com/watch?v=39nLTs74A3E) or [metabase](https://www.youtube.com/watch?v=BnLkrA7a6gM). 

- 89.9/10.1

Done by selecting a date range from within looker



### Question 3: 

>**What is the count of records in the model stg_fhv_tripdata after running all models with the test run variable disabled (:false)?**  

>Create a staging model for the fhv data for 2019 and do not add a deduplication step. Run it via the CLI without limits (is_test_run: false).
>Filter records with pickup time in year 2019.

- 43244696

This can be done either from looker, or with an SQL query. My number was 43,244,696.

### Question 4: 

>**What is the count of records in the model fact_fhv_trips after running all dependencies with the test run variable disabled (:false)?**  

>Create a core model for the stg_fhv_tripdata joining with dim_zones.
>Similar to what we've done in fact_trips, keep only records with known pickup and dropoff locations entries for pickup and dropoff locations. 
>Run it via the CLI without limits (is_test_run: false) and filter records with pickup time in year 2019.

- 22998722

This can be done either from looker, or with an SQL query. My number was 22,998,722.

### Question 5: 

>**What is the month with the biggest amount of rides after building a tile for the fact_fhv_trips table?**

>Create a dashboard with some tiles that you find interesting to explore the data. One tile should show the amount of trips per month, as done in the videos for fact_trips, based on the fact_fhv_trips table.

- January

Something bizarre happened after January. [Dashboard here](https://lookerstudio.google.com/reporting/eb30ae3a-dc94-4b3f-8e6b-be46f1b8153c).

## Submitting the solutions

* Form for submitting: https://forms.gle/6A94GPutZJTuT5Y16
* You can submit your homework multiple times. In this case, only the last submission will be used. 

Deadline: 25 February (Saturday), 22:00 CET


## Solution

We will publish the solution here