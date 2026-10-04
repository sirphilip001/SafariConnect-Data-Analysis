CREATE TABLE safariconnect.safari_connect_clean (
    booking_id          TEXT,
    passenger_name      TEXT,
    passenger_phone     TEXT,
    passenger_gender    TEXT,
    passenger_city      TEXT,
    route_code          TEXT,
    route_from          TEXT,
    route_to            TEXT,
    vehicle_plate       TEXT,
    vehicle_type        TEXT,
    driver_name         TEXT,
    driver_rating       NUMERIC,
    departure_date      TEXT,
    departure_time      TEXT,
    seat_class          TEXT,
    seats_booked        INTEGER,
    fare_per_seat       TEXT,
    total_fare          TEXT,
    payment_method      TEXT,
    booking_status      TEXT,
    trip_rating         NUMERIC
);

--confirm the table exists
select * from safariconnect.safari_connect_clean;

--inspect passenger name
SELECT
    booking_id,
    passenger_name
FROM safariconnect.safari_connect_dirty
WHERE passenger_name <> INITCAP(TRIM(passenger_name));

--update passenger name
UPDATE safariconnect.safari_connect_dirty
SET passenger_name = INITCAP(TRIM(passenger_name))
WHERE passenger_name <> INITCAP(TRIM(passenger_name));

--inspect phone numbers

SELECT
    booking_id,
    passenger_phone
FROM safariconnect.safari_connect_dirty
WHERE passenger_phone IS NULL
   OR TRIM(passenger_phone) = ''
   OR passenger_phone LIKE '%-%'
   OR passenger_phone LIKE '+254%';

--update phone_numbers

  UPDATE safariconnect.safari_connect_dirty
SET passenger_phone =
    REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g')
WHERE passenger_phone IS NOT NULL;

--convert the +254

SELECT
    booking_id,
    passenger_phone
FROM safariconnect.safari_connect_dirty
WHERE passenger_phone LIKE '254%';

--update +254 numbers to remove it
UPDATE safariconnect.safari_connect_dirty
SET passenger_phone = '0' || SUBSTRING(passenger_phone FROM 4)
WHERE passenger_phone LIKE '254%';

--empty phones to NULL
SELECT
    booking_id,
    passenger_phone
FROM safariconnect.safari_connect_dirty
WHERE passenger_phone IS NULL
   OR TRIM(passenger_phone) = '';

 --clean gender, inspect
   SELECT
    passenger_gender,
    COUNT(*) AS records
FROM safariconnect.safari_connect_dirty
GROUP BY passenger_gender
ORDER BY passenger_gender;

---update
UPDATE safariconnect.safari_connect_dirty
SET passenger_gender =
    CASE
        WHEN LOWER(TRIM(passenger_gender)) IN ('male', 'm')
            THEN 'Male'
        WHEN LOWER(TRIM(passenger_gender)) IN ('female', 'f')
            THEN 'Female'
        ELSE NULL
    END;

--clean passenger_city, inspect
	
	SELECT
    booking_id,
    passenger_city
FROM safariconnect.safari_connect_dirty
WHERE passenger_city IS NULL
   OR passenger_city <> INITCAP(TRIM(passenger_city));
   
   --update passenger_city
UPDATE safariconnect.safari_connect_dirty
SET passenger_city =
    CASE
        WHEN passenger_city IS NULL
          OR TRIM(passenger_city) = ''
        THEN 'Unknown'
        ELSE INITCAP(TRIM(passenger_city))
    END;
   
 --clean amounts
	SELECT
    booking_id,
    total_fare,
    REGEXP_REPLACE(total_fare, '[^0-9.]', '', 'g')::NUMERIC
        AS cleaned_total_fare
FROM safariconnect.safari_connect_dirty;

--clean seat_class

UPDATE safariconnect.safari_connect_dirty
SET seat_class =
    CASE
        WHEN LOWER(TRIM(seat_class)) IN ('economy', 'eco', 'economy class') THEN 'Economy'
        WHEN LOWER(TRIM(seat_class)) IN ('business', 'bus', 'business class') THEN 'Business'
        ELSE seat_class  -- Keep unchanged
    end;
--clean payment_method
	
UPDATE safariconnect.safari_connect_dirty
SET payment_method =
    CASE
        WHEN LOWER(TRIM(payment_method))
             IN ('mpesa', 'm-pesa')
            THEN 'M-Pesa'

        WHEN LOWER(TRIM(payment_method)) = 'cash'
            THEN 'Cash'

        WHEN LOWER(TRIM(payment_method)) = 'card'
            THEN 'Card'

        ELSE payment_method
    END;  
        
--clean departure date
update safariconnect.safari_connect_dirty
set departure_date =
 CASE
        WHEN departure_date LIKE '%/%'  THEN TO_DATE(departure_date, 'DD/MM/YYYY')
        WHEN departure_date ~ '^\d{4}-' THEN TO_DATE(departure_date, 'YYYY-MM-DD')
        WHEN LENGTH(departure_date) = 8 THEN TO_DATE(departure_date, 'DD-MM-YY')
        WHEN LENGTH(departure_date) = 10 THEN TO_DATE(departure_date, 'MM-DD-YYYY')
        ELSE NULL
    END;       
        
        
        
--clean booking status
        
update safariconnect.safari_connect_dirty
set booking_status = (
case
when initcap(trim(booking_status)) = 'Completed' then 'Completed'
when initcap(trim(booking_status)) = 'No Show' then 'No Show'
when initcap(trim(booking_status)) = 'Cancelled' then 'Cancelled'
else booking_status
end
)
where booking_status is not null;        
    
        
        select *
        from safariconnect.safari_connect_dirty;
        
--clean driver_name, inspect
	
	SELECT
    booking_id,
    driver_name
FROM safariconnect.safari_connect_dirty
WHERE driver_name <> INITCAP(TRIM(driver_name));

UPDATE safariconnect.safari_connect_dirty
SET driver_name = INITCAP(TRIM(driver_name))
WHERE driver_name <> INITCAP(TRIM(driver_name));

--clean vehicle_type
--clean vehicle_type

UPDATE safariconnect.safari_connect_dirty
SET vehicle_type = INITCAP(TRIM(vehicle_type));

--clean seats booked

 SELECT *
FROM safariconnect.safari_connect_dirty
WHERE seats_booked = 0;

--delete duplicate booking_id, identify, inspect, delete
SELECT
    booking_id,
    COUNT(*) AS duplicate_count
FROM safariconnect.safari_connect_dirty
GROUP BY booking_id
HAVING COUNT(*) > 1;

SELECT *
FROM safariconnect.safari_connect_dirty
WHERE booking_id = 'BK0005';

DELETE FROM safariconnect.safari_connect_dirty a
USING safariconnect.safari_connect_dirty b
WHERE a.booking_id = b.booking_id
  AND a.ctid > b.ctid;


select distinct booking_id
from safariconnect.safari_connect_dirty
order by booking_id;

--fix invalid trip_rating, inspect

SELECT
    booking_id,
    trip_rating
FROM safariconnect.safari_connect_dirty
WHERE trip_rating IS NOT NULL
  AND trip_rating NOT BETWEEN 1 AND 5;
  
UPDATE safariconnect.safari_connect_dirty
SET trip_rating = NULL
WHERE trip_rating IS NOT NULL
  AND trip_rating NOT BETWEEN 1 AND 5;

--validate the data
SELECT *
FROM safariconnect.safari_connect_dirty;

--check invalid ratings
SELECT *
from safariconnect.safari_connect_dirty
WHERE trip_rating IS NOT NULL
AND trip_rating NOT BETWEEN 1 AND 5;


CREATE TABLE safariconnect.clean_bookings AS
SELECT
TRIM(booking_id) AS booking_id,
INITCAP(TRIM(passenger_name)) AS passenger_name,
CASE
WHEN passenger_phone IS NULL OR TRIM(passenger_phone) = '' THEN NULL
WHEN REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g') LIKE '254%'
THEN '0' || SUBSTRING(REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g') FROM 4)
ELSE REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g')
END AS passenger_phone,
passenger_gender,
COALESCE(INITCAP(TRIM(passenger_city)), 'Unknown') AS passenger_city,
route_code,
INITCAP(TRIM(route_from)) AS route_from,
INITCAP(TRIM(route_to)) AS route_to,
vehicle_plate,
INITCAP(TRIM(vehicle_type)) AS vehicle_type,
INITCAP(TRIM(driver_name)) AS driver_name,
driver_rating,
CASE
WHEN departure_date ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(departure_date, 'YYYY-MM-DD')
WHEN departure_date ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(departure_date, 'DD/MM/YYYY')
WHEN departure_date ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(departure_date, 'MM-DD-YYYY')
WHEN departure_date ~ '^\d{2}-\d{2}-\d{2}$' THEN TO_DATE(departure_date, 'DD-MM-YY')
ELSE NULL
END AS departure_date,
departure_time,
seat_class,
seats_booked,
CASE
WHEN REGEXP_REPLACE(fare_per_seat, '[^0-9.]', '', 'g') ~ '^[0-9.]+$'
AND REGEXP_REPLACE(fare_per_seat, '[^0-9.]', '', 'g') != ''
THEN REGEXP_REPLACE(fare_per_seat, '[^0-9.]', '', 'g')::NUMERIC
ELSE NULL
END AS fare_per_seat,
CASE
WHEN REGEXP_REPLACE(total_fare, '[^0-9.]', '', 'g') ~ '^[0-9.]+$'
AND REGEXP_REPLACE(total_fare, '[^0-9.]', '', 'g') != ''
THEN REGEXP_REPLACE(total_fare, '[^0-9.]', '', 'g')::NUMERIC
ELSE NULL
END AS total_fare,
payment_method,
booking_status,
trip_rating
FROM safariconnect.safari_connect_dirty;
 
select * FROM safariconnect.safari_connect_dirty;

select * from safariconnect.clean_bookings;


1--Route Analysis Which routes earn the most? 
--Which are most popular? 
--Which is most efficient per seat sold?
--Specific route codes with KES figures. A clear top route and a clear underperformer.
SELECT
    route_code,
    COUNT(*) AS total_bookings,
    SUM(seats_booked) AS total_seats_sold,
    SUM(total_fare) AS total_revenue_kes,
    ROUND(
        SUM(total_fare) / NULLIF(SUM(seats_booked), 0),
        2
    ) AS revenue_per_seat_kes
FROM safariconnect.clean_bookings
WHERE booking_status = 'Completed'
GROUP BY route_code
ORDER BY total_revenue_kes DESC;

CREATE OR REPLACE VIEW safariconnect.v_clean_trips AS
SELECT
*,
seats_booked * fare_per_seat AS calculated_fare,
CASE
WHEN booking_status = 'Completed' THEN total_fare
ELSE 0
END AS realised_revenue,
CASE
WHEN booking_status = 'Cancelled' THEN total_fare
ELSE 0
END AS cancelled_revenue
FROM safariconnect.clean_bookings;

select * from safariconnect.clean_bookings cb; 

select* from safariconnect.v_clean_trips;

