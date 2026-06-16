
select
	dc.customer_key,
	coalesce(dm.merchant_key, {{dbt_utils.generate_surrogate_key(['-1'])}}) as merchant_key,
	dl.location_key,
	dd.date_key,
	itc.trans_num,
	itc.trans_date_trans_time,
	itc.amt,
	itc.distance_between_cus_merch_km,
	itc.is_fraud
from
	{{ref('int_transactions_clean')}} AS itc
left join {{ref('dim_customers')}} dc
on
	dc.cc_num = itc.cc_num
left join {{ref('dim_merchants')}} dm
on
	dm.merchant_name = itc.merchant_name
left join {{ref('dim_locations')}} dl
on
	dl.zip = itc.zip
left join{{ref('dim_date')}} dd
on
	dd.full_date = itc.trans_date_trans_time::date

	
	
	
