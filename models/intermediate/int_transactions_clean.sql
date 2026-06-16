{{ config( materialized= 'table')}}


SELECT 
	trans_date_trans_time,
	cc_num,
	merchant_name,
	case when category = '' then 'unknown'
		when lower(category) = 'other' then 'unknown'
		when lower(category) = 'n/a' then 'unknown'
		when lower(category) = 'invalid' then 'unknown'
		 else category
	end category,
	amt,
	first_name,
	last_name,
	gender,
	street,
	city,
	state,
	zip,
	latitude,
	longitude ,
	city_pop,
	dob,
	job,
	to_char(trans_date_trans_time, 'FMDay') as trans_day_of_week,
	date_part('year',age(trans_date_trans_time, dob)) as customer_age,
	trans_num,
	unix_time,
	merchant_latitude,
	merchant_longitude,
	{{ haversine_km('latitude', 'longitude', 'merchant_latitude', 'merchant_longitude') }} as distance_between_cus_merch_km,
	is_fraud,
	dwh_create_date 
from {{ ref('int_transactions_validated') }}
WHERE is_valid

