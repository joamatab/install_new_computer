# Jupyterlab

```
sh 4_jupyterlab.sh
```

## for single user

http://jupyterhub.readthedocs.io/en/latest/quickstart-docker.html
https://zero-to-jupyterhub.readthedocs.io/en/latest/
http://jupyterhub-deploy-teaching.readthedocs.io/en/latest/installation.html
https://jupyterhub.readthedocs.io/en/latest/quickstart.html#installation
https://github.com/jupyterhub/jupyterhub/wiki/Using-sudo-to-run-JupyterHub-without-root-privileges

```
sudo su
apt-get install -y npm nodejs-legacy
pip3 install --upgrade pip
python3 -m pip install jupyterhub
npm install -g configurable-http-proxy
python3 -m pip install notebook
```

docker run -p 8000:8000 -d --name jupyterhub jupyterhub/jupyterhub jupyterhub


## adding python2

```
sudo su
python3 -m pip install jupyterhub notebook ipykernel
python3 -m ipykernel install
python2 -m pip install ipykernel
python2 -m ipykernel install # register Python 2 kernel
```

## docker installation

https://jupyterhub.readthedocs.io/en/stable/quickstart-docker.html
https://github.com/jupyterhub/jupyterhub-deploy-docker
http://zero-to-jupyterhub.readthedocs.io/en/latest/user-environment.html#use-an-existing-docker-image

```
sudo docker exec -i -t jupyterhub 'bash'

```

# Extra references
- https://github.com/jupyterhub/jupyterhub/wiki/Installation-of-Jupyterhub-on-remote-server

References for SETUP:
[1] http://www.rexliu.me/2016/11/24/set-up-jupyter-hub-on-ec2/
[2] https://gist.github.com/widdowquinn/e91b9bb850ece8873bbd084944798fe2
[3] https://github.com/jupyterhub/jupyterhub/wiki/Deploying-JupyterHub-on-AWS
[4] https://github.com/jupyterhub/jupyterhub/wiki/Installation-of-Jupyterhub-on-remote-server

---REPOSITORIES---
[5] https://github.com/jupyterhub

---GETTING STARTED---
[6] https://jupyterhub.readthedocs.io/en/0.7.2/getting-started.html

---SECURITY---
[7] http://jupyterhub.readthedocs.io/en/latest/getting-started/security-basics.html

---THREADS ON GITHUB REGARDING DISABLING SSL ON JUPYTERHUB---
[8] https://github.com/jupyter/nbviewer/issues/598
[9] https://github.com/jupyterhub/configurable-http-proxy/issues/65
