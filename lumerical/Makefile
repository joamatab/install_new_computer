lumpath=/opt/lumerical/2020a/

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

ubuntu-deps:
	sudo apt install -y alien
	sudo apt-get install libxss1
	sudo apt-get install libxmlsec1
	sudo apt-get install libxmlsec1-openssl
	sudo apt-get install libtk8.5 

lumerical: lumerical.rpm

lumerical.rpm:
	wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/kz1zbokc1q0482w/Lumerical-2020a-r6-0ff9ee970e.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/emx745lc64whh9z/Lumerical-2020a-r5-e3c7471fdc.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/cigs6krz3y79agf/Lumerical-2020a-r4-0f4fa47357.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/foljdxl3qxbn02d/Lumerical-2020a-r2-eeb054ca61.el6.x86_64.rpm?dl=0'
	# wget -O 'lumerical.rpm' 'https://www.dropbox.com/s/xd9yw8f61ysjptn/Lumerical-2019b-r6-1db3676.el6.x86_64.rpm?dl=0'
	
cml.rpm:
	wget -O 'cml.rpm' 'https://www.dropbox.com/s/5jcfnedzr55unvu/lumerical-cml-compiler-2020a-r2.0.2152-7852fef.el7.x86_64.rpm?dl=0'

cml: cml.rpm

home:
	rm -rf $(HOME)/.lumerical/ 
	cp -r $(lumpath) $(HOME)/.lumerical

clean:
	rm -rf *.deb
	rm -rf *.rpm

ubuntu: ubuntu-deps
	sudo alien -k --scripts lumerical.rpm
	sudo dpkg -i *.deb
	sudo rm $(lumpath)/lib/libxmlsec1*

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
