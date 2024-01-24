--Not working

{{
    config(
        materialized = 'incremental',
        unique_key = 'Clientid',
        incremental_strategy = 'merge',
        schema = 'ods'
    )
}}

insert into {{ this }}
(
    ClientID,
    SubsidiaryId,
    MerchantTerminalID,
)
select
    ClientID,
    SubsidiaryId,
    MerchantTerminalID,
from {{ source('ods','Clients') }}
on duplicate key update
    SubsidiaryId = values(SubsidiaryId),
    MerchantTerminalID = values(MerchantTerminalID),

