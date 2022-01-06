POETRY_RUN := poetry run
docker_image := pumpkin


.PHONY: all
all: clean install

# Installation
.make.install: poetry.lock
	poetry install
	touch $@

.PHONY: install
install: .make.install

# Virtual Environment
poetry.lock: pyproject.toml
	poetry lock
	touch $@

requirements.txt: poetry.lock
	poetry export --without-hashes -f requirements.txt -o $@

# Docker
.PHONY: docker-image
docker-image:
	docker build \
		-t $(docker_image) \
		--build-arg USER_ID=$$(id -u) \
		--build-arg GROUP_ID=$$(id -g) \
		.

# Testing
.PHONY: test-lint
test-lint:
	$(POETRY_RUN) flake8 pumpkin

# Utility
.PHONY: clean
clean:
	find . | grep __pycache__ | xargs rm -rf
	rm -f .make.install
