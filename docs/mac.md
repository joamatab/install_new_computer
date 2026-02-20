# Mac requirements

Type this into a terminal:

```
xcode-select --install
```

Install [uv](https://docs.astral.sh/uv/):

```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Install `inc`:

```
uv tool install inc
```

Alternatively, for developers:

```
git clone https://github.com/joamatab/install_new_computer.git
cd install_new_computer
uv sync
```
