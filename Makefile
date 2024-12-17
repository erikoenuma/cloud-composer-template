PROJECT_NAME ?= some-project

.PHONY: gcloud-set-credentials
gcloud-set-credentials:
	gcloud config set project $(PROJECT_NAME)
	gcloud auth application-default login \
	--scopes="https://www.googleapis.com/auth/drive","https://www.googleapis.com/auth/cloud-platform"

# Local Composer
.PHONY: setup-local-env
setup-local-env:
	chmod +x scripts/setup.sh && scripts/setup.sh

.PHONY: start-composer
start-composer:
	cd composer-local-dev && composer-dev start

.PHONY: stop-composer
stop-composer:
	cd composer-local-dev && composer-dev stop

# Dev Composer
# ローカルのcomposer環境をdev環境にデプロイする
.PHONY: deploy-composer-dev
deploy-composer-dev:
	gcloud builds submit --config cloud-build/deploy-composer.cloudbuild.yaml

# dev環境で使用しているAirflowの変数を取得
.PHONY: get_airflow_variables_dev
get_airflow_variables_dev:
	gcloud secrets versions access latest --secret=composer-airflow-variables --project=$(PROJECT_NAME) > airflow-variables.json

# Local Test
.PHONY: test-dags
test-dags:
	docker build -t airflow-test-image . && \
	docker run --rm airflow-test-image pytest -s dags/tests 

# Terraform
.PHONY: terraform-init-dev
terraform-init-dev:
	cd terraform/envs/development && \
	../../bin/terraform.sh init

.PHONY: terraform-plan-dev
terraform-plan-dev:
	python scripts/generate_pypi_packages.py > terraform/envs/development/pypi_packages.tfvars && \
	cd terraform/envs/development && \
	../../bin/terraform.sh plan -var-file=pypi_packages.tfvars

.PHONY: terraform-apply-dev
terraform-apply-dev:
	python scripts/generate_pypi_packages.py > terraform/envs/development/pypi_packages.tfvars && \
	cd terraform/envs/development && \
	../../bin/terraform.sh apply -var-file=pypi_packages.tfvars

.PHONY: terraform-destroy-dev
terraform-destroy-dev:
	cd terraform/envs/development && \
	../../bin/terraform.sh destroy -target=module.cloud-composer.google_composer_environment.composer_env

.PHONY: terraform-init-production
terraform-init-production:
	cd terraform/envs/production && \
	../../bin/terraform.sh init

.PHONY: terraform-plan-production
terraform-plan-production:
	python scripts/generate_pypi_packages.py > terraform/envs/production/pypi_packages.tfvars && \
	cd terraform/envs/production && \
	../../bin/terraform.sh plan -var-file=pypi_packages.tfvars

.PHONY: terraform-apply-production
terraform-apply-production:
	python scripts/generate_pypi_packages.py > terraform/envs/production/pypi_packages.tfvars && \
	cd terraform/envs/production && \
	../../bin/terraform.sh apply -var-file=pypi_packages.tfvars
