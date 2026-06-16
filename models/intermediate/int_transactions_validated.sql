with ranked as (

    select
        *,
        row_number() over (
            partition by trans_num
            order by trans_date_trans_time desc
        ) as dedup_rank
    from {{ ref('stg_sparkov_transactions') }}

)

select
    *,
    (trans_num is null)                              as is_null_trans_num,
    (dedup_rank > 1)                                 as is_duplicate_trans_num,
    (trans_date_trans_time is null)                  as is_null_trans_date,
    (merchant_name is null)                          as is_null_merchant,
    (job is null)                                    as is_null_job,
    (amt is null or amt < 0.01 or amt > 1000000)     as is_amt_out_of_range,

    not (
        trans_num is null
        or dedup_rank > 1
        or trans_date_trans_time is null
        or merchant_name is null
        or job is null
        or amt is null or amt < 0.01 or amt > 1000000
    ) as is_valid

from ranked