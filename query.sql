select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status,
from bookings as b
inner join users as u
on b.user_id = u.user_id
inner join vehicles as v
on b.vehicle_id = v.vehicle_id


select *
from vehicles v
where not exists(
  select * from bookings b where b.vehicle_id = v.vehicle_id
  )


  
select * from vehicles where type ='car'




SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN vehicles v
    ON b.vehicle_id = v.vehicle_id
GROUP BY
    v.vehicle_id, v.name
HAVING
    COUNT(b.booking_id) >2;
