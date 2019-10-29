# 1. Run GOGS with data volume

Let's run **GOGS** git server using its official docker image.

First prepare a directory for data where it will store all its data

```
mkdir gogs-data
```

Then launch a container with a specific gogs image version

```
docker run --name=gogs -p 8082:3000 -v $PWD/gogs-data:/data -d gogs/gogs:0.11.19
```

Now configure it manually using [http://localhost:8082](http://localhost:8082):

* Change `Database type` to SQlite3
* Change database `Path` to `/data/gogs.db`
* Change `Application URL` to **http://localhost:8082**
* Change `Log Path` to `/data/gogs/log`
* On welcome screen click **Register** in the upper right corner and create a user

Verify if it's working and whether you see any files in **gogs-data** directory on your host.
Then destroy your container. That's right - **REMOVE YOUR CONTAINER** :-)

```
docker rm -f gogs
```

Make sure it's not running and then recreate it with **newer** version of gogs

```
docker run --name=gogs -p 8082:3000 -v $PWD/gogs-data:/data -d gogs/gogs:0.11.53
```

You've just upgraded your git without any migration process involved and also verified one of the most fundamental principles of containers - **decoupling data and configuration from application**.
