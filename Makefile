#!make

# Git
REPO=gcp-data-engineering-terraform

# Google Cloud
GCP-PROJECT-NAME=gcp-data-engineering
GCP-PROJECT-ID=gcp-data-engineering-289509
CONFIG-NAME=gcp-data-engineering-terraform
ACCOUNT=${GCP-DATA-ENGINEERING-ACCOUNT}

# Environment
ENV=local

# Terraform
TERRAFORM_ROOT_LOCATION=terraform/

help:
	@echo =====================
	@echo GCP Terraform Repo
	@echo =====================
	@echo
	@echo Setting Up
	@echo ---------------------
	@echo 1. make setup
	@echo ---------------------
	@echo =====================

setup:
	@echo Manage Brew Bundle
	make brew

brew:
	. ./brew_manager.sh

gcp/create-config:
	@echo Creating new config
	gcloud config configurations create ${CONFIG-NAME}
	@echo Setting Project ID
	gcloud config set project ${GCP-PROJECT-ID}
	@echo Setting Account
	gcloud config set account jack.dyer.per@gmail.com
	@echo Setting Compute Region
	gcloud config set compute/region europe-west2
	@echo Setting Compute Zone
	gcloud config set compute/zone europe-west2-b


gcp/auth:
	@echo Activating Config
	gcloud config configurations activate ${CONFIG-NAME}
	@echo Sending to browser for authentication
	gcloud auth ${CONFIG-NAME} login

tf/init:
	@echo Initializing Terraform
	cd ${TERRAFORM_ROOT_LOCATION} && terraform init

tf/plan-to-file:
	@echo Planning Terraform to file
	cd ${TERRAFORM_ROOT_LOCATION} && terraform plan -out=terraform.plan

tf/apply-from-file:
	cd ${TERRAFORM_ROOT_LOCATION} && terraform apply terraform.plan

