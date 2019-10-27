## Building smaller images with multistage builds

### Fussy container - standard version

Download code from [https://github.com/cloudowski/fussy-container](https://github.com/cloudowski/fussy-container) and build it using included Dockerfile

```
git clone https://github.com/cloudowski/fussy-container
cd fussy-container
docker build -t fussy:fat .
```

Run it to check if it works

```
docker run -ti -d -P fussy:fat
```

Use curl to query a port assigned by docker - you should see a similar output

```
Hostname:       15ce10743c3f
IP:             172.17.0.11
External IP:
Request count:  10
Version:        0.4
```

Now Check the size of the image:

```
docker images fussy
```

Quite big for a small go application. Now let's build a slimmed version.

### Fussy container - light version

In the same directory use an alternative Dockerfile:

```
docker build -f Dockerfile.multistage -t fussy:light .
```

Also check if it works in the same way. Compare size of both images:

```
docker images fussy
```

### Fussy container - the smallest image

For go application it is even possible to create a container image with a single binary. Since fussy is written in go we can use a dedicated Dockerfile that will use `scratch` base image (it's like building something from scratch indeed :-)

Build the smallest version of fussy container

```
docker build -f Dockerfile.slim -t fussy:slim .
```

Now compare sizes - you should see a major difference between those versions

```
docker images fussy
```
