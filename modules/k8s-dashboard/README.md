## Launch proxy

Use the following command to launch a proxy in background that will allow you to access internal services, including dashboard

```shell
kubectl proxy &
```

and use [http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/) to connect to dashboard.

## Access dashboard from minikube

When using minikube you can launch dashboard directly using command

```shell
minikube dashboard
```

Notice it will work only with minikube while first method should work on any Kubernetes cluster.

## Launch a container using dashboard

Make sure you use **default** namespace (see the *Namespace* list on the left pane)

* Click on the **Create** button on the right upper corner
* Choose **Create an app** tab
* Use **ghost:latest** image and name your app **ghost** as well
* Set memory reservation to **100MiB** using advanced options
* Click **Deploy**

Check how many objects have been created. They should be visible in **Overview** pane.

Use the following command to open port `2368` on your host

```
kubectl port-forward deploy/ghost 2368:2368
```

and use browser to open [http://localhost:2368](http://localhost:2368).

## Inspect dns and dashboard pods

In **kube-system** namespace check configuration of the following pods:
  * coredns
  * kubernetes-dashboard

*Please note they will contain some suffixes, but there will always be a single instance of each of them.*

Please note that they may contain additional suffixes with ids.

Answer the following questions:
  * How many containers do they have?
  * What images do they use?
  * What is the IP address of container running **dnsmasq**?
  * What is the IP of the kube-dns service?
  * Which of containers have environment variable defined?

## Access logs
Using dashboard access logs for each container of **kube-dns** and **kubernetes-dashboard** pods.
