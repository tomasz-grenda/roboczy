# 1. Create a deployment

Use [cow-deploy.yaml](cow-deploy.yaml) file to create a deployment with 2 cow replicas

```
kubectl apply -f cow-deploy.yaml
```

Notice that this Deployment definition contains both **liveness** and **readiness** probes.

Create a NodePort service for testing purposes

```
kubectl expose deployment/cow-update --port=80 --target-port=8080 --name cownode --type NodePort
```

Check newly created **cow** Deployment object using standard `get` and `describe` commands. Notice that by default it runs ony single instance of an app. We can easily change that by scaling it:

```
kubectl scale deployment/cow-update --replicas=3
```

Verify cow version with random port assigned to `cownode` service

```
kubectl get svc cownode

NAME      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
cownode   NodePort   10.107.201.57   <none>        80:32216/TCP   87s
```


# 2. Perform rolling update

Now we are ready to perform rolling update. To make it more visible scale your deployment first to **10** replicas

Create a test pod in a separate terminal from which you will issue requests to the service.

```
kubectl run testdeployment --image=alpine -ti --restart=Never  --rm=true -- sh -c 'while :;do wget -T1 -q -O- cow-update|grep ver: ;sleep 0.5;done'
```

Next update your deployment object by setting image to newer version (**blue**) and check if they have been updated and new version of webpage is available. Use the following command:

```
kubectl set image deployment/cow-update cow=cloudowski/krazy-cow:blue --record
```

You can watch the status using output from `testdeployment` terminal set earlier and with the following commands:

```
kubectl get deploy cow-update -w
kubectl get rs  -w
kubectl rollout status deployment cow-update
```

Deploy another version - this time it will be **green**

```
kubectl set image deployment/cow-update cow=cloudowski/krazy-cow:green --record
```

Wait for deployment to complete anc display history of all deployments
  
```
kubectl rollout history deploy cow-update
```

Finally revert to **blue** version using `undo`

```
kubectl rollout undo deployment cow-update 
```

Try also reverting to first deployed version using `--to-revision` command option.