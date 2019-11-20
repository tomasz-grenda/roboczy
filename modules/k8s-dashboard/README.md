## Access dashboard from minikube

When using minikube you can launch dashboard directly using command

```shell
minikube dashboard
```

Notice it will work only with minikube while first method should work on any Kubernetes cluster.

## Launch a container using dashboard

Make sure you use **default** namespace (see the *Namespace* list on the left pane)

* Click on the **+** button on the right upper Ū
* Choose **Create an app** tab
* Use **ghost:latest** image and name your app **ghost** as well
* Set memory reservation to **100MiB** using advanced options
* Click **Deploy**

Check how many objects have been created. They should be visible in **Overview** pane.

Use the following command to open port `2368` on your host

```shell
kubectl port-forward deploy/ghost 2368:2368
```

and use browser to open [http://localhost:2368](http://localhost:2368).

## Inspect dns and dashboard pods

In **kube-system** namespace check configuration of the following pods:

* coredns

and in **kubernetes-dashboard** namespace check `kubernetes-dashboard` pod.

*Please note they will contain some suffixes, but there will always be a single instance of each of them.*

Please note that they may contain additional suffixes with ids.

Answer the following questions:

* How many containers do they have?
* What images do they use?
* Which of those containers have environment variable defined?

## Access logs

Using dashboard access logs for each container of **coredns** and **kubernetes-dashboard** pods.