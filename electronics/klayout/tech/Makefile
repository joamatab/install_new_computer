help:
	@echo 'make install:    Installs all layermaps'
	@echo 'make layermaps:  installs important layermaps'
	@echo 'make backup:     backup all your configs in ~/.klayout'

backup:
	mkdir -p ~/.bak
	tar -cvpzf ~/.bak/klayout.tar.gz ~/.klayout

clean:
	rm -rf ~/.klayout/tech
	mkdir -p ~/.klayout/tech

layermaps: clean
	ln -sf $(PWD)/generic  ~/.klayout/tech/
	ln -sf $(PWD)/tj  ~/.klayout/tech/

all: clean
	sh install_layermaps.sh
