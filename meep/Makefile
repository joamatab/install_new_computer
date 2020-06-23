SHELL:=/usr/bin/fish

shell:
	echo $(SHELL)

mp:
	echo 'installing stable meep in new conda env'
	conda create -n mp -c conda-forge pymeep -y
	conda install -y notebook ipykernel
	conda activate mp
	python -m ipykernel install --user --name mp --display-name "mp"
	conda install nlopt -y

mp2:
	echo 'installing latest meep in new conda env'
	conda create -n mp2 -c simpetus -c conda-forge pymeep -y
	conda activate mp2
	pip install ipykernel
	python -m ipykernel install --user --name mp2 --display-name "mp2"
	conda install nlopt -y

pymeep:
	echo 'installing stable meep in current conda env'
	conda config --add channels conda-forge
	pip install ipykernel
	conda install -y pymeep

pymeep2:
	echo 'installing latest meep in current conda env'
	conda config --add channels simpetus
	conda install -y pymeep
