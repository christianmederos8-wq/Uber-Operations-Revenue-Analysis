/*
===============================================================================
 Project: Uber Operations & Revenue Analysis
 File: 01_data_quality.sql
 Author: Christian Mederos

 Description:
 This script evaluates the quality of the Uber dataset before performing
 business analysis. It checks table size, missing values, duplicate records,
 referential integrity, consistency, and possible outliers.
===============================================================================
*/

USE uber;

/*
===============================================================================
1. TABLE OVERVIEW
===============================================================================

Question:
How many records are available in each table?

Business Purpose:
Understand the volume of available data before performing business analysis.
===============================================================================
*/

SELECT
    'users' AS table_name,
    COUNT(*) AS total_records
FROM users

UNION ALL

SELECT
    'drivers' AS table_name,
    COUNT(*) AS total_records
FROM drivers

UNION ALL

SELECT
    'riders' AS table_name,
    COUNT(*) AS total_records
FROM riders

UNION ALL

SELECT
    'trips' AS table_name,
    COUNT(*) AS total_records
FROM trips

UNION ALL

SELECT
    'payments' AS table_name,
    COUNT(*) AS total_records
FROM payments

UNION ALL

SELECT
    'reviews' AS table_name,
    COUNT(*) AS total_records
FROM reviews

UNION ALL

SELECT
    'locations' AS table_name,
    COUNT(*) AS total_records
FROM locations

UNION ALL

SELECT
    'cancellations' AS table_name,
    COUNT(*) AS total_records
FROM cancellations;
/*
Initial observation:

- The trips table contains the largest number of records.
- The locations table contains the smallest number of records.
- The dataset contains 20,000 trips, 16,827 payments, and 2,966 cancellations.
- Further checks are required to understand trips without payments or cancellations.
*/

/*
===============================================================================
2. MISSING VALUES
===============================================================================

Question:
Are there missing values in critical fields?

Business Purpose:
Determine whether incomplete data could affect business analysis.
===============================================================================
*/

/*
---------------------------------------
2.1 Trips
---------------------------------------
*/

SELECT
    COUNT(*) AS total_trips,
    SUM(rider_id IS NULL) AS rider_id_nulls,
    SUM(driver_id IS NULL) AS driver_id_nulls,
    SUM(pickup_location_id IS NULL) AS pickup_location_nulls,
    SUM(dropoff_location_id IS NULL) AS dropoff_location_nulls,
    SUM(requested_at IS NULL) AS requested_at_nulls,
    SUM(status IS NULL) AS status_nulls,
    SUM(total_fare IS NULL) AS total_fare_nulls
FROM trips;

/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The trips table is complete for the selected business attributes.
- The dataset is suitable for subsequent exploratory and business analyses.
*/

/*
---------------------------------------
2.2 Payments
---------------------------------------
*/

SELECT
    COUNT(*) AS total_payments,
    SUM(payment_id IS NULL) AS payment_id_nulls,
    SUM(trip_id IS NULL) AS trip_id_nulls,
    SUM(amount IS NULL) AS amount_nulls,
    SUM(method IS NULL) AS method_nulls,
    SUM(status IS NULL) AS status_nulls,
    SUM(paid_at IS NULL) AS paid_at_nulls
FROM payments;

/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The payments table is complete and suitable for financial analysis.
*/
/*
---------------------------------------
2.3 Drivers
---------------------------------------
*/
SELECT
    COUNT(*) AS total_drivers,
    SUM(driver_id IS NULL) AS driver_id_nulls,
    SUM(user_id IS NULL) AS user_id_nulls,
    SUM(vehicle_make IS NULL) AS vehicle_make_nulls,
    SUM(vehicle_model IS NULL) AS vehicle_model_nulls,
    SUM(vehicle_year IS NULL) AS vehicle_year_nulls,
    SUM(license_plate IS NULL) AS license_plate_nulls,
    SUM(rating IS NULL) AS rating_nulls,
    SUM(join_date IS NULL) AS join_date_nulls,
    SUM(is_active IS NULL) AS is_active_nulls
FROM drivers;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The drivers table is complete and suitable for driver performance analysis.
*/

/*
---------------------------------------
2.4 Riders
---------------------------------------
*/
SELECT
    COUNT(*) AS total_riders,
    SUM(rider_id IS NULL) AS rider_id_nulls,
    SUM(user_id IS NULL) AS user_id_nulls,
    SUM(rating IS NULL) AS rating_nulls,
    SUM(total_trips IS NULL) AS total_trips_nulls,
    SUM(created_at IS NULL) AS created_at_nulls
FROM riders;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The riders table is complete and suitable for rider behavior analysis.
*/
/*
---------------------------------------
2.5 Reviews
---------------------------------------
*/
SELECT
    COUNT(*) AS total_reviews,
    SUM(review_id IS NULL) AS review_id_nulls,
    SUM(trip_id IS NULL) AS trip_id_nulls,
    SUM(reviewer_id IS NULL) AS reviewer_id_nulls,
    SUM(reviewee_id IS NULL) AS reviewee_id_nulls,
    SUM(rating IS NULL) AS rating_nulls,
    SUM(comment IS NULL) AS comment_nulls,
    SUM(reviewed_at IS NULL) AS reviewed_at_nulls
FROM reviews;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The reviews table is complete and suitable for service quality analysis.
*/
/*
---------------------------------------
2.6 Users
---------------------------------------
*/
SELECT
    COUNT(*) AS total_users,
    SUM(user_id IS NULL) AS user_id_nulls,
    SUM(name IS NULL) AS name_nulls,
    SUM(email IS NULL) AS email_nulls,
    SUM(phone IS NULL) AS phone_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(date_joined IS NULL) AS date_joined_nulls,
    SUM(is_driver IS NULL) AS is_driver_nulls
FROM users;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The users table is complete and suitable for user analysis.
*/
/*
---------------------------------------
2.7 Locations
---------------------------------------
*/
SELECT
    COUNT(*) AS total_locations,
    SUM(location_id IS NULL) AS location_id_nulls,
    SUM(zone_name IS NULL) AS zone_name_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(latitude IS NULL) AS latitude_nulls,
    SUM(longitude IS NULL) AS longitude_nulls,
    SUM(zone_type IS NULL) AS zone_type_nulls
FROM locations;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The locations table is complete and suitable for geographical analysis.
*/
/*
---------------------------------------
2.8 Cancellations
---------------------------------------
*/
SELECT
    COUNT(*) AS total_cancellations,
    SUM(cancel_id IS NULL) AS cancel_id_nulls,
    SUM(trip_id IS NULL) AS trip_id_nulls,
    SUM(cancelled_by IS NULL) AS cancelled_by_nulls,
    SUM(reason IS NULL) AS reason_nulls,
    SUM(cancelled_at IS NULL) AS cancelled_at_nulls
FROM cancellations;
/*
Observation:

- No NULL values were found in the critical fields evaluated.
- The cancellations table is complete and suitable for cancellation analysis.
*/
/*
Section Summary:

- No NULL values were found in any of the eight tables.
- The dataset is complete for the fields evaluated.
- Missing data should not affect the subsequent business analyses.
*/

/*
===============================================================================
3. DUPLICATE PRIMARY KEYS
===============================================================================

Question:
Are there duplicate primary key values in any table?

Business Purpose:
Verify that each business entity is uniquely identified and prevent duplicate
records from affecting joins, aggregations, and KPI calculations.
===============================================================================
*/

/*
---------------------------------------
3.1 Users
---------------------------------------
*/

SELECT
    user_id,
    COUNT(*) AS duplicate_count
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.2 Drivers
---------------------------------------
*/

SELECT
    driver_id,
    COUNT(*) AS duplicate_count
FROM drivers
GROUP BY driver_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.3 Riders
---------------------------------------
*/

SELECT
    rider_id,
    COUNT(*) AS duplicate_count
FROM riders
GROUP BY rider_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.4 Trips
---------------------------------------
*/

SELECT
    trip_id,
    COUNT(*) AS duplicate_count
FROM trips
GROUP BY trip_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.5 Payments
---------------------------------------
*/

SELECT
    payment_id,
    COUNT(*) AS duplicate_count
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.6 Reviews
---------------------------------------
*/

SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.7 Locations
---------------------------------------
*/

SELECT
    location_id,
    COUNT(*) AS duplicate_count
FROM locations
GROUP BY location_id
HAVING COUNT(*) > 1;


/*
---------------------------------------
3.8 Cancellations
---------------------------------------
*/

SELECT
    cancel_id,
    COUNT(*) AS duplicate_count
FROM cancellations
GROUP BY cancel_id
HAVING COUNT(*) > 1;


/*
Section Summary:

- No duplicate primary key values were found in any of the eight tables.
- Each entity is uniquely identified by its corresponding primary key.
- Duplicate primary keys should not affect joins, aggregations, or KPI calculations.
*/
