# Instal Pypi server

https://pypi.org/project/pypiserver/#managing-the-package-directory

pip install pypiserver --user
pypi-server -p 8080 ~/packages & ## Will listen to all IPs.

# Add new packages

you need to run `python setup.py sdist` inside the machine, and that adds the packages into the index,
ideally we can deploy the latest with Gitlab Continuous integration or with Jenkins

# pip install pypi-uploader

# References

- https://pypiserver.readthedocs.io/en/latest/#gunicorn
