## Run yelb - food critic platform

Visit [https://github.com/mreferre/yelb](https://github.com/mreferre/yelb) project page to see YELB architecture. Now you will deploy on Kubernetes. Create a new namespace  **yelb**:

```
kubectl create namespace yelb
```

Deploy it:

```
kubectl apply -f deployments/platformdeployment/Kubernetes/yaml/cnawebapp-minikube-hostport.yaml -n yelb
```

Open your browser at [http://MINIKUBE_IP:32777](http://MINIKUBE_IP:32777) and vote for your favourite meal :-)

Scale **yelb-appserver** deployment and see what pod is serving your request (at the bottom of ui page)

```
kubectl scale deploy/yelb-appserver --replicas=3 -n yelb
```

## Cleaning up

After you're done just delete the **yelb** namespace to save your precious resources

```
kubectl delete ns yelb
```
