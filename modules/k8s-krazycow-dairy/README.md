# 1. Keeping state in external service with persistent storage

After cows are fed they produce milk. It's time to provide a dairy to pick up a milk.

Dairy is implemented as **redis** container (see [redis/](redis)) with volume attach via PVC. We want to create a central dairy so we deploy it in a dedicated namespace
  
```  
kubectl create namespace dairy
kubectl apply -f redis/
```

Create a pasture directory on your minikube host with proper permissions and initialize it with tufts
  
```
minikube ssh
sudo mkdir /meadow
sudo chmod -R 777 /meadow/
touch  /meadow/tuft{1..50}
```

Now create a small herd comprising of 2 cows. Every cow knows the location of pasture - it's by default `/pasture` inside the container. Using `hostPath` volume a directory with the same name from minikube host is mounted there.

```  
kubectl apply -f krazy-herd-hostvol-rs.yaml
```

Now check logs of any of your cows

```
kubectl logs -f cow-milk-ax3a2
```

Milk produced by them should be sent to a dairy (redis) 

```
INFO Milk produced and sent to shepherd
```

Now check whether you see any data in redis. 

Find a redis pod in *dairy* namespace

```
kubectl get pod -n dairy

NAME                                READY   STATUS    RESTARTS   AGE
redis-persistent-76dbff7ff6-mzbld   1/1     Running   0          11m
```

Connect to it

```
kubectl -n dairy exec -ti redis-persistent-76dbff7ff6-mzbld sh
```

Check stored data with the following commands

* List all milk units produced by each cow
  
```
redis-cli --raw hgetall dairy|sed 'N;s/\n/,/'
```

* Count all milk stored in the dairy

```
redis-cli --raw hgetall dairy|sed 'N;s/\n/,/'|awk -F, '{s+=$2} END {print s}'
```

# 2. Check data resiliency

Additionally check how persistent volumes help in creating resilient solutions. In our case we have a redis with data volume attached to it. Let's destroy the container and see if data persist after the crash.

```
kubectl -n dairy delete pod --all
```

Now use the previous commands to get into a new redis container and see if milk is still there.

