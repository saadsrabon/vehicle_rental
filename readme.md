#  Vehicle Rental System – Database Design & SQL Queries

##  Project Overview

This project demonstrates the **database design and SQL query implementation** for a **Vehicle Rental System** using **PostgreSQL**.  
The main objective of this project is to apply **relational database concepts**, **Entity Relationship Diagram (ERD) design**, and **SQL querying** based on real-world business scenarios.

The system manages:
- Users (Admins and Customers)
- Vehicles (Cars, Bikes, Trucks)
- Bookings (Vehicle rental records)

This project covers:
- Table relationships using primary and foreign keys
- JOIN operations
- Subqueries
- Aggregation using `GROUP BY`, `COUNT`, and `HAVING`

---



---

##  Database Design (ERD)

The database consists of **three core tables**:

- **users**
- **vehicles**
- **bookings**

### Relationships
- One **User** can have **many Bookings**
- One **Vehicle** can have **many Bookings**
- Each **Booking** is linked to **exactly one User and one Vehicle**

### ERD Diagram

![ERD Diagram](erd.png)


---

Viva Video Link:https://www.youtube.com/shorts/VMiubhyOoVk
Erd Link: https://lucid.app/lucidchart/c0fd9c84-7d02-41b2-b610-99c7e56724c0/edit?view_items=aIzg9tKKXa2q&page=0_0&invitationId=inv_60e7f4db-a6ca-4b38-a698-6765fe79f2c3
##  Tables Description

###  Users Table
Stores system users including admins and customers.

**Key fields:**
- `user_id` (Primary Key)
- `name`
- `email` (Unique)
- `role` (admin / customer)

---

###  Vehicles Table
Stores vehicle details available for rent.

**Key fields:**
- `vehicle_id` (Primary Key)
- `name`
- `type` (car / bike / truck)
- `status` (available / rented / maintenance)

---
###  Bookings Table
Stores booking and rental information.

**Key fields:**
- `booking_id` (Primary Key)
- `user_id` (Foreign Key → users)
- `vehicle_id` (Foreign Key → vehicles)
- `start_date`
- `end_date`
- `status` (pending / confirmed / completed / cancelled)

---

##  SQL Queries Explanation (`queries.sql`)

All SQL queries are written and tested using **PostgreSQL**.

---

### 1️ Retrieve Booking Information with Customer and Vehicle Names

**Purpose:**  
Display booking details along with the customer name and vehicle name.

```sql
SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM bookings AS b
INNER JOIN users AS u
  ON b.user_id = u.user_id
INNER JOIN vehicles AS v
  ON b.vehicle_id = v.vehicle_id;
  ```

#### Explanation:  Here what we did is  join the both table so that we can get all the column and then showed them as boking table dont have the vehicles details except the vehicel_id

### Find Vehicles That Have Never Been Booked

** Purpose: **
Retrieve vehicles that do not exist in the bookings table.
```sql
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.vehicle_id
);
```
Concepts used:
NOT EXISTS, correlated subquery
 #### Explanation : In this query we are  using a subquery so its going for each vehicle id and trying to match on booking table if found then it will return otherwise nothing will happen

### Retrieve All Vehicles of Type "Car"

Purpose:
Filter vehicles by type.

```
SELECT *
FROM vehicles
WHERE type = 'car';
```

Concepts used:
WHERE clause, filtering

#### Explanation :Here we are simply finding out by types using where

### Find Vehicles with More Than 2 Bookings

Purpose:
Count total bookings per vehicle and show only vehicles with more than two bookings.

```
SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN vehicles v
    ON b.vehicle_id = v.vehicle_id
GROUP BY
    v.vehicle_id, v.name
HAVING
    COUNT(b.booking_id) > 2;```


Concepts used:
JOIN, GROUP BY, COUNT, HAVING 
```

#### Explanation : Herer we are joining Vehicle and Book table and using name aliases for easy reading  and  grouping them by name and id and as we know we can use having on group data so we are using to check the value if it is more than 2 or not