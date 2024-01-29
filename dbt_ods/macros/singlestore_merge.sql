{% macro singlestore_merge() %}

INSERT INTO `ods`.`Ariel_DWH_DimClients` (ClientID)
SELECT ClientID
FROM `ods`.`Clients`
ON DUPLICATE KEY UPDATE
    ClientID = VALUES(ClientID);

{% endmacro %}
