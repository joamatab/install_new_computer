lumpath=/opt/lumerical/2020a/

license-latest:
	wget -O 'licman.gz' https://www.dropbox.com/s/1vlk2h7cwcbgzix/ANSYSLICMAN_2023R2_LINX64.gz?dl=0
	tar -xvf licman.gz

license-ubuntu: clean flexlm.rpm
	sudo alien -k --scripts *.rpm
	sudo dpkg -i *.deb

license: flexlm.rpm
	sudo yum install *.rpm -y

flexlm.rpm:
	wget -O 'flexlm.rpm' 'https://www.dropbox.com/s/d3lxfbhbswl264z/lumerical-flexlm-1.13.2170-1.x86_64.rpm?dl=0'
	wget -O 'aksusbd-7.92-1.x86_64.rpm' 'https://www.dropbox.com/s/m0n2zn8i99kwost/aksusbd-7.92-1.x86_64.rpm?dl=0'

flexlm2.rpm:
	wget -O 'flexlm.rpm' 'https://www.dropbox.com/s/lrgf8dh6pzkactb/lumerical-flexlm-1.13.2122-1.x86_64.rpm?dl=0'
	wget -O 'aksusbd-7.92-1.x86_64.rpm' 'https://www.dropbox.com/s/ycvxaylsunw86q7/aksusbd-7.92-1.x86_64.rpm?dl=0'
	wget -O 'install.sh' 'https://www.dropbox.com/s/zs1vrwb71k9894b/install.sh?dl=0'
	cmhmod +x install.sh
	sudo bash install.sh

ubuntu20-deps:
	sudo apt install -y alien
	sudo apt install -y libxss1
	sudo apt install -y libxmlsec1
	sudo apt install -y libxmlsec1-openssl
	sudo apt install -y libtk8.5

ubuntu-deps:
	sudo apt-get install -y alien freeglut3-dev libxslt-dev wget

lumerical: lumerical.rpm

lumerical.rpm:
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/igvokb4t5org1q3/Lumerical-2021R1-3-96501af08e.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/kz1zbokc1q0482w/Lumerical-2020a-r6-0ff9ee970e.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/emx745lc64whh9z/Lumerical-2020a-r5-e3c7471fdc.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/cigs6krz3y79agf/Lumerical-2020a-r4-0f4fa47357.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/foljdxl3qxbn02d/Lumerical-2020a-r2-eeb054ca61.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/xd9yw8f61ysjptn/Lumerical-2019b-r6-1db3676.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/5k6m1l089gsiqjs/Lumerical-2021R2-2-df9013d.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/upulgiky66g9xqp/Lumerical-2022R1-R1-9458412.el7.x86_64.rpm?dl=0'
	wget -O 'lumerical.rpm' 'https://www.dropbox.com/scl/fi/f7n3tiryzvol3zc5qc6fc/Lumerical-2023R2-1-4fbca54c6c.el7.x86_64.rpm?rlkey=p84vlwoswlcn77rlpnph8wnkw&dl=0'

cml.rpm:
	wget -O 'cml.rpm' 'https://www.dropbox.com/s/5jcfnedzr55unvu/lumerical-cml-compiler-2020a-r2.0.2152-7852fef.el7.x86_64.rpm?dl=0'

cml: cml.rpm

debian:
	sudo apt install -y --ignore-missing \
		alien \
		libxss1 \
		libtbb2 \
		libmkl-intel-lp64 \
		libmkl-intel-thread \
		libmkl-core \
		libxmlsec1 \
		libxmlsec1-openssl \
		libtk8.5
	sudo alien -k --scripts lumerical.rpm
	sudo mkdir -p /opt/lumerical/2021
	sudo cp Lumerical-2021R1-3/opt/lumerical/v211 -r /opt/lumerical/2021

cp:
	sudo mkdir -p /opt/lumerical/2021
	sudo cp Lumerical-2021R1-3/opt/lumerical/v211 -r /opt/lumerical/2021

home:
	rm -rf $(HOME)/.lumerical/
	cp -r $(lumpath) $(HOME)/.lumerical

clean:
	rm -rf *.deb
	rm -rf *.rpm

ubuntu: ubuntu-deps
	sudo alien -k --scripts lumerical.rpm
	sudo dpkg -i *.deb
	# sudo rm $(lumpath)/lib/libxmlsec1*

ubuntu2:
	sudo rm $(lumpath)/lib/libxmlsec1*
	sudo ln -s /lib/x86_64-linux-gnu/libssl.so.1.1.0 /usr/lib/libssl.so.10
	sudo ln -s /lib/x86_64-linux-gnu/libcrypto.so.1.1.0 /usr/lib/libcrypto.so.10

centos:
	sudo yum install *.rpm -y

suse:
	sudo zipper install *.rpm -y

opt:
	rpmextract.sh lumerical

arch: opt
	./arch.sh

debian:
	cd $(lumpath)
	sudo ln -s /usr/lib/openvpn/libssl.so.1.0.0 libssl.so.10
	sudo ln -s /usr/lib/openvpn/libcrypto.so.1.0.0 libcrypto.so.10
