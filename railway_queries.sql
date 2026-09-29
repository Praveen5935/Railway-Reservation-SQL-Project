USE railway_reservation_db;


-- 41. Retrieve all bookings with fare greater than 400.

SELECT *
FROM bookings
WHERE fare > 400;


-- 42. Find bookings where status is not 'Confirmed'.

SELECT *
FROM bookings
WHERE status <> 'Confirmed';


-- 43. Display trains starting from Chennai.

SELECT *
FROM trains
WHERE source = 'Chennai';


-- 44. Retrieve bookings with fare between 300 and 500.

SELECT *
FROM bookings
WHERE fare BETWEEN 300 AND 500;


-- 45. Find passengers whose names start with 'A'.

SELECT *
FROM bookings
WHERE passenger_name LIKE 'A%';


-- =========================================================
-- JOINS + GROUP BY + ORDER BY
-- QUESTIONS 46 - 48
-- =========================================================


-- 46. Retrieve train names along with passenger names.

SELECT
    t.train_name,
    b.passenger_name
FROM trains t
INNER JOIN bookings b
    ON t.train_id = b.train_id;


-- 47. Count number of bookings for each train.

SELECT
    t.train_name,
    COUNT(b.booking_id) AS booking_count
FROM trains t
LEFT JOIN bookings b
    ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;


-- 48. Display train names and total fare collected
-- for each train.

SELECT
    t.train_name,
    COALESCE(SUM(b.fare), 0) AS total_fare
FROM trains t
LEFT JOIN bookings b
    ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
ORDER BY total_fare DESC;


-- =========================================================
-- SUBQUERIES
-- QUESTIONS 49 - 50
-- =========================================================


-- 49. Find bookings with fare equal to the highest fare.

SELECT *
FROM bookings
WHERE fare = (
    SELECT MAX(fare)
    FROM bookings
);


-- 50. Retrieve trains that have more than one booking.

SELECT
    t.train_id,
    t.train_name,
    COUNT(b.booking_id) AS booking_count
FROM trains t
INNER JOIN bookings b
    ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(b.booking_id) > 1;
