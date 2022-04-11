/* 
Chapter 11 Exercises 
by: Tim Lupien 
*/

 --Question 1
SELECT vendor_id,
    passenger_count,
    trip_distance,
    total_amount,
    tpep_dropoff_datetime - tpep_pickup_datetime AS trip_duration
FROM taxis
ORDER BY trip_duration DESC;

/*
All of the results at the top of this query have absurd durations near a full
day. Upon further inspection, this problem appears unique to vendor_id 2,
which I confirmed via the query below.
*/


SELECT vendor_id,
    passenger_count,
    trip_distance,
    total_amount,
    tpep_dropoff_datetime - tpep_pickup_datetime AS trip_duration
FROM taxis
WHERE vendor_id != '2'
ORDER BY trip_duration DESC;

/*
Based on this, I strongly suspect vendor_id 2 is recording pickup and drop-off
times in the opposite columns and that perhaps some constraint is adjusting the
the drop-off times to be the next day so that they are not actually before the
pick-up times. Regardless, vendor_id 2 needs to be investigated.
*/

--Question 3
SELECT corr(total_amount, (
	date_part('hour',(tpep_dropoff_datetime - tpep_pickup_datetime)) * 60 * 60
	+ date_part('minute',(tpep_dropoff_datetime - tpep_pickup_datetime)) * 60
	+ date_part('seconds',(tpep_dropoff_datetime - tpep_pickup_datetime))
	))::numeric(4,3) AS amount_by_duration_corr,
	corr(total_amount, trip_distance)::numeric(4,3) AS amount_by_distance_corr
FROM taxis;

/*
It would appear taxi fares are based on distance.
This matches expectations. See https://www.estimate.taxi/rates/united-states/new-york
*/