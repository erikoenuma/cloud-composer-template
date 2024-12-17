# 全てのdagに対する共通のテストを行います
from unittest.mock import MagicMock, patch


@patch("google.auth.default", return_value=(MagicMock(), "test-project"))
def test_dag_validated(dagbag):
    for dag_id in dagbag.dag_ids:
        dag = dagbag.get_dag(dag_id)
        assert dag is not None, f"DAG {dag_id} is not loaded"
        assert len(dag.tasks) > 0, f"DAG {dag_id} has no tasks"
        assert dagbag.import_errors == {}, f"DAG {dag_id} has import errors"
        assert dag.dagrun_timeout is not None, f"DAG {dag_id} has no dagrun timeout"
        assert dag.catchup is False, f"DAG {dag_id} has incorrect catchup setting"
