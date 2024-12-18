# Define variables for paths
REST_API_PATH = packages/rest_api

# Default target
.PHONY: all
all: help

# Prepare all commands
.PHONY: prepare
prepare: clean build-runner build-runner-rest-api
	@echo "Project preparation completed."

# Flutter clean
.PHONY: clean
clean:
	flutter clean
	@echo "Flutter clean completed."

# Flutter build runner (root project)
.PHONY: build-runner
build-runner:
	dart run build_runner build --delete-conflicting-outputs
	@echo "Build runner completed for the main project."

# Flutter build runner for the REST API package
.PHONY: build-runner-rest-api
build-runner-rest-api:
	cd $(REST_API_PATH) && dart run build_runner build --delete-conflicting-outputs
	@echo "Build runner completed for the REST API package."

# Help
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make prepare                - Run all commands to prepare the project"
	@echo "  make clean                  - Run 'flutter clean'"
	@echo "  make build-runner           - Run 'flutter build_runner' for the main project"
	@echo "  make build-runner-rest-api  - Run 'flutter build_runner' for the REST API package"
