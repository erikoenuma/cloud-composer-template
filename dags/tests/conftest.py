import pytest
from unittest.mock import patch
from airflow.models import DagBag


# 環境変数をモックする
# https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html#mocking-variables-and-connections
@pytest.fixture(scope="session", autouse=True)
def set_variables():
    with patch.dict(
        "os.environ",
        {"AIRFLOW_VAR_PROJECT_ID": "test-project"},
    ):
        yield


@pytest.fixture(scope="session", autouse=True)
def dagbag(set_variables):
    # dagを読み込む際にエラーが出るのでpatchしています
    with patch("google.cloud.storage.Client", autospec=True):
        return DagBag(dag_folder="dags", include_examples=False)
