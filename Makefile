.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: build
build: ## Builds the base image for running the container in dev mode (required after adding dependencies to requirements.txt)
	docker compose build

.PHONY: dev
dev: ## Run the development environment in a container on http://localhost:8080
	docker compose up
