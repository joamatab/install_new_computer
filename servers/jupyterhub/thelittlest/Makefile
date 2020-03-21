bootstrap.py: 
	wget https://raw.githubusercontent.com/jupyterhub/the-littlest-jupyterhub/master/bootstrap/bootstrap.py

install_notebooks: bootstrap.py
	sudo python3 bootstrap.py --admin ubuntu

install: bootstrap.py
	sudo su
	bash install.sh

shared: 
	sudo mkdir -p /srv/data/shared_data_read_only
	# sudo cp jupyterlab_welcome_notebooks/welcome.ipynb /srv/data/shared_data_read_only/
	sudo mkdir -p /srv/data/shared_data
	chmod 777 /srv/data/shared_data
	cd /etc/skel
	sudo ln -s /srv/data/shared_data_read_only shared_data_read_only
	sudo ln -s /srv/data/shared_data shared_data

config:
	cp jupyterhub_config.py /opt/tljh/config/jupyterhub_config.d/

conda:
	sudo ln -sf /opt/tljh/user/bin/python /usr/local/bin/python
	sudo ln -sf /opt/tljh/user/bin/conda /usr/local/bin/conda
	sudo ln -sf /opt/tljh/user/bin/pip /usr/local/bin/pip
	# etc/profile.d/conda.sh

