# Coin tossing game

Use **coin-toss-pods.yaml** to create a set of pods. There's a 50% chance for each pod that it will crash after **9.58s** (that is the time it takes Usain Bolt to run 100m :-) ).

> See how many of your pods will survive!

## Start game
To start it apply pod definitions:

```
kubectl apply -f coin-toss-pods.yaml
```

To delete pods use labels:

```
kubectl delete pod -l app=coin-toss
```

## Increase number of pods

To change number of pods just copy pod definition inside yaml - don't forget to change pod's name!

Try with **8 pods** and check if you're lucky ;-)
