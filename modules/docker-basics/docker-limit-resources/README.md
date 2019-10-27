# 1. Limiting resources


## 1.1 CPU

Launch jenkins with a limit of **10%** of available cpu power

```
docker run -ti --rm --cpu-quota 1000 --cpu-period 10000 jenkins/jenkins:lts
```

Now change `cpu-quota` to slightly larger (e.g. 4000) value and see it starting **significantly faster**.

## 1.2 Memory

Let's limit memory available for jenkins. Start it with **512MiB** limit

```
docker run -ti -m 512m jenkins/jenkins:lts
```

In another terminal launch `docker stats` command and see how jenkins eats more and more memory. Look at **MEM USAGE / LIMIT** column.

Next try to launch it with a limit of **200MiB** and see if it starts.
