## Use kubectl to launch pod
Launch pod from yaml file [simple-pod.yaml](simple-pod.yaml).

Use the following command

```
kubectl apply -f simple-pod.yaml
```

Verify if it's running:

```
kubectl get pod simplepod
```


## Get inside
Just like ```docker exec``` use ```kubectl exec``` to get inside your pod and launch shell in an interactive mode:

```
kubectl exec -ti simplepod sh
```

Check the following things:

  * IP address
  * DNS config (/etc/resolv.conf)
  * content of **/run/secrets**

## Launch pod with 2 containers

Use **1pod-2containers-pod.yaml** yaml to launch pod with 2 containers.

```
kubectl apply -f 1pod-2containers-pod.yaml
```

Next exec /bin/sh inside `busybox` container of this pod

```
kubectl exec -ti 1pod-2containers -c busybox sh
```

and download (using wget) webpage from `localhost:80/`

```
wget -qO- localhost:80/
```

**Is there any http daemon listening in busybox? How is it possible that you get a reply from localhost then?**
