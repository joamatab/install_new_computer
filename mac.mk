help:
	@echo 'make install:       Mac software: basic install'
	@echo 'make update:        updates brew, conda and python packages'
	@echo 'make conda:         installs miniconda with python3, 64 bits'
	@echo 'make software:      installs fish, vim, tmux ...'

install: software 

update:
	brew update
	brew upgrade
	brew cleanup
	brew cleanup -s
	brew cask cleanup
	brew doctor
	brew missing
	conda update conda -y
	conda update --all -y
	fisher self-update

software:
	./cask.sh
	./brew.sh
	./vim.sh
	./autojump.sh

iterm:
	cd $(HOME)/Downloads
	curl https://iterm2.com/downloads/stable/iTerm2-3_2_9.zip > iterm2.zip
	open iterm2.zip

kitty:
	cd $(HOME)/Downloads
	wget https://github.com/kovidgoyal/kitty/releases/download/v0.14.6/kitty-0.14.6.dmg
	open kitty-0.14.6.dmg 


klayout: /Applications/klayout.app
/Applications/klayout.app:
	sh software/klayout/install_mac.sh

klayout_remove:
	rm -rf $(HOME)/.klayout
	rm -rf /Applications/klayout.app

rust:
	curl https://sh.rustup.rs -sSf | sh

chown:
	sudo chown -R $(USER):admin /usr/local
	sudo chown -R $(USER):admin /usr/local/bin

sshd:
	sudo systemsetup -setremotelogin on

.PHONY: code install photonics vim brew pip software config fish colors conda klayout iterm tmux notebooks key
