from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
import requests
from datetime import timedelta


# DAG Arguments
ARGS = {
    "owner": "Airflow",
    "start_date": days_ago(1),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

# DAG Definition
dag = DAG(
    dag_id="poc_test",
    default_args=ARGS,
    description="Run DBT Model via DBT RPC",
    schedule_interval=None,  # Set to None for manual trigger
)

def test_dbt_connection():
    dbt_url = 'http://172.22.0.2:8580/jsonrpc'
    try:
        response = requests.get(dbt_url)
        response.raise_for_status()
        print("DBT Docker connection successful")
    except requests.exceptions.RequestException as e:
        print(f"Error connecting to DBT Docker: {e}")

# Define your task
test_connection_task = PythonOperator(
    task_id='test_dbt_connection',
    python_callable=test_dbt_connection,
    dag=dag
)

# Task Order
test_connection_task
