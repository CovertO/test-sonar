SHELL := /bin/bash

.PHONY: help
help: ## Display this help text
	@echo 'Perform common development tasks.'
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

.PHONY: deps
deps: ## Installs dependencies
	go mod tidy
	go mod vendor

.PHONY: deps-upgrade
deps-upgrade: ## Installs/upgrades all dependencies
	go get -u -t -d -v ./...
	go mod tidy
	go mod vendor

.PHONY: test
test: ## Generates test coverage reports
	./build/run.sh "./build/test.sh"

.PHONY: generate-test-coverage
generate-test-coverage: ## Generates test coverage reports
	./build/run.sh "./build/generate-test-coverage.sh"

