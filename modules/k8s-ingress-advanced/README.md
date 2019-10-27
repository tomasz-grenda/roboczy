## Configuring Ingress controller

Ingress controller can be configured using a dedicated ConfigMap.

The easies way is to edit it directly

```
kubectl edit cm -n kube-system nginx-load-balancer-conf
```

and paste the following key under `data` element

```
enable-vts-status: "true"
```

It will reload itself automatically. Now you need a direct access to nginx controller pod - find its id (it's running in `kube-system` namespace) and open a tunnel using port forwarding

```
kubectl port-forward  nginx-ingress-controller-XXXXX 18080:80 -n kube-system
```

Open a browser at [http://localhost:18080/nginx_status](http://localhost:18080/nginx_status) to see statistics.


## Use annotations to configure ingress

Let's add an alias using annotations

```
kubectl annotate ingress fussy-secured nginx.ingress.kubernetes.io/server-alias="www.fussy-secured.MINIKUBE_IP.nip.io"
```

Check in the browser whether your alias with **www.** prefix works.

In similar way you can quickly make a permanent redirect:

```
kubectl annotate ingress fussy-plain nginx.ingress.kubernetes.io/permanent-redirect=https://httpbin.org/headers
```

## Throttling traffic
There are many more options to configure your route with just simple annotations.

This time try to find a way to limit rate for incoming connections to 1 per second using [documentation](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md).
