# Sharing is caring - two containers with a shared volume
Create a pod with two containers - one will write data and the other will be able to consume it.

```
kubectl apply -f consumer-producer-pods.yaml
```

Now check output of consumer container in web console - it prints data written by producer container.

From cli you can also check existence of the file in both containers in the pod:

```
kubectl exec -ti consumer-producer -c consumer -- cat /offer/offer.txt
kubectl exec -ti consumer-producer -c producer -- cat /data/offer.txt
```
