

gitlab-runner_amd64.deb:
	curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb

gitlab-runner_amd64.rpm:
	curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm

ubuntu: gitlab-runner_amd64.deb
	sudo dpkg -i gitlab-runner_amd64.deb

centos: gitlab-runner_amd64.rpm
	sudo yum install -y gitlab-runner_amd64.rpm
