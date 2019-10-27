# 1. Exposing services

## 1.1 Let's talk in private - ClusterIP service

Start by creating three Pods:

```
kubectl apply -f cow1-pod.yaml
kubectl apply -f cow2-pod.yaml
kubectl apply -f cow3-pod.yaml
```

Now attach a service of type **ClusterIP** that will expose the pod `cow1` for **internal** communication:

```
kubectl apply -f  cow-svc-clusterip.yaml
```

Now service is available for other pods running within your Kubernetes cluster. We can test it using a test pod. Create it first:

```
kubectl run alpine --image=alpine -ti --restart=Never  --rm=true -- /bin/sh
```

Now query the service using its short name:

```
wget -q -O- cow
```

You should be getting replies from all three pods (one per query of course).

## 1.2 Reaching service from other namespace

Create a new namespace

```
kubectl create namespace aliencow
```

Create a test pod in that namespace

```
kubectl -n aliencow run alpine --image=alpine -ti --restart=Never  --rm=true -- /bin/sh
```

Now query the service using its short name:

```
wget -q -O- cow
```

You cannot reach that service, because it runs in another namespace. Repeat the command by adding namespace as suffix (`cow.default`).


Use ping to see what IP address has been assigned to the service

```
ping cow.default
```

You can find it also in `kubectl describe service cow` output.

## 1.4 Talk to me, I'm listening - NodePort service

Another type of service you can use to expose your application to the outside world is **NodePort**. We'll create it now for our fussy pods

```
kubectl apply -f cow-svc-nodeport.yaml
```

Now you need to check what port from a special pool has been assigned for your service. It is visible in `kubectl get svc` output as well as in `kubectl describe svc cow-nodeport` (`NodePort` field).


Connect to the service with a browser using that port and an IP of your minikube vm. You can check IP with `minikube ip` command.

You can also set a static port for your service - just uncomment `# nodePort: 32080` part in `cow-svc-nodeport.yaml` file and reapply it:

```
kubectl apply -f cow-svc-nodeport.yaml
```

Now you should be able to connect to your service with your predefined port number - in this case it's **32080**.


# 2. I'll be ready when I'm ready - readinessProbe

Before continuing delete all cow pods using labels

```
kubectl delete pod -l app=cow
```

Sometimes we need to give some more time to app to be ready (especially big, JVM-based apps). It's a second type of probe that is used by Kubernetes - it's called **readinessProbe**.

You will now configure this kind of probe for existing service. Add the following definition to `cow1-pod.yaml` file under fussy container definition

```
readinessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 1
```

and recreate it using this new file.

You can observe the service to see that pod is ready to process requests after **30 seconds** - use dashboard (**Workloads->Pod->cow1**). You can also watch its status from cli:

```
kubectl get pod cow  -w
```
