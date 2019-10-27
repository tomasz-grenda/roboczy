# Quick guide

* Clone [https://github.com/lucky-sideburn/KubeInvaders](https://github.com/lucky-sideburn/KubeInvaders)
* Replace in **kubernetes/kubeinvaders-ingress.yml** `kubeinvaders.org` with `invaders.YOUR_MINIKUBE_IP.nip.io`

* Create new namespace for invaders

```
kubectl create ns foobar
```

* Create game resources

```
kubectl apply -f kubernetes/kubeinvaders-namespace.yml
kubectl apply -f kubernetes/kubeinvaders-deployment.yml -n kubeinvaders
kubectl expose deployment  kubeinvaders --type=ClusterIP --name=kubeinvaders -n kubeinvaders --port 8080
kubectl apply -f kubernetes/kubeinvaders-ingress.yml -n kubeinvaders
kubectl create sa kubeinvaders -n foobar
kubectl apply -f kubernetes/kubeinvaders-role.yml
kubectl apply -f kubernetes/kubeinvaders-rolebinding.yml

TOKEN=`kubectl describe secret $(kubectl get secret -n foobar | grep 'kubeinvaders-token' | awk '{ print $1}') -n foobar | grep 'token:' | awk '{ print $2}'`

kubectl set env deployment/kubeinvaders TOKEN=$TOKEN -n kubeinvaders
kubectl set env deployment/kubeinvaders NAMESPACE=foobar -n kubeinvaders

# NOTICE - please change it accordingly to match your IP address
kubectl set env deployment/kubeinvaders ROUTE_HOST=invaders.YOUR_MINIKUBE_IP.nip.io -n kubeinvaders
```

* Open the game webpage - **https://invaders.YOUR_MINIKUBE_IP.nip.io**
* Create pool of invaders

```
kubectl create deployment invaders --image=nginx:alpine -n foobar
```

* Set number of invaders

```
kubectl scale deployment invaders --replicas=10 -n foobar
```


* Enjoy!