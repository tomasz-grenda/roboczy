# Exposing services using Ingress

First prepare your kubernetes by installing necessary Ingress components. Do this by enabling dedicated minikube addon with the following command:

```
minikube addons enable ingress
```

Note that it may take a couple of minutes for ingress components to be ready. You can check the status of deployment to make sure it's running before you proceed with further excercises

```
kubectl get deploy -n kube-system nginx-ingress-controller
```

## Let's talk in private
Start by creating a ReplicaSet using link k8s-ingress/fussy-ingress-plain.yaml[fussy-ingress-plain.yaml]

```
kubectl apply -f fussy-rs.yaml
```

Then attach a service that will expose pods in newly created ReplicaSet - create it with kubectl command line option:

```
kubectl expose rs fussy-rs --port=80 --target-port=8080
```

Create your first, simple ingress. First determine your service hostname - it should be

```
fussy-plain.MINIKUBE_IP.nip.io
```

where MINIKUBE_IP is the ip address of your minikube virtual machine - you can check it with the following command:

```
minikube ip
```

So for IP address `192.168.99.100` it would be `fussy-plain.192.168.99.100.nip.io`

Replace every occurence of `@@HOSTNAME@@` in fussy-ingress-plain.yaml with your generated service hostname.

Then create an ingress object

```
kubectl apply -f fussy-ingress-plain.yaml
```

and open your browser at **http://fussy-plain.MINIKUBE_IP.nip.io** or use curl from your workstation:

You can verify your ingress with get and describe commands

```
kubectl get ingress fussy-plain
kubectl describe ingress fussy-plain
```

## Securing traffic with TLS

We live in dangerous times and thus we need to protect our data so let's enable **https** for our service.

Start with generating private key.

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=fussy-secured.MINIKUBE_IP.nip.io"
```

**Don't forget to replace MINIKUBE_IP with proper ip address**.

Create a dedicated secret with key and certificate

```
kubectl create secret tls fussy-secret --key /tmp/tls.key --cert /tmp/tls.crt
```

Now it's time to create a dedicated ingress for https traffic. Replace every occurence of `@@HOSTNAME@@` in fussy-ingress-secured.yaml with your generated service hostname and apply it

```
kubectl apply -f fussy-ingress-secured.yaml
```

Check the status of ingress using `kubectl get ingress` and `kubectl describe ingress`  commands.

Open your browser at [https://fussy-secured.192.168.99.100.nip.io](https://fussy-secured.192.168.99.100.nip.io)  (your domain may differ if you have different IP address of your minikube vm) - notice it will automatically redirect you to https version.

**Voila!** You just secured your application without touching any configuration inside container!
