# 1. Building an image from container

Time to build your first image, but not from `Dockerfile` - you will launch container and based on your live changes will build a new container image.

Run **nginx** container in background.

```
docker run --name=nginx_builder -d nginx
```

Launch a shell inside container and check the content of its default webpage - **/usr/share/nginx/html/index.html**.

```
docker exec -ti nginx_builder bash
```

Modify that file (or create your own version) using your favourite editor - you may probably install it first using `apt-get` (vi should be available by default).

Next leave container and create **myginx** image with the following command

```
docker commit nginx_builder mynginx
```

Finally remove nginx container

```
docker rm -f nginx_builder
```

and launch new one using newly created **mynginx** image

```
docker run -p 8080:80 -d mynginx
```

Check the content of `index.html` file or open [http://localhost:8080](http://localhost:8080) in your browser.

Please also check all layers in your container image with `history` command

```
docker history mynginx
```