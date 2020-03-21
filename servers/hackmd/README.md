# HackMd

- https://hackmd.io/c/codimd-documentation/%2Fs%2Fcodimd-documentation

## Update

```
cp ./docker-compose.yml ~/docker-hackmd
cd ~/hackmd-docker
docker-compose up -d
```

## Getting inside the container

```
docker ps # will list all the containerIds
docker exec -t -i containerId /bin/bash
```

# Extra

updating url for the old repo hack-md into codimd

```

git remote set-url origin https://github.com/codimd/container.git
```

Copying images is possible, but mounting them is a better solution, as the container storage is ephemeral

```
docker cp <containerId>:/hackmd/public/uploads /host/path/target
docker cp ~/images/uploads b377c0e6ea16:/codimd/public/
```



# Dump database

docker exec -it 285b2b34dfc6 bash -c "pg_dump --dbname=postgresql://hackmd:hackmdpass@127.0.0.1:5432/hackmd" > pg.hackmd.dump


# Minio

"imageUploadType": "minio",
"s3bucket": "codimd-images",
"minio": {
"accessKey": "MINIO_ACCESS_KEY",
"secretKey": "MINIO_SECRET_KEY",
"endPoint": "minio.cloudrondomain.com",
"secure": true,
"port": 443
}



# Database

update "Users" set profileid = 'LDAP-joaquin' where  email = 'joaquin@mywebsite.com';
select profileid,email from "Users" where email = 'joaquin@mywebsite.com';

delete from "Users" where email = 'user_name@mywebsite.com' and profileid = '';
delete from "Users" where profileid = 'LDAP-joaquin';

select profileid,email from "Users" where email = 'joaquin';


