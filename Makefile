install: software prettier 

software:
	./colors.sh
	./autojump.sh
	./lf.sh
	./vim.sh
	./rbenv.sh
	./pyenv.sh
	./pipx.sh
	./vf.sh
	./fish.sh

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

yarn:
	./yarn.sh

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
