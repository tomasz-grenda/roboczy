## External configuration using ConfigMaps
Now you will provide an external config to a fussy container. Create a ConfigMap from cli:

```
kubectl create configmap fussy-config --from-literal=DELAY=bolt --from-literal=CRASH=badluck
```

and a new pod with environment variables set from this ConfigMap:

```
kubectl apply -f fussy-configurable-pod.yaml
```

This pod has **90%** chance it will crash at startup and will wait for this **9.58s** (time it took Usain Bolt to run 100m in 2009 World Championship).

Check whether environments variables are available from within a container

```
kubectl exec -ti fussy-configurable -- env
```

## Using ConfigMap file

Launch a new pod from [fussy-betterconfigurable-pod.yaml](fussy-betterconfigurable-pod.yaml)

```
kubectl apply -f fussy-betterconfigurable-pod.yaml
```

Notice it got stuck in `CreateContainerConfigError` state. You can check details using describe command (see `Events:` section)

```
kubectl describe pod fussy-betterconfigurable
```
It won't run because it requires a ConfigMap. Create a missing ConfigMap from a file [fussy-betterconfig-configmap.yaml](fussy-betterconfig-configmap.yaml)

```
kubectl apply -f fussy-betterconfig-configmap.yaml
```

Now wait a moment (or two) for pod to be created. If it takes too long time then you may want to delete it and create it again.

