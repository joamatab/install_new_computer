# Docker runner

Steps:

- install docker
- reboot computer
- register runner

```
sh install.sh
sudo reboot
sh register.sh
```

# Bastion runner

- install gitlab runner
- install docker
- install docker-machine
- [register gitlab runner into gitlab](../README.md)
  - sudo gitlab-runner register
  - get token from gitlab settings
- config runners `/etc/gitlab-runner/config.toml`
  - runnerspawner
  - docker+machine
  - python:2
  - ubuntu:18.04

[runners.ssh]
host = "my-production-server"
port = "22"
user = "root"
password = "production-server-password"
identity_file = ""

References:

- https://blog.programster.org/deploy-gitlab-runner-with-docker
- https://docs.gitlab.com/runner/configuration/advanced-configuration.html#the-runners-cache-section
