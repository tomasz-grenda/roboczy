## Getting basic info
Let's start with getting basic info on resources available in our cluster. We will use `get` command to retrieve it from Kubernetes. First see what resources can we get using our **default** namespace

```
kubectl get all
```

Below you will find a list of most common Kubernetes objects. You can also list all available resources using `kubectl api-resources` command.

```
* all
* certificatesigningrequests (aka 'csr')
* clusterrolebindings
* clusterroles
* componentstatuses (aka 'cs')
* configmaps (aka 'cm')
* controllerrevisions
* cronjobs
* customresourcedefinition (aka 'crd')
* daemonsets (aka 'ds')
* deployments (aka 'deploy')
* endpoints (aka 'ep')
* events (aka 'ev')
* horizontalpodautoscalers (aka 'hpa')
* ingresses (aka 'ing')
* jobs
* limitranges (aka 'limits')
* namespaces (aka 'ns')
* networkpolicies (aka 'netpol')
* nodes (aka 'no')
* persistentvolumeclaims (aka 'pvc')
* persistentvolumes (aka 'pv')
* poddisruptionbudgets (aka 'pdb')
* podpreset
* pods (aka 'po')
* podsecuritypolicies (aka 'psp')
* podtemplates
* replicasets (aka 'rs')
* replicationcontrollers (aka 'rc')
* resourcequotas (aka 'quota')
* rolebindings
* roles
* secrets
* serviceaccounts (aka 'sa')
* services (aka 'svc')
* statefulsets (aka 'sts')
```

You can now get list of particular resources e.g. all services

```
kubectl get service
```

Often you will have a short version (look for `aka` in the list you got previusly) so you can save your fingers by typing

```
kubectl get svc
```

To get info on a specific resource name just add it after its type e.g.

```
kubectl get svc kubernetes
```

### Different namespaces

Often objects live in different namespaces than your currently used and you may want to access them as well. All you need to do is to add another option. For example to list all pods in **kube-system** namespace you need to type

```
kubectl -n kube-system get pod
```

How to get objects from **ALL** namespaces? Just use `--all-namespaces` option

```
kubectl get pod --all-namespaces
```

### YAML shows you more

If you want to get more detailed info in *raw* version (see below for more user-friendly) you can change format to YAML. This way enables you to see *Status* field that is often helpful during troubleshoot. For example to get YAML version of kubernetes service you can use the following command:

```
kubectl get -o yaml svc kubernetes
```

## TIP for bash (and zsh) users - enable completion

If you use bash you can use bash completion feature to speed up your work in cli. Just type

```
source <(kubectl completion bash)
```

This will enable it for your current session. For more advanced scenarios (inclduing zsh version) see bultin help: `kubectl completion -h`

## I want more details
More often you will need more info about particular resource and the best way to get it is to use `describe` command. It is similar to `get` so you need to provide type of the resource and its name.  So for example to get more info on kubernetes service just use the following command

```
kubectl describe svc kubernetes
```

Try that with one of the pods from **kube-system** namespace.

## Events for troubleshooting
Kubernetes emits many events that are useful for troubleshooting. You can access them like any other resource:

```
kubectl get ev -w
```

This additional `-w` option will get you all of the events as they appear in the system.

Events are also namespace scoped so you need to provide a specific namespace or get them from all:

```
kubectl get ev --all-namespaces
```

## Creating objects directly
There are two ways of creating objects in Kubernetes:

* First is by using YAML (or JSON) files and then to use `kubectl apply` (or `create`,`replace`) commands
* Second is by using command line directly

For example to create a dummy service without a single line of YAML you can type

```
kubectl create service nodeport mysvc --tcp=12345:12345
```

This is very convenient - especially in scripts or if you want to check something quickly.
Not all objects however can be created that way. Actually only a small part of them. For list of objects you can create with cli see `kubectl create -h`.


## Adding labels and annotations to objects

To add a label from a cli use `label` command. For example to add a label **owner** to a service:

```
kubectl label svc mysvc owner="Johnny-Bravo"
```

Similarily annotations can be added wth the following command

```
kubectl annotate svc mysvc zones="eu, us, asia"
```

Check the details of the service using describe command

```
kubectl describe svc mysvc
```

## Deleting objects

That one is quick - use `delete` command. To delete previously created service use the following command

```
kubectl delete svc mysvc
```

## Builtin documentation

You can get more info on resources based on their API with `explain` command. To "explain" how to use service resource type

```
kubectl explain svc --recursive
```

Quite a lot if info ther and verbose too. You may find easier to look at web version with links, but this will do for some quick check up.
