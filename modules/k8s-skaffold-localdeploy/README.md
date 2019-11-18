## Testing a container with container-structure-test

> NOTICE: This works only on Linux or Mac platform

First download [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test) tool and place it somewhere in your $PATH (e.g. /usr/local/bin). Then create a directory `test/` and copy there a [test/tests-config.yaml]([test/tests-config.yaml)

Add additional configuration to your `skaffold.yaml` file:

```yaml
test:
    - image: bookinfo-productpage
      structureTests:
          - ./test/*

```

Now each build should perform tests defined there.

You can also run it using container-structure-test tool directly:

```shell
container-structure-test test -c test/tests-config.yaml  -i bookinfo-productpage:GENERATED_TAG
```

## Deploying on Minikube using yaml manifests

After you build your container image you may probably want to deploy it on your Minikube instance. Copy them from [k8s/]([k8s/) (copy the whole directory) to your workplace where you saved your `skaffold.yaml` file. Then rerun your pipeline with `skaffold dev` and check if *Deployment* and *Service* objects have been created on your Minikube instance.

## Getting inside your container with port-forward

You can easily get to your applications without complex Ingess or other configuration. Just use port-forward feature of skaffold. In order to use it you need to add another section to your `skaffold.yaml` file:

```yaml
portForward:
    - resourceName: details
      resourceType: Deployment
      port: 9080
      localPort: 9080
```

You need to also add additional flag to the skaffold:

```shell
skaffold dev --port-forward
```

This will make your application visible at [http://localhost:9080](http://localhost:9080).
