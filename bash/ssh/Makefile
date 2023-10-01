
access:
	less id_rsa.pub >> $(HOME)/.ssh/authorized_keys

key:
	ssh-keygen -f $(HOME)/.ssh/id_rsa -t rsa -N ''

authorize:
	cp authorized_keys $(HOME)/.ssh/authorized_keys


install: $(HOME)/.ssh/keys/engineer

$(HOME)/.ssh/keys/engineer: 
	touch $(HOME)/.ssh/config
	sh key/install.sh

mac:
	sudo cp sshd_config_mac /etc/ssh/sshd_config
