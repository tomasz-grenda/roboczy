# 1. Using volumes from host directories

Our cows need to eat. Let's provide a pasture so you can grass them.

First we will create a directory on your minikube host with proper permissions
  
```
minikube ssh
sudo -i
mkdir /pasture
chmod -R 777 /pasture/
```

Now create a small herd comprising of 2 cows. Every cow knows the location of pasture - it's by default `/pasture` inside the container. Using `hostPath` volume a directory with the same name from minikube host is mounted there.

```  
kubectl apply -f krazy-herd-hostvol-rs.yaml
```

Now check logs of any of your cows

```
kubectl logs -f cow-hostvol-ax3a2
```

You should notice that cows are getting angry cause they can't find any tuft on pasture. Let's provide them with some! Create a few files that starts with `tuft` in `/pasture` directory

```
minikube ssh touch  /pasture/tuft1
```

Check logs again and see if cows grass and what happens after...


# 2. PVC from NFS server volumes 

Another example of providing volumes is by using **PersistenVolumeClaim**. Let's use it to create a new pasture for your herd. We're going to use NFS server for that.


Start a server defined in [nfs-server/](nfs-server/).

```
kubectl apply -f nfs-server/
```

The server provides nfs service and volumes. Let's define them as **PersistentVolumes**.

```
kubectl apply -f nfs-persistent-volumes.yaml
```

We also need to specify a request with PersistenVolumeClaim object

```
kubectl apply -f pasture-pvc.yaml
```

Finally let's create a new herd that will use a pasture defined as PVC

```  
kubectl apply -f krazy-herd-nfs-rs.yaml
```

Check pv, pvc and rs objects to see if it works

```
kubectl get pv
kubectl get pvc
kubectl get rs
```


(Advanced - finding pasture and providing tufts)

* check which vol has been chosen

```
kubectl get pvc pasture
```

In the following example it's `nfsvol1`

```
NAME      STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS    AGE
pasture   Bound    nfsvol1   3Gi        RWX            green-and-big   2m34s
```

Remeber it - we'll need it later.

* check the location of nfs server directory

```
kubectl get pvc nfs-server
```

Sample output

```
NAME         STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
nfs-server   Bound    pvc-ffbad264-40c5-11e9-8790-080027b201e8   1Gi        RWO            standard       6m46s
```

Check details of the assigned volume

```
kubectl describe pv pvc-ffbad264-40c5-11e9-8790-080027b201e8
```

Look for `Path:` in the output like from the one below

```
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /tmp/hostpath-provisioner/pvc-ffbad264-40c5-11e9-8790-080027b201e8
```

Now create tufts files in volume assigned from nfs server. In our example it's `nfsvol1` which maps to `vol1` subdirectory inside nfs root

```
minikube ssh
sudo chmod 777 -R /tmp/hostpath-provisioner/pvc-ffbad264-40c5-11e9-8790-080027b201e8
cd /tmp/hostpath-provisioner/pvc-ffbad264-40c5-11e9-8790-080027b201e8
sudo touch vol1/tuft{1..99}
```


Check in logs if your cows are happy now and that tufts are being eaten

```
ls -la vol1/
```

You may want to increase the number of cows if some of them were starved because there were no tufts available on pasture.

```
kubectl scale rs cow-nfs --replicas=1
```