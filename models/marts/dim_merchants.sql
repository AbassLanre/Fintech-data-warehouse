
select 
    {{ dbt_utils.generate_surrogate_key(['-1'])}}  as merchant_key,
    'UNKNOWN'                                as merchant_id,
    'UNKNOWN'                                as merchant_name,
    'UNKNOWN'                                as category,
    'UNKNOWN'                                as merchant_tier,
    'UNKNOWN'                                as country,
    'UNKNOWN'                                as city,
    0::numeric(19,4)                         as commission_rate,
    false                                    as is_online,
    0                                        as founded_year,
    false                                    as is_active

union all

select 
{{ dbt_utils.generate_surrogate_key(['merchant_id'])}} as merchant_key,
merchant_id,
merchant_name, 
category, 
merchant_tier, 
country, 
city, 
commission_rate,
is_online, 
founded_year, 
is_active
from {{ref('merchants')}}
where merchant_id != 'UNKNOWN'
