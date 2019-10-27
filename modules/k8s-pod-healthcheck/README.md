## Mortal containers, immortal pods

Let's check pod and container resiliency. First start a simple pod using fussy image. Use [fussy-pod.yaml](fussy-pod.yaml) to deploy it:

```
kubectl apply -f fussy-pod.yaml
```

Now kill container by killing process with **pid=1** inside it. First do it from command line:

```
kubectl exec -ti fussy -- kill 1
```

Check in console that after a while it will be launched again and **RESTARTS** value has increased.

```
kubectl get pod fussy
```

Kill it again using previous command and see if it will be resurected again.

## Healthchecks (liveness probes) in action

Define a new pod using [fussy-liveness-pod.yaml](fussy-liveness-pod.yaml):

```
kubectl apply -f fussy-liveness-pod.yaml
```

After around 15s container in a pod will be killed and recreated. It has a liveness probe that will check existence of file **/tmp/healthy** to determine if it's alive. Check pod status and its events using describe command:

```
kubectl describe pod fussy-liveness-test
```

Add this file to prevent scheduler from killing it:


```
kubectl exec -ti fussy-liveness-test -- touch /tmp/healthy
```

# Cleaning up

```
kubectl delete -f fussy-pod.yaml -f fussy-liveness-pod.yaml
```
