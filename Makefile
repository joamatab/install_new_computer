install: software prettier

time:
	sudo timedatectl set-timezone America/Los_Angeles

software:
	./colors.sh
	./lf.sh
	./vim.sh
	./fish.sh
	./z.sh
	yarn add prettier --dev --exact
	# ./rbenv.sh
	# ./autojump.sh

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
