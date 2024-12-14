# Update

Update to the latest version of gitlab:
https://docs.gitlab.com/ee/policy/maintenance.html#upgrade-recommendations

```
sudo apt-get update && sudo apt-get install gitlab-ce

```

# Install gitlab

## Option 1: Use AMI

- [gitlab](https://about.gitlab.com/aws/)

```
sudo vi /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure
```

## install from source

- [ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-gitlab-on-ubuntu-16-04)

# References

- [Recommended machine](https://docs.gitlab.com/ee/install/requirements.html#cpu)
- https://docs.gitlab.com/omnibus/settings/nginx.html
- https://about.gitlab.com/installation/#ubuntu

# Setup continuous integration CI

https://docs.gitlab.com/runner/install/linux-manually.html
sudo gitlab-runner register:

- GetTokenFromGitlab
- docker
- python:3

# Public gitlab

https://docs.gitlab.com/omnibus/docker/

```
sudo docker run --detach \
    --hostname gitlab.example.com \
    --publish 54.183.163.234:443:443 \
    --publish 54.183.163.234:80:80 \
    --publish 54.183.163.234:22:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
```

```
sudo docker run --detach \
    --hostname gitlab.example.com \
    --publish 172.31.34.154:443:443 \
    --publish 172.31.34.154:80:80 \
    --publish 172.31.34.154:22:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
```
