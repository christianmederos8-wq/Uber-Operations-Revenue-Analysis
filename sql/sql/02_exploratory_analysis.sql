/*
===============================================================================
 Project: Uber Operations & Revenue Analysis
 File: 02_exploratory_analysis.sql
 Author: Christian Mederos

 Description:
 This script performs exploratory data analysis to understand the structure,
 distributions, ranges, and general behavior of the Uber dataset before
 calculating KPIs and answering detailed business questions.
===============================================================================
*/

USE uber;
/*
===============================================================================
1. TRIP STATUS DISTRIBUTION
===============================================================================

Question:
What is the distribution of trips by status?

Business Purpose:
Understand the operational composition of trips before performing
business and financial analysis.
===============================================================================
*/

SELECT
    status,
    COUNT(*) AS trip_count
FROM trips
GROUP BY status
ORDER BY trip_count DESC;

/*
Observation:

- The dataset contains three trip statuses: completed, cancelled, and in_progress.
- Completed trips account for 16,827 records, representing the majority of all trips.
- Cancelled trips total 2,966, indicating that cancellations represent a significant portion of the dataset.
- Only 207 trips remain in progress, suggesting that most operational records have reached a final status.
- This distribution provides context for subsequent revenue, operational, and performance analyses.
*/
/*
===============================================================================
2. PAYMENT METHOD DISTRIBUTION
===============================================================================

Question:
What is the distribution of payment methods?

Business Purpose:
Understand customer payment preferences before analyzing revenue
and payment performance.
===============================================================================
*/

SELECT
    method,
    COUNT(*) AS payment_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM payments
GROUP BY method
ORDER BY payment_count DESC;

/*
Observation:

- Card is the most frequently used payment method, accounting for 5,700
  transactions (33.87%).
- Wallet follows closely with 5,621 transactions (33.40%).
- Cash represents 5,506 transactions (32.72%).
- Payment methods are almost evenly distributed, with no single method
  dominating customer preferences.
- This balanced distribution suggests that the platform supports multiple
  payment options effectively, without a strong dependence on a single method.
*/
/*
===============================================================================
3. TRIP DISTRIBUTION BY CITY
===============================================================================

Question:
Which cities generate the highest number of trips?

Business Purpose:
Understand the geographic distribution of trip demand and identify the cities
with the highest operational activity.
===============================================================================
*/

SELECT
    l.city,
    COUNT(t.trip_id) AS trip_count
FROM trips AS t
JOIN locations AS l
    ON t.pickup_location_id = l.location_id
GROUP BY l.city
ORDER BY trip_count DESC;

/*
Observation:

- New York records the highest trip volume with 5,694 trips.
- Houston follows with 5,329 trips, while Chicago and Los Angeles account for
  4,693 and 4,284 trips, respectively.
- Trip demand is distributed across four cities, with New York representing the
  largest share of operational activity.
- Understanding trip distribution by city provides valuable context for
  subsequent revenue, driver performance, and demand analyses.
*/
/*
===============================================================================
4. TRIP DISTRIBUTION BY ZONE
===============================================================================

Question:
Which zones generate the highest number of trips?

Business Purpose:
Identify the areas with the highest trip demand to better understand
geographical activity across the platform.
===============================================================================
*/

SELECT
    l.zone_name,
    COUNT(t.trip_id) AS trip_count
FROM trips AS t
JOIN locations AS l
    ON t.pickup_location_id = l.location_id
GROUP BY l.zone_name
ORDER BY trip_count DESC;
/*
Observation:

- Flushing records the highest trip volume with 607 trips.
- Greenwich Village and Upper West Side follow closely with 593 trips each,
  while Times Square (582) and JFK Airport (578) complete the top five zones.
- The results indicate that trip demand is distributed across both downtown
  areas and major transportation hubs, such as airports and train stations.
- This geographic distribution provides valuable context for identifying
  high-demand areas and supports future analyses of revenue and operational
  performance by location.
*/
/*
===============================================================================
5. TRIP DISTANCE STATISTICS
===============================================================================

Question:
What are the minimum, maximum, and average trip distances?

Business Purpose:
Understand the distribution of trip distances to gain insights into
customer travel patterns and support operational analysis.
===============================================================================
*/
/*
===============================================================================
5. TRIP DISTANCE STATISTICS
===============================================================================

Question:
What are the minimum, maximum, and average trip distances?

Business Purpose:
Understand the distribution of trip distances to gain insights into
customer travel patterns and support operational analysis.
===============================================================================
*/

SELECT
    MIN(distance_km) AS min_distance,
    MAX(distance_km) AS max_distance,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM trips;
/*
Observation:

- Trip distances range from 0.50 km to 60.18 km.
- The average trip distance is 18.01 km.
- The wide range of trip distances indicates that the dataset includes both
  short-distance urban trips and longer journeys.
- Understanding trip distance distribution provides valuable context for
  subsequent analyses of fares, driver performance, and operational efficiency.
*/
/*
===============================================================================
6. TRIP FARE STATISTICS
===============================================================================

Question:
What are the minimum, maximum, and average trip fares?

Business Purpose:
Analyze the fare distribution to better understand pricing patterns
across all recorded trips.
===============================================================================
*/

SELECT
    MIN(total_fare) AS min_fare,
    MAX(total_fare) AS max_fare,
    ROUND(AVG(total_fare), 2) AS avg_fare
FROM trips;
/*
Observation:

- Trip fares range from 3.65 to 224.27 monetary units.
- The average fare is 36.01 monetary units.
- The wide fare range suggests that the dataset includes both short, low-cost
  trips and longer, higher-value journeys.
- These statistics provide a baseline for subsequent revenue analysis and
  support the identification of pricing patterns across the platform.
*/
/*
===============================================================================
7. TRIP DURATION STATISTICS
===============================================================================

Question:
What are the minimum, maximum, and average trip durations?

Business Purpose:
Analyze trip duration to better understand travel time patterns and
support operational performance analysis.
===============================================================================
*/

SELECT
    MIN(duration_mins) AS min_duration,
    MAX(duration_mins) AS max_duration,
    ROUND(AVG(duration_mins), 2) AS avg_duration
FROM trips;
/*
Observation:

- Trip durations range from 3 to 153 minutes.
- The average trip duration is 31.32 minutes.
- The dataset includes both short trips and considerably longer journeys,
  reflecting a wide variety of travel scenarios.
- Trip duration statistics provide useful context for evaluating operational
  efficiency and understanding customer travel behavior.
*/
/*
===============================================================================
8. REVIEW RATING STATISTICS
===============================================================================

Question:
What are the minimum, maximum, and average review ratings?

Business Purpose:
Analyze customer satisfaction by examining the distribution of review
ratings across completed trips.
===============================================================================
*/

SELECT
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    ROUND(AVG(rating), 2) AS avg_rating
FROM reviews;
/*
Observation:

- Review ratings range from 1 to 5 stars.
- The average customer rating is 3.65 stars.
- The full rating scale is represented in the dataset, indicating a variety
  of customer experiences.
- The average rating suggests an overall moderate level of customer
  satisfaction, providing a useful baseline for evaluating driver
  performance and service quality.
*/
