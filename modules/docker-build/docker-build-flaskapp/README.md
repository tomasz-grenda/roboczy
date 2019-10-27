# 1. Building flask app

## 1.1 Build from your own base image (more control)

Debian is often used as a primary distro for many official container images. Let's use it to embed our simple flask application that is just a single file available at [src/app.py](src/app.py).

Use `Dockerfile.flask-debian` file to build a container image with the app in it. You must define it as an argument because it's a non-standard one - docker expects `Dockerfile` by default. You will also attach a version tag `1.0` to that image. 

```
docker build -t flaskapp:1.0 -f Dockerfile.flask-debian .
```

Test it by running it with port publishing enabled and check it with curl.

```
docker run -d -P flaskapp:1.0
curl localhost:GENERATED_PORT
```

Ooops! It looks like it's not working. There's a small typo in Dockerfile. Make sure there is a correct port exposed - fix it so that it would point to `8080` and not `808`

```
...
EXPOSE 8080
...
```

Now rebuild it and verify it again.

Have you noticed it was installing all the packages skipping docker cache? Do you know how to prevent it in future?

We should upgrade our app so that it would run on python 3 instead of version 2. To do it you must inside `Dockerfile.flask-debian` file replace `python-flask` with `python3-flask` and `"python"` in **CMD** with `"python3"`. After that build a new version

```
docker build -t flaskapp:1.1 -f Dockerfile.flask-debian .
```

Verify it by running it and querying using curl

```
docker run -d -p 18081:8080 flaskapp:1.1
curl localhost:18081
```

As a last part please remove from Dockerfile.flask-debian the following part **with** a preceding `\` in line above it

```bash
	&& \
  rm -rf /var/lib/apt/lists/*
```

and rebuild an image with **1.1-toobig**. Now compare size of all three versions. Which is the biggest and why?

## 1.2 - Use official python image 

This time we'll use official python image from docker hub.

First create a standard `requirements.txt` file with a single line in it

```
flask==0.12
```

Then use `Dockerfile.flask-python` file to build a new container image

```
docker build -t flaskapp:1.2 -f Dockerfile.flask-python .
```

Again verify it by running it and querying using curl

```
docker run -d -p 18082:8080 flaskapp:1.2
curl localhost:18082
```

# 2. Checking for available images

You can browse images available on your host with the following command

```
docker images
```

Add `--digests` option to additionally see sha256 sums

```
docker images --digests
```
