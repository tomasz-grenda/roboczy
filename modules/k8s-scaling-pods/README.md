# 1. Scaling pods

Now it's time to scale our container. We will use a **ReplicaSet** object to create a set of pods. Use [fussy-scaled.yaml](fussy-scaled.yaml) to deploy replicaset:

```
kubectl apply -f fussy-scaled.yaml
```

Scale it to 10 replicas:

```
kubectl scale rs fussy-scaled --replicas=10
```

Check status of your pods by using label to query only ones created by **ReplicaSet** with an option to see what nodes they are running on

```
kubectl get pods -o wide -l app=fussy-scaled
```

You can also check status of your replicaset using `describe` and `get` commands in similar way as with pods.

```
kubectl get replicaset fussy-scaled
kubectl describe rs fussy-scaled
```

# 2. Freeing pods

Choose 2 pods from newly created replicaset and change label **app=fussy-scaled** for them.

First list all pods with that label:

```
kubectl get pod -l app=fussy-scaled
```

Change label for two, selected pods:

```
kubectl label --overwrite pod  fussy-scaled-7wzd4 fussy-scaled-c76vw  app=not-so-fussy
```

See how many pods you've got now:

```
kubectl get pod | grep -c 'fussy-scaled-'
```

Re-attach labels to those pods

```
kubectl label --overwrite pod  fussy-scaled-7wzd4 fussy-scaled-c76vw  app=fussy-scaled
```

ReplicaSet should kill all pods above set number - it is visible nicely in web console or using `kubectl get rs`.

# 3. Using autoscaling

Time to let machine take over scaling process. This time we need to configure a special addon for minikube that will add a service for storing metrics which are required by the autoscaling component *(HorizontalPodAutoscaler)*.

```
minikube addons enable metrics-server
```

Now create a new replicaset:

```
kubectl apply -f fussy-autoscaled-rs.yaml
```

Attach autoscaler (**HorizontalPodAutoscaler** to be precise):

```
kubectl autoscale rs fussy-autoscaled --max=6 --cpu-percent=20
```

Now consume some cpu. Find a pod name and execute cpu intensive process, e.g.:

```
kubectl exec -ti fussy-autoscaled-gl274 -- sh -c "while :;do > /tmp/scaleme;done"
```

Watch new pods being created by HPA. If you interrupt the cpu loop after a few minutes you should expect a single pod running in this replicaset.
