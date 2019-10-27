# Docker help

  * [docker cheatsheet](./docker_cheatsheet_r4v2.pdf)

# Kubernetes help

  * [kubectl cheatsheet](https://kubernetes.io/docs/user-guide/kubectl-cheatsheet/)
  * [K8S API reference](https://kubernetes.io/docs/api-reference/v1.13/)

## Useful commands

* Change namespace using `kubectl`

  * For minikube

  ```
  kubectl config set-context minikube --namespace=NAMESPACE_NAME_HERE
  ```

  * For any Kubernetes - detect context name (works only for POSIX shells)

  ```
  kubectl config set-context $(kubectl config current-context) --namespace=NAMESPACE_NAME_HERE
  ```