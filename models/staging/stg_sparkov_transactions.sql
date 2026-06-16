
SELECT 
trans_date_trans_time,
cc_num,
merchant AS merchant_name,
category,
amt,
"first" AS first_name,
"last" AS last_name,
gender,
street,
city,
state,
zip,
lat AS latitude,
long AS longitude,
city_pop,
job,
dob,
trans_num,
unix_time,
merch_lat AS merchant_latitude,
merch_long AS merchant_longitude,
is_fraud,
dwh_create_date

from {{ source('bronze', 'sparkov_fraud_test') }}