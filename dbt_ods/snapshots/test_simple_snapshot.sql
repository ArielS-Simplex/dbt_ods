{% snapshot test_simple_snapshot %}

    {{
        config(
            target_schema='ods',
            unique_key='Clientid',
            strategy='timestamp',
            updated_at='RowCreated',
            shard_key=['Clientid']
        )
    }}

    SELECT
        Clientid,
        RowCreated
    FROM
        ods.Clients

{% endsnapshot %}
