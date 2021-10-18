.PHONY: all
all: clean install

poetry.lock: pyproject.toml
	poetry lock
	touch $@

requirements.txt: poetry.lock
	poetry export --without-hashes -f requirements.txt -o $@

.make.install: poetry.lock
	poetry install
	touch $@

.PHONY: install
install: .make.install

.PHONY: clean
clean:
	find . | grep __pycache__ | xargs rm -rf
	rm -f .make.install
