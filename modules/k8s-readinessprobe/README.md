# 1. I'll be ready when I'm ready - readinessProbe

Sometimes we need to give some more time to app to be ready (especially big, JVM-based apps). It's a second type of probe that is used by Kubernetes - it's called **readinessProbe**.

You will now configure this kind of probe for existing service. Add the following definition to `cow-rs.yaml` file under fussy container definition

```
readinessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 60
  periodSeconds: 1
```

and recreate it using this new file.

Create also a service of type **NodePort** that will expose all pods created by `cow` replicaset for **internal** communication:

```
kubectl apply -f  cow-svc-nodeport.yaml
```

Now quickly try connecting to service port (it's **32088**) to see if you can use the app now.
> Can you see the app page? What happens if other applications would try connecting to it?

Scale your **cow** ReplicaSet by adding 2 more pods. You can observe the service to see how many pods are ready to process requests - use dashboard (**Workloads->Replica Sets->fussy-rs** and **Pods** section at the bottom). You can also watch ReplicaSet status from cli:

```
kubectl get rs cow  -w
```

