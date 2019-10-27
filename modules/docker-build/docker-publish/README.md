# 1. Build container image

Build **newnginx** image based on **nginx** using Dockerfile.

Prepare a new directory **newnginx** and place a `index.html` inside it with the following content:

```html
<h1> Kubernetes rocks! </h1>
```

Now in `Dockerfile` place the following content

```dockerfile
# use specific nginx version
FROM nginx:1.15

# add your index.html and place it under default root directory
COPY index.html /usr/share/nginx/html/
```

Let's add some package too - `curl` is always a tool nice to have. Add it with `RUN` 


```dockerfile
# install curl
RUN apt-get update; \
	apt-get install -y --no-install-recommends \
		curl && \
		rm -rf /var/lib/apt/lists/*

```

Build it now with docker 

```
docker build -t newnginx .
```

After a short while you should have an image `newnginx:latest`.


# 2. Publish your container image

Create an account on [https://hub.docker.com/](https://hub.docker.com/). You account name will be your repository name. 


First login using your credentials

```
docker login
```

Try tu push your newly created image

```
docker push newnginx:latest
```

Ooops - you probably don't have permissions to publish it as official image. We need to tag it first. 

```
docker tag newnginx:latest YOUR_REPOSITORY/newnginx:latest
```

Attach also an additional tag `1.0`

```
docker tag newnginx:latest YOUR_REPOSITORY/newnginx:1.0
```

Now publish it with push command - do it for each tag separately

```
docker push YOUR_REPOSITORY/newnginx:1.0
docker push YOUR_REPOSITORY/newnginx:latest
```
