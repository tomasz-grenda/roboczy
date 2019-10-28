
# 1 Accessing container ports

## 1.1 Publish all ports automatically
Launch 3 instances of containers from **mynginx** image with automatic port forwarding (```-P``` option).

```
docker run -d -P nginx
docker run -d -P nginx
docker run -d -P nginx
```

See what ports are opened on your host by looking them in `docker ps` output - you should see something similar to this one

```
43e9233ef52a        nginx               "nginx -g 'daemon of…"   15 seconds ago      Up 13 seconds       0.0.0.0:**32770**->80/tcp   peaceful_mclean
```

In this case port **80** is available as **32770** on your host. Now use `curl` to check whether you can actually see nginx index page. For example:

```
curl localhost:32770
```

## 1.2 Publish using static ports

Before continuing make sure you've deleted previous nginx containers.

Launch 3 more containers:
* nginx
* apache (httpd)
* traefik

Map ports manually (`-p` option). Pick **8081,8082,8083** for host ports mapped to proper container port.

```
docker run -d -p 8081:80 nginx
docker run -d -p 8082:8080 traefik --web #<-- doesn't work at the moment
docker run -d -p 8083:80 httpd
```

Launch a browser to see if you can reach them on ports you've specified.
