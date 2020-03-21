default: install
install:
	./windows.sh

update:
	conda update conda -y
	conda update --all -y
	
