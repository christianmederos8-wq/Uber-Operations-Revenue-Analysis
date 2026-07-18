# Data Dictionary

This document describes the structure of the Uber database used in the project.

## Database Tables

| Table | Description |
|---|---|
| cancellations | Stores information about cancelled trips and cancellation reasons |
| drivers | Contains driver profile and performance information |
| locations | Stores pickup and drop-off location data |
| payments | Contains payment transactions and payment methods |
| reviews | Stores ratings and reviews associated with trips |
| riders | Contains rider profile information |
| trips | Central transactional table containing trip details |
| users | Stores general user account information |
---

# Table: cancellations

### Description

This table stores information about cancelled trips, including who initiated the cancellation, the reason for the cancellation, and the timestamp of the cancellation.

| Column | Data Type | Description |
|----------|-----------|-------------|
| cancel_id | INT | Unique identifier for each cancellation. |
| trip_id | INT | Identifier of the cancelled trip. |
| cancelled_by | VARCHAR(10) | Indicates who cancelled the trip. |
| reason | VARCHAR(100) | Reason for the cancellation. |
| cancelled_at | DATETIME | Date and time of the cancellation. |

### Relationships

| Foreign Key | References |
|-------------|------------|
| trip_id | trips.trip_id |
---

# Table: drivers

### Description

This table stores information about drivers registered on the platform, including their vehicle details, performance rating, registration date, and account status.

| Column | Data Type | Description |
|----------|-----------|-------------|
| driver_id | INT | Unique identifier for each driver. |
| user_id | INT | References the corresponding user account. |
| vehicle_make | VARCHAR(50) | Manufacturer of the driver's vehicle. |
| vehicle_model | VARCHAR(50) | Vehicle model. |
| vehicle_year | INT | Manufacturing year of the vehicle. |
| license_plate | VARCHAR(20) | Unique license plate number of the vehicle. |
| rating | DOUBLE | Average driver rating. |
| join_date | DATE | Date the driver joined the platform. |
| is_active | INT | Indicates whether the driver account is active (1 = Active, 0 = Inactive). |

### Relationships

| Foreign Key | References |
|-------------|------------|
| user_id | users.user_id *(to be confirmed)* |

### Constraints

- `driver_id` is the Primary Key.
- `license_plate` must be unique.
- ---

# Table: locations

### Description

This table stores geographic information about pickup and drop-off zones used in the Uber platform. Each location includes its name, city, geographic coordinates, and zone classification.

| Column | Data Type | Description |
|----------|-----------|-------------|
| location_id | INT | Unique identifier for each location. |
| zone_name | VARCHAR(100) | Name of the pickup or drop-off zone. |
| city | VARCHAR(80) | City where the location is located. |
| latitude | DOUBLE | Latitude coordinate of the location. |
| longitude | DOUBLE | Longitude coordinate of the location. |
| zone_type | VARCHAR(50) | Classification of the zone (e.g., Residential, Commercial, Airport). |

### Relationships

This table is referenced by the **trips** table through the pickup and drop-off location identifiers.

### Constraints

- `location_id` is the Primary Key.
- ---

# Table: payments

### Description

This table stores payment information for completed trips, including the amount charged, payment method, transaction status, and payment timestamp.

| Column | Data Type | Description |
|----------|-----------|-------------|
| payment_id | INT | Unique identifier for each payment transaction. |
| trip_id | INT | Identifier of the associated trip. |
| amount | DOUBLE | Total amount paid for the trip. |
| method | VARCHAR(20) | Payment method used (e.g., Cash, Credit Card, Digital Wallet). |
| status | VARCHAR(20) | Current payment status (e.g., Completed, Pending, Failed). |
| paid_at | DATETIME | Date and time when the payment was processed. |

### Relationships

| Foreign Key | References |
|-------------|------------|
| trip_id | trips.trip_id |

### Constraints

- `payment_id` is the Primary Key.
- ---

# Table: reviews

### Description

This table stores ratings and written reviews exchanged between users after a trip. It records who submitted the review, who received it, the rating score, the comment, and the review date.

| Column | Data Type | Description |
|----------|-----------|-------------|
| review_id | INT | Unique identifier for each review. |
| trip_id | INT | Identifier of the associated trip. |
| reviewer_id | INT | Identifier of the user who submitted the review. |
| reviewee_id | INT | Identifier of the user who received the review. |
| rating | INT | Rating score given by the reviewer. |
| comment | TEXT | Optional written feedback. |
| reviewed_at | DATETIME | Date and time when the review was submitted. |

### Relationships

| Foreign Key | References |
|-------------|------------|
| trip_id | trips.trip_id |
| reviewer_id | users.user_id *(to be confirmed)* |
| reviewee_id | users.user_id *(to be confirmed)* |

### Constraints

- `review_id` is the Primary Key.
- ---

# Table: riders

### Description

This table stores information about riders registered on the platform, including their overall rating, total completed trips, and account creation date.

| Column | Data Type | Description |
|----------|-----------|-------------|
| rider_id | INT | Unique identifier for each rider. |
| user_id | INT | References the corresponding user account. |
| rating | DOUBLE | Average rating received by the rider. |
| total_trips | INT | Total number of trips completed by the rider. |
| created_at | DATETIME | Date and time when the rider account was created. |

### Relationships

| Foreign Key | References |
|-------------|------------|
| user_id | users.user_id *(to be confirmed)* |

### Constraints

- `rider_id` is the Primary Key.
- `total_trips` has a default value of **0**.
- ---

# Table: trips

### Description

This table stores the main operational information for each trip, including the rider, driver, pickup and drop-off locations, trip timestamps, status, distance, duration, fare components, and payment method.

| Column | Data Type | Description |
|---|---|---|
| trip_id | INT | Unique identifier for each trip. |
| rider_id | INT | Identifier of the rider who requested the trip. |
| driver_id | INT | Identifier of the driver assigned to the trip. |
| pickup_location_id | INT | Identifier of the trip's pickup location. |
| dropoff_location_id | INT | Identifier of the trip's drop-off location. |
| requested_at | DATETIME | Date and time when the rider requested the trip. |
| started_at | DATETIME | Date and time when the trip started. |
| completed_at | DATETIME | Date and time when the trip was completed. |
| status | VARCHAR(20) | Current or final trip status, such as Completed or Cancelled. |
| distance_km | DOUBLE | Total trip distance measured in kilometers. |
| duration_mins | INT | Total trip duration measured in minutes. |
| base_fare | DOUBLE | Base fare charged before surge pricing or other adjustments. |
| surge_multiplier | DOUBLE | Multiplier applied to the fare during periods of high demand. |
| total_fare | DOUBLE | Final fare charged for the trip. |
| payment_method | VARCHAR(20) | Payment method selected for the trip. |

### Relationships

| Foreign Key | References |
|---|---|
| rider_id | riders.rider_id |
| driver_id | drivers.driver_id |
| pickup_location_id | locations.location_id |
| dropoff_location_id | locations.location_id |

### Constraints

- `trip_id` is the Primary Key.
- `rider_id`, `driver_id`, `pickup_location_id`, and `dropoff_location_id` are required fields.
- ---

# Table: users

### Description

This table stores the general information for all users registered on the platform. Both riders and drivers are represented here, while role-specific information is stored in the corresponding tables.

| Column | Data Type | Description |
|---|---|---|
| user_id | INT | Unique identifier for each user. |
| name | VARCHAR(100) | Full name of the user. |
| email | VARCHAR(150) | User's email address. |
| phone | VARCHAR(20) | User's phone number. |
| city | VARCHAR(80) | City where the user is registered. |
| date_joined | DATE | Date the user joined the platform. |
| is_driver | INT | Indicates whether the user is registered as a driver (1 = Driver, 0 = Rider). |

### Relationships

| Referenced By |
|---|
| drivers.user_id |
| riders.user_id |
| reviews.reviewer_id *(to be confirmed)* |
| reviews.reviewee_id *(to be confirmed)* |

### Constraints

- `user_id` is the Primary Key.
- `email` must be unique.
- `is_driver` has a default value of **0**.
