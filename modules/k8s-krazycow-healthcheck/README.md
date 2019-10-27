## Mortal containers, immortal pods

Let's check pod and container resiliency. First start a simple pod using fussy image. Use [cow-healthcheck-pod.yaml](cow-healthcheck-pod.yaml) to deploy it:

```
kubectl apply -f cow-healthcheck-pod.yaml
```

Now kill container by killing process with **pid=1** inside it. First do it from command line:

```
kubectl exec -ti cow-healthcheck -- kill 1
```

Check in console that after a while it will be launched again and **RESTARTS** value has increased.

```
kubectl get pod cow-healthcheck
```

Kill it again using previous command and see if it will be resurected again.
