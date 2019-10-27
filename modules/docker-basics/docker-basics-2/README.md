# 1. Getting inside a container

Launch a simple container from nginx image in background and name it **nginx**

```
docker run -d --name mynginx nginx
```

Get inside of it using `exec` command

```
docker exec -ti mynginx bash
```

Check what processes are running there. And yes - you probably need to install proper package first (`tip: ps command is included in procps package`)

> Question: Can you guess what linux distribution it is based on?


# 2. Removing containers

Now list all containers

```
docker ps -a
```

See the **STATUS** field. Now up till that moment you may have some containers that aren't running (compare it with the output of `docker ps` command output - it shows only **running** containers). Select one of them and remove it

```
docker rm CONTAINER_ID_OR_NAME
```

Now **ALL** data this container wrote is gone - hope you didn't write there anything important :-)

You can also remove *running* containers. Just add `-f` option. It will stop them first (actually by killing all processes inside) and remove all data.

First start new container

```
docker run --name=removeme -d nginx
```

and delete it without a need to stop it first

```
docker rm -f removeme
```

# 3. Temporary containers

Sometimes it is handy to launch a container, execute some commands and leave it without ever need to use it again. That's when you use `--rm` option

```
docker run -ti --rm nginx bash
```

It launches a container with `bash` shell (sometimes bash is not available in a container image - try `sh` instead) and when you exit it, it will be removed automatically.

# 4. Privileged containers

> **WARNING** This task will change a time on the host you're running docker from. You may need to revert those changes afterwards.

Run a ubuntu container in an interactive mode

```
docker run -ti --rm ubuntu
```

Inside container change time by adding *30 minutes* with `date` command

```
date -s '+30 min'
```

Check whether it changed on the host by simply launching `date` command.

Now try the same, but this time with **privileged** container. Run privileged ubuntu container

```
docker run -ti --privileged --rm ubuntu
```

Set Time


```
date -s '+30 min'
```

and verify.


**Did it change?** (Please be aware that when your host system may try to synchronize it with external sources and you must be quick to notice that change.)
