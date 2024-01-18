{{
    config(materialized='incremental',
     unique_key='Clientid',
    schema='ods')
}}

SELECT MultiClientID, Clientid, ClientName
FROM {{ source('ods','Clients') }}
