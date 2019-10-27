# Mounting volumes

There are many volume types available in Kubernetes. In this exercise you will use some of them to learn how to make them available for all containers in a pod and mount them selected ones.

## Using volume from the host directory

Let's start with the simplest volume - mounting directory from the host.

Have a look at `pod-volume-host.yaml` and see what directory from minikube host is used to create this pod - it should be defined as a value for `spec.volumes.hostPath.path` key. This directory will be availabe on a pod in a slightly different location - have a look at `spec.containers.volumeMounts`.

Use `minikube ssh` to log in to your Kubernetes node and create some files in that directory.

Now run a pod

```
kubectl apply -f pod-volume-host.yaml
```

and check whether the files you have created are visible inside a container. 

```
kubectl exec -ti testvol sh
```

## Pod metadata as a volume

Volumes can also be used to read pod`s metadata using `downwardAPI` volume type.

Use `pod-volume-api.yaml` to create a pod and check the content of the **podinfo** volume from inside a container. 

First create a pod

```
kubectl apply -f pod-volume-api.yaml
```

Then use exec to get inside of the pod

```
kubectl exec -ti testvol-api sh
```

Now you should be able to read annotations and labels using plain files mounted there (check mount path in the pod definition).

## Persistent volume and claim - static

This time you will use **PersistenvVolume (PV)** object to define volume for and **PersistenvVolumeClaim (PVC)** to use it in a pod.

Create a proper directory on your Kubernetes node to match a *hostPath* directory defined in `pv-host.yaml`.

Log in to minikube

```
minikube ssh
```

and create `/pv1` directory 

```
sudo mkdir /pv1
```

Then create a `PersistentVolume` object

```
kubectl apply -f pv-host.yaml
```

and check its status using kubectl **get** and **describe** commands

```
kubectl get persistentvolume pv1
kubectl describe persistentvolume pv1
```

Now create a **PersistentVolumeClaim (PVC)** object using `pvc-host1.yaml` file

```
kubectl apply -f pvc-host1.yaml
```

See the status of your previously created PersistentVolume - note that it's been claimed by your PVC and no other PVC can use it unless it's released and available to reuse.

Finally create a pod that will use a volume from PVC - use definition from `pod-volume-pvc1.yaml`.

```
kubectl apply -f pod-volume-pvc1.yaml
```

When it's ready create a `test.txt` file from inside a container in a directory that's been mounted using PVC. Then delete whole pod

```
kubectl delete pod podvol-pvc1
```

and log in to your kubernetes host to check if your file still exists in a PV directory (`/pv1` on the host).


Delete also `pvc-host1` PersistentVolumeClaim object

```
kubectl delete pvc pvc-host1
```

and see the status of the `pv1` PV object.

```
kubectl describe pv pv1
```

> Do you think you could reuse it now for another pod? Try to create PVC using the same file and even start the same pod.


## GIT repository as a volume

Start by creating a pod with git volume

```
kubectl apply -f gitrepo-vol.yaml
```

Now create a port forwarding

```
kubectl port-forward gitserver 8080:80 &
```

Then connect to it using your browser on [http://localhost:8080](http://localhost:8080). Check whether the git repository is
available at **/git** url
