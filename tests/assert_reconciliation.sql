

with counts as (
    select
        (select count(*) from {{ ref('int_transactions_clean') }})     as clean_n,
        (select count(*) from {{ ref('int_transactions_rejected') }})  as rejected_n,
        (select count(*) from {{ ref('int_transactions_validated') }}) as validated_n
)
select *
from counts
where clean_n + rejected_n != validated_n 
