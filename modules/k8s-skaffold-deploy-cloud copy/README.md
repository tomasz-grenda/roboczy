## Deploying to an external Kubernetes cluster with skaffold profile

Let's extend our development pipeline and deploy our application to other Kubernetes cluster. You need to add additional section to your `skaffold.yaml` file:

```yaml
profiles:
    - name: cloud
      activation:
          - kubeContext: !minikube
```

This new profile will be activated when you launch skaffold with a different kubectl config set. Skaffold will also stop using Docker inside Minikube so either you need to have a local Docker running or force using it. Run 

```shell
minikube docker-env
``` 

to see how to set your environment to use Docker on Minikube. For Linux and Mac you would need to run `eval $(minikube docker-env)` and then every `docker` command would be run on your Minikube instance.

You need to also push your images to some external repository that would be reachable by your external Kubernetes cluster. You can do it with an additional option passed to skaffold:


```shell

skaffold dev --port-forward --default-repo registry.app.labs.k8sworkshops.com/YOUR_REPO
```

The best part of it is that it will add the repository part to all other configuration (including yamls!). 
That's all - now you have your development pipeline ready!
