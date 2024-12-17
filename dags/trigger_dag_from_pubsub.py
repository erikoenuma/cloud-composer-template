# https://airflow.apache.org/docs/apache-airflow-providers-google/stable/operators/cloud/pubsub.html#creating-a-pubsub-subscription
# https://airflow.apache.org/docs/apache-airflow-providers-google/stable/operators/cloud/pubsub.html#pulling-messages-from-a-pubsub-subscription
import json
import base64
from airflow import DAG
from airflow.models import Variable
from airflow.operators.python import PythonOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.contrib.operators.pubsub_operator import (
    PubSubCreateSubscriptionOperator,
)
from airflow.utils.dates import days_ago
from airflow.contrib.sensors.pubsub_sensor import PubSubPullSensor

from lib.const import (
    TRIGGER_DAG_FROM_PUBSUB_DAG_ID,
    TRIGGER_DAG_SUBSCRIPTION_NAME,
    TRIGGER_DAG_TOPIC,
)

PROJECT_ID = Variable.get("PROJECT_ID")


def process_message(**context):
    message = context["ti"].xcom_pull(task_ids="wait_for_pubsub_message")

    if message:
        base64_data = message[0]["message"]["data"]
        decoded_data = base64.b64decode(base64_data).decode("utf-8")
        json_data = json.loads(decoded_data)

        expanded_data = {key: json_data.get(key, "") for key in json_data}
        return json.dumps(expanded_data)
    else:
        return json.dumps({})


def fetch_dag_id(**context):
    message = context["ti"].xcom_pull(task_ids="process_message")
    _json = json.loads(message)

    return _json.get("dag_id", "")


with DAG(
    TRIGGER_DAG_FROM_PUBSUB_DAG_ID,
    start_date=days_ago(1),
    schedule="*/1 * * * *",
    catchup=False,
) as dag:

    subscribe_task = PubSubCreateSubscriptionOperator(
        task_id="subscribe_task",
        project_id=PROJECT_ID,
        topic=TRIGGER_DAG_TOPIC,
        subscription=TRIGGER_DAG_SUBSCRIPTION_NAME,
    )

    subscription = subscribe_task.output

    wait_for_message = PubSubPullSensor(
        task_id="wait_for_pubsub_message",
        project_id=PROJECT_ID,
        subscription=TRIGGER_DAG_SUBSCRIPTION_NAME,
        ack_messages=True,
    )

    process_message_task = PythonOperator(
        task_id="process_message", python_callable=process_message
    )

    fetch_dag_id_task = PythonOperator(
        task_id="fetch_dag_id", python_callable=fetch_dag_id
    )

    trigger_dag_task = TriggerDagRunOperator(
        task_id="trigger_dag",
        trigger_dag_id="{{ task_instance.xcom_pull(task_ids='fetch_dag_id') }}",
        wait_for_completion=False,
        conf="{{ task_instance.xcom_pull(task_ids='process_message') }}",
    )

    (wait_for_message >> process_message_task >> fetch_dag_id_task >> trigger_dag_task)
