WITH customers AS (

	SELECT 
			cc_num,
	        first_name,
	        last_name,
	        gender,
	        dob,
	        job,
	        row_number() OVER (PARTITION BY cc_num ORDER BY trans_date_trans_time desc) AS row_num
	FROM {{ ref('int_transactions_clean')}}
),

deduped AS (
	SELECT *
	FROM customers
	WHERE row_num = 1
)

SELECT 
	{{ dbt_utils.generate_surrogate_key(['cc_num'])}} AS customer_key,
	cc_num,
    first_name,
    last_name,
    gender,
    dob,
    job
FROM deduped