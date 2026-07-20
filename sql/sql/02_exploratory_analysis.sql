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
