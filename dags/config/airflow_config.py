from datetime import datetime, timedelta
from airflow.providers.slack.operators.slack import SlackAPIPostOperator
from config.slack_config import SlackConfig


class AirflowConfig:

    @staticmethod
    def get_default_args():
        return {
            "owner": "eri koenuma",
            "email_on_failure": False,
            "email_on_retry": False,
            "start_date": datetime(2024, 4, 1),
            "retries": 4,
            "retry_delay": timedelta(minutes=5),
            "on_failure_callback": AirflowConfig.on_failure_callback,
            "execution_timeout": timedelta(hours=3),
        }

    @staticmethod
    def on_failure_callback(context):
        operator = SlackAPIPostOperator(
            slack_conn_id="slack",
            task_id="failure",
            text="",
            attachments=[
                {
                    "title": "🚨 Failed: Dag execution failed.",
                    "text": f"Task: {context.get('task_instance').task_id}\n"
                    f"Dag: {context.get('task_instance').dag_id}\n"
                    f"Execution Time: {context.get('execution_date')}\n",
                    "color": "danger",
                }
            ],
            channel=SlackConfig.get_channel(
                SlackConfig.Channel.DEV_NOTIFICATION
            ),
        )

        return operator.execute(context=context)
