# 1. Launch first container

Run **alpine** and **ubuntu** containers in an interactive mode and inspect them - check filesystem size, packages installed and processes running.

To run alpine type

```
docker run -ti alpine
```

Similarly you can run latest ubuntu image

```
docker run -ti ubuntu
```

Explore content of both containers with the following commands

```bash
# check ip addresses
ip a

# check filesystem size
du -sh /

# list all process
top

# set date
date -s 1212
```


# 2. Starting, stopping and restarting

Run 3 **nginx** containers in background

```
docker run -d nginx
docker run -d nginx
docker run -d nginx
```

Get their ids (it is printed by docker after you launched them) and use it to:
  * stop
  * start
  * restart
  * pause

For example

```
docker restart c93c81698373a738b4fc63600722e3e46c40494cb988324af0c123b7da9769b5
```


# 3. Killing is bad but sometimes necessary

Kill all other nginx containers and kill them

```
docker kill CONTAINER_ID_OR_NAME
```

See that they are not listed

```
docker ps
```

Now repeat this command with `-a` option - you should see more.


## 3.1 Restart after failures

With docker you can tell docker daemon to restart your container if it fails. Just launch nginx with the following command

```
docker run --restart=always -d nginx
```

Now find nginx PID using `docker inspect` (look for *"Pid"* field) and kill it from the host. See what happens with docker container. See what **STATUS** field shows in `docker ps` output.
