

WITH locations AS (
	SELECT 
		*,
		row_number() OVER (PARTITION BY zip ORDER BY city desc) AS row_num
	FROM {{ref('int_transactions_clean')}}
		
)

select 
	{{dbt_utils.generate_surrogate_key(['zip'])}} AS location_key,
	city,
	state ,
	zip,
	city_pop
from locations
where row_num =1


