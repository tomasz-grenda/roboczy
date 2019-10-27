## Run whack-a-pod game

* Clone game repo - [https://github.com/cloudowski/whack_a_pod](https://github.com/cloudowski/whack_a_pod)
* Execute the following commands to create Kubernetes objects

```
#kubectl run api-deployment --image=cloudowski/whackapod-api --replicas=12 --port=8080 --labels=app=api
kubectl  expose deployment api-deployment --name=api --target-port=8080  --type=NodePort --labels="app=api"
kubectl run game-deployment --image=cloudowski/whackapod-game --replicas=4 --port=8080 --labels=app=game
kubectl expose deployment game-deployment --name=game --target-port=8080  --type=NodePort --labels="app=api"
kubectl run admin-deployment --image=cloudowski/whackapod-admin --replicas=1 --port=8080 --labels=app=admin --env="APIIMAGE=cloudowski/whackapod-api"
kubectl expose deployment admin-deployment --name=admin --target-port=8080  --type=NodePort --labels="app=admin"
kubectl create serviceaccount wap-admin
kubectl create clusterrolebinding wap-admin --clusterrole=cluster-admin --serviceaccount=default:wap-admin
kubectl set serviceaccount deployment admin-deployment wap-admin
kubectl apply -f  apps/ingress/ingress.generic.yaml
```


* Patch Ingress to change host name

```
kubectl patch ingress wap-ingress --type=json -p="[{\"op\": \"replace\", \"path\": \"/spec/rules/0/host\", \"value\": \"whackapod.192.168.99.100.nip.io\"}]"
```

After a while you should be able to play your game! You have three options

* [Default mode](http://whackapod.192.168.99.100.nip.io/)
* [Advanced mode 1](http://whackapod.192.168.99.100.nip.io/next.html)
* [Advanced mode 2](http://whackapod.192.168.99.100.nip.io/advanced.html)

**Enjoy!**

## Cleaning up

```
kubectl delete svc,deploy -l app=api 
kubectl delete svc,deploy -l app=game
kubectl delete svc,deploy -l app=admin
kubectl delete serviceaccount wap-admin
kubectl delete clusterrolebinding wap-admin
kubectl delete -f  apps/ingress/ingress.generic.yaml
```
