# Enabling docker registry

# 1. Deploy a registry server

https://docs.docker.com/registry/deploying/

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

# 2. Enable

edit `/app/data/gitlab.yml`


```

registry:
  enabled: true
  host: registry.gitlab.example.com
  port: 5005
  api_url: http://localhost:5000/
  key: config/registry.key
  path: shared/registry
  issuer: gitlab-issuer

```



# Links

- https://docs.gitlab.com/ee/administration/packages/container_registry.html
- https://docs.docker.com/registry/deploying/

