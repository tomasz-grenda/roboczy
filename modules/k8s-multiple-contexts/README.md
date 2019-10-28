# Merge kubectl config files

Download `kubeconfig` file and save it somewhere on your disk - in the following
example it would be `/tmp/kubeconfig`. 
Then set your `KUBECONFIG` to include both your default kubeconfig and
additionally your previously downloaded file:

> (Linux/Mac)

```shell
export KUBECONFIG=~/.kube/config:/tmp/kubeconfig
```

> (Windows with CMD) [TO BE TESTED]

```shell
set KUBECONFIG=%USERPROFILE%/.kube/config:/c/tmp/kubeconfig
```

Then merge these two files into single one and save the output to your default
`kubeconfig` file

(Linux/Mac)

```shell
kubectl config view --merge --raw > ~/.kube/config
```

Now in every session you will have access to all contexts.


# Change default context

To use a different context you need to set it as default. 

```shell
kubectl config set-context CONTEXT_NAME
```

To change context set by minikube just type

```shell
kubectl config set-context minikube
```

## Change default namespace

To change the default namespace use the following command

```shell
kubectl config set-context $(kubectl config current-context) --namespace=NAMESPACE_NAME_HERE
```
