POETRY_RUN := poetry run

docker_image := pumpkin
reqs := requirements.txt requirements-dev.txt

.PHONY: all
all: clean install

# Virtual environments
.make.install.prod: poetry.lock
	poetry install --no-dev
	rm -f .make.install.*
	touch $@

.make.install.dev: poetry.lock
	poetry install
	rm -f .make.install.*
	touch $@

.PHONY: install
install: .make.install.prod

.PHONY: install-dev
install-dev: .make.install.dev

# Virtual Environment
poetry.lock: pyproject.toml
	poetry lock
	touch $@

requirements.txt: poetry.lock
	poetry export --without-hashes -f requirements.txt -o $@

requirements-dev.txt: poetry.lock
	poetry export --dev --without-hashes -f requirements.txt -o $@

.PHONY: requirements
requirements: $(reqs)

# Docker
.PHONY: docker-image
docker-image:
	docker build \
		-t $(docker_image) \
		--build-arg USER_ID=$$(id -u) \
		--build-arg GROUP_ID=$$(id -g) \
		.

# Testing
.PHONY: tests
tests: test-lint test-spelling

.PHONY: test-lint
test-lint: | .make.install.dev
	$(POETRY_RUN) flake8 pumpkin

.PHONY: test-spelling
test-spelling:
	bin/test-spelling

# Utility
.PHONY: clean
clean:
	find . | grep __pycache__ | xargs rm -rf
	rm -f .make.*
