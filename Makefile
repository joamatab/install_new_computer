install: software prettier

time:
	sudo timedatectl set-timezone America/Los_Angeles

software:
	./colors.sh
	./autojump.sh
	./lf.sh
	./vim.sh
	./rbenv.sh
	./fish.sh
	yarn add prettier --dev --exact

conda:
	./conda.sh

pyenv:
	./pyenv.sh

pipx:
	./pipx.sh
	./vf.sh

pre-commit:
	pre-commit install

rust:
	./rust.sh

git_key:
	./git_key.sh

git_config:
	./git_config.sh

sshd:
	sudo systemctl enable sshd
	sudo systemctl start sshd

fx:
	npm -f install fx

handlr:
	cargo install handlr

yarn:
	./yarn.sh
