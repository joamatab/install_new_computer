install: dotfiles colors conda software prettier fish

pre-commit:
	pre-commit install

software:
	./autojump.sh
	./lf.sh
	./vim.sh
	./rbenv.sh
	./pyenv.sh
	./pipx.sh

rust:
	./rust.sh

dotfiles:
	./dotfiles.sh

colors:
	rm -rf ~/.config/base16-shell
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

conda:
	./conda.sh

fish:
	./fish.sh

git_key:
	./git_key.sh

git_config:
	./git_config.sh

pip:
	./pip.sh

sshd:
	sudo systemctl enable sshd
	sudo systemctl start sshd

fx:
	sudo npm -f install fx

prettier:
	yarn add prettier --dev --exact

ipkiss-313-packages-linux64.zip:
	wget -O 'ipkiss-313-packages-linux64.zip' 'https://www.dropbox.com/s/5sqbq839yfvg3zv/ipkiss-313-packages-linux64.zip?dl=0'

ipkiss313: ipkiss-313-packages-linux64.zip
	python ipkiss-313-packages-linux64.zip

ipkiss-320-packages-linux64.zip:
	wget -O 'ipkiss-320-packages-linux64.zip' 'https://www.dropbox.com/s/6c7a87as9uc018t/ipkiss-320-packages-linux64.zip?dl=0'

ipkiss3: ipkiss-320-packages-linux64.zip
	python ipkiss-320-packages-linux64.zip
	cp ipkiss.lic $(HOME)/miniconda3/envs/ipkiss3/
