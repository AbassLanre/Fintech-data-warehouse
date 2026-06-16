{{ config( materialized= 'table')}}


SELECT 
	*
from {{ ref('int_transactions_validated') }}
WHERE NOT is_valid





