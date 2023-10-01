install:
	pip install -e .[dev]
	pre-commit install

dev:
	pip install -e .[dev,docs]

test:
	pytest -s

cov:
	pytest --cov=inc

mypy:
	mypy . --ignore-missing-imports

git-rm-merged:
	git branch -D `git branch --merged | grep -v \* | xargs`


update-pre:
	pre-commit autoupdate --bleeding-edge

git-rm-merged:
	git branch -D `git branch --merged | grep -v \* | xargs`

build:
	rm -rf dist
	pip install build
	python -m build

docs:
	jb build docs

.PHONY: drc doc docs
