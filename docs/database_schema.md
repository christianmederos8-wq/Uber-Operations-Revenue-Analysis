# Database Schema

## Overview

The Uber database is designed using a relational model where the **trips** table serves as the central entity. Supporting tables store information about users, drivers, riders, locations, payments, cancellations, and reviews.

This design allows the analysis of operational performance, customer behavior, driver performance, trip demand, revenue generation, and service quality.

---

# Entity Relationships

## users

Stores the general information for all registered users.

Relationships:

- One user can be a rider.
- One user can be a driver.
- One user can write reviews.
- One user can receive reviews.

---

## riders

Contains rider-specific information.

Relationship:

- One rider can request many trips.

```
riders (1)
     │
     └──────────< trips
```

---

## drivers

Contains driver-specific information.

Relationship:

- One driver can complete many trips.

```
drivers (1)
      │
      └──────────< trips
```

---

## locations

Stores pickup and drop-off locations.

Relationships:

- One location can be the pickup location for many trips.
- One location can be the drop-off location for many trips.

```
locations (1)
      │
      ├──────────< pickup_location_id
      │
      └──────────< dropoff_location_id
```

---

## trips

This is the central transactional table.

Each trip:

- belongs to one rider
- belongs to one driver
- starts at one location
- ends at one location
- may have one payment
- may have one cancellation
- may have one or more reviews

---

## payments

Stores payment information for completed trips.

Relationship:

- One payment belongs to one trip.

```
trips (1)
    │
    └────────── payments
```

---

## cancellations

Stores cancellation records.

Relationship:

- One cancellation belongs to one trip.

```
trips (1)
    │
    └────────── cancellations
```

---

## reviews

Stores ratings and comments exchanged after trips.

Relationships:

- One trip can have reviews.
- One user can review another user.

---

# Relational Model

```text
users
├── drivers
├── riders
│
├───────────────┐
│               │
│           reviews
│               ▲
│               │
└───────────────┘

locations
     ▲
     │
trips
├── payments
├── cancellations
└── reviews
```

---

# Database Design Notes

The database follows normalization principles by separating user information from rider and driver information.

The **trips** table acts as the fact table, while the remaining tables provide descriptive information that supports analytical queries.

This schema enables business analysis related to:

- Revenue
- Driver performance
- Rider behavior
- Trip demand
- Geographic distribution
- Service quality
- Cancellation analysis
- Payment analysis
