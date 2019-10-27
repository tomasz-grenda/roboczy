# 1. Feeding a cow

It's time to feed a cow. First you need to prepare a pasture. To do this please create a directory `pasture` somewhere on your host e.g.:

```
mkdir /tmp/pasture
```

Then fill the pasture with grass (tufts). You need to create a files with names starting with **tuft**. So for example you may create 10 tufts):

```
touch /tmp/pasture/tuft{1..10}
```

You need to make sure that these files are writable by cow (container):

```
sudo chmod 777 -R /tmp/pasture/
```

Now run a cow container

```
docker run -ti -v /tmp/pasture:/pasture cloudowski/krazy-cow
```

You should see that cow is eating those tufts - files you've created will be renamed accordingly (see `ls -la /tmp/pasture/`).