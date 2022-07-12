mkdir -p ~/.local/venv && cd ~/.local/venv
python3 -m venv nvim
cd nvim
. ./bin/activate
pip install pynvim black
