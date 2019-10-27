# 1. Launching simple docker web gui - Portainer

You need to set a password for **admin** user. To generate hash for **admin** password use the following command

```
docker run --rm httpd:2.4-alpine htpasswd -nbB admin admin | cut -d ":" -f 2
```

Now launch [portainer](https://portainer.io) with the following commands

```shell
docker volume create portainer_data
docker run -d -p 8080:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer --admin-password 'PASTE_GENERATED_PASSWORD_HASH'
```

Access **portainer** on port **8080** of your host using **admin/admin**.