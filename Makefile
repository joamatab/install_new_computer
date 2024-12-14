uv:
	curl -LsSf https://astral.sh/uv/0.4.30/install.sh | sh

install:
	uv venv --python 3.11
	uv sync --extra docs --extra dev

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
	pre-commit autoupdate

git-rm-merged:
	git branch -D `git branch --merged | grep -v \* | xargs`

build:
	rm -rf dist
	pip install build
	python -m build

ssh:
	git remote remove origin
	git remote add origin git@github.com:joamatab/install_new_computer.git
	git push --set-upstream origin main

docs:
	uv run jb build docs

.PHONY: drc doc docs
