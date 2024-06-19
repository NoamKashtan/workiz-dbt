with source_data as (

SELECT id,
       account_id,
       address,
       city,
       state,
       country,
       zip,
       expire_date,
       four_digits,
       csv,
       anet_customerProfileId,
       anet_customerPaymentProfileId,
       card_type,
       card_holder_first,
       card_holder_last,
       stripe_customer_id,
       cast(extra_balance as string) as extra_balance,
       TO_JSON_STRING(balance_by_type) as balance_by_type,
       updated
from {{ source('workiz_general', 'account_billing_profile') }}  

) 

select * from source_data