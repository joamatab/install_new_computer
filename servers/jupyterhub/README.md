# Jupyter

allow to create lumerical gui from jupyterhub

```
os.environ['DISPLAY']=':1'
```

- https://github.com/jupyterhub/jupyterhub-deploy-teaching.git
- https://the-littlest-jupyterhub.readthedocs.io/en/latest/
- https://the-littlest-jupyterhub.readthedocs.io/en/latest/install/amazon.html
- https://github.com/bhrutledge/jupyter-venv

Both jupyerlab and jupyterhub run for single user `awsgui` running the script inside a GUI session (so lumerical can start)

```
vncserver #starts the vncserver
sh ~/install_ubuntu/jupyterhub/single_user/run.sh
```

`conda env list` displays current conda environments

To see the kernels' python path

```
import sys
print(sys.executable)
```

displays current python being used

`source activate ipkiss3` activates ipkiss2 virtual environment
`ipython kernel install --user --name ipkiss3` registers ipkiss3 kernel

# With anaconda

less /home/awsgui/anaconda3/share/jupyter/kernels/python3/

# Without anaconda

less /usr/local/share/jupyter/kernels/python2/kernel.json

# Register current environment for notebook kernel

```
source activate py2 #
ipython kernel install --user --name py2
```

adds /home/awsgui/.local/share/jupyter/kernels/py2

# Extra

`conda install nb_conda` manages virtual environments inside conda
https://github.com/Anaconda-Platform/nb_conda_kernels

## virtual environments

each project should be installed in a separate virtual environment:

`conda env list` shows the available virtual environments
`conda create -n environmentName python=2.7 anaconda`
`source activate environmentName` activates the virtual environment
`ipython kernel install --user --name environmentName` registers environmentName into jupyterlab
`conda env remove -n environmentName` removes the environment

# References

- https://conda.io/docs/user-guide/tasks/manage-python.html
- https://jupyterlab.readthedocs.io/en/stable/user/jupyterhub.html
- https://nbconvert.readthedocs.io/en/latest/index.html jupyterlab AMI on amazon for backup

Clear outputs of notebooks

- https://github.com/toobaz/ipynb_output_filter
- https://try.jupyter.org/
- https://github.com/mlshapiro/jupyterlab-flake8
