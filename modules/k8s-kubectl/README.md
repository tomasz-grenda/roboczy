## Install kubectl
  Follow this official guide if you haven't installed kubectl yet

  [https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl)


## Let's begin exploring
Use built-in help

```
kubectl explain
```

Use help to discover what the following kubectl commands do:
  * get
  * describe
  * delete
  * run
  * apply

### Check running pods inside your namespace
```
kubectl get pods
```

### Check running pods inside kube-system namespace
```
kubectl -n kube-system get pods
```

### Check different objects
#### services
```
kubectl -n kube-system get svc
```
#### services
```
kubectl -n kube-system get svc
```
#### deployments
```
kubectl -n kube-system get deploy
```
#### replicasets
```
kubectl -n kube-system get rs
```
