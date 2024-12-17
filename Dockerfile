FROM python:3.11-slim

# Install dependencies
COPY requirements.txt /app/requirements.txt
COPY requirements-test.txt /app/requirements-test.txt
ARG AIRFLOW_VERSION=2.9.3
ARG PYTHON_VERSION=3.11
# $PYTHON_VERSIONをしようすると3.11.10と解釈されてしまうので、直接指定しています
ARG CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-3.11.txt"
# RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt -c ${CONSTRAINT_URL}
RUN pip install -r /app/requirements-test.txt -c ${CONSTRAINT_URL}

# Set environment variables
ENV AIRFLOW_HOME=/app/airflow_home
ENV PYTHONPATH=/app:/app/dags:/app/dags/lib:/app/dags/config

# Initialize Airflow environment
RUN mkdir -p $AIRFLOW_HOME
RUN airflow db init
RUN airflow users create \
  --username admin \
  --firstname Admin \
  --lastname User \
  --role Admin \
  --email admin@example.com \
  --password admin

COPY dags /app/dags
COPY dags/tests /app/dags/tests

WORKDIR /app
