# Create a deployment using cli

Launch a container using deployment object with the following command

```
kubectl run fussy --image=cloudowski/fussy-container:0.1
```

Check newly created **fussy** Deployment object using standard `get` and `describe` commands. Notice that by default it runs ony single instance of an app. We can easily change that by scaling it:

```
kubectl scale deployment/fussy --replicas=3
```

# Create deployment using definition from file
Delete previous deployment and create a new one using `fussy-deployment.yaml` file. Change number of replicas in a file to **4** and apply it to increase number of running instances.

Notice that this Depoyment definition contain both **liveness** and **readiness** probe.

Create a service for testing purposes

```
kubectl expose deployment/fussy --port=80 --target-port=8080
```

# Perform rolling update
Now we are ready to perform rolling update. To make it more visible scale your deployment first to **10** replicas

Create a test pod in a separate terminal from which you will issue requests to the service.

```
kubectl run testdeployment --image=alpine -ti --restart=Never  --rm=true -- sh -c 'while :;do wget -T1 -q -O- fussy|grep Version ;sleep 0.5;done'
```

Next update your deployment object by setting image to newer version (**0.3**) and check if they have been updated and new version of webpage is available. Use the following command:

```
kubectl set image deployment/fussy fussy=cloudowski/fussy-container:0.3
```

Useful commands:

  * `kubectl rollout status deployment fussy -w`
  * `kubectl rollout history`
