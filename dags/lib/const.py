from airflow.models import Variable

IS_DEV = Variable.get("PROJECT_ID") == "dev-projec-name"

# pubsub系
TRIGGER_DAG_FROM_PUBSUB_DAG_ID = "trigger_dag_from_pubsub"
TRIGGER_DAG_TOPIC = "trigger-dag-topic"
TRIGGER_DAG_SUBSCRIPTION_NAME = "trigger-dag-topic-sub"
