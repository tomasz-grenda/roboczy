# Configure with environment variables

Krazy Cow accepts configuration from environment variables. 

Launch a container from [cow-env-configure-pod.yaml](cow-env-configure-pod.yaml) definition file with `KC_LOGGING_LEVEL` environment set to `DEBUG`

```
kubectl apply -f cow-env-configure-pod.yaml
```

You should see all the logs including debug messages - check it in the log output 

```
kubectl logs -f cow-env-configure
```

Now change the value of `KC_LOGGING_LEVEL` to `NOTICE` in manifest file (`cow-env-configure-pod.yaml`) and recreate a pod

```
kubectl delete pod cow-env-configure
kubectl apply -f cow-env-configure-pod.yaml
```

You should see less messages than before, as container now send `NOTICE` verbosity level logs.

# Configure with ConfigMap as file

The Krazy Cow app also accepts values from traditional file in yaml format. 

Create a configuration file named `cowconfig.yaml` for it with the following content:

```
cow:
    initmood: 20
    moodchanger:
        enabled: true
        interval: 5
        change: -1
```

Create a ConfigMap from that file

```
kubectl create configmap cowconfig  --from-file=cowconfig.yaml
```

The ConfigMap object has been created and is available in Kubernetes. Verify its content:

```
kubectl get configmap cowconfig -o yaml
```

Now launch a new pod which will use the data stored in the ConfigMap

```
kubectl apply -f cow-file-configure-pod.yaml
```

Now this new cow has a *moodchanger* enabled which will cause a gradual decrease it mood. If it reaches a level below a *"happiness"* threshold it will start to serve errors on `/healthz` endpoint causing restarts of the container (livenessProbe will start failing).

```
kubectl logs -f cow-file-configure
```
