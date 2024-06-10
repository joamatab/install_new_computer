klayout:
	git clone https://github.com/KLayout/klayout.git

conda:
	conda install litex-hub::klayout -y

ubuntu:
	sudo apt install -y libqt4-dev-bin  libqt4-dev make gcc g++ ruby ruby-dev python3 python3-dev libz-dev

debian:
	sudo apt install -y  gcc g++ ruby ruby-dev python3 python3-dev libz-dev lintian ccache

build: klayout
	cd klayout
	./build.sh

nix:
	nix-shell -p klayout
