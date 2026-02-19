install:
	uv venv --python 3.12
	uv sync --extra docs --extra dev

dev:
	uv sync --extra docs --extra dev

test-mac:
	uv run inc run install_new_mac

git-rm-merged:
	git branch -D `git branch --merged | grep -v \* | xargs`

update-pre:
	pre-commit autoupdate

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
