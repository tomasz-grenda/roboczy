# 1. Configuring containers with environment variables

Start a mysql container with a `p@ss` root password. To do so you need to provide an environment variable `MYSQL_ROOT_PASSWORD` to the container

```
docker run -e MYSQL_ROOT_PASSWORD=p@ss --name db -d mysql
```

After a few seconds (mysql needs to be running) execute `mysql` client from that container and provide a password to access database

```
docker exec -ti db mysql -p
```

Now find an environment variable on [official image page](https://hub.docker.com/_/mysql/) that is reponsible for generating random password at startup and start a new container with it. 
You can find password by looking it up in container's logs - use `docker logs CONTAINER_NAME|grep ROOT`.

# 2. Accessing container logs

To see logs produced by container use `logs` command. For example to see database logs created in previous step:

```
docker logs db
```

or use *tail/follow* mode

```
docker logs -f db
```
