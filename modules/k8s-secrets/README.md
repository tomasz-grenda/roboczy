# Accessing Secrets

## Environment variables

There are many ways to access values from Secret. First is via environment variables and the second is by mounting it inside container.

First let's create a secret from literal values for user and password accordingly

```
kubectl create secret generic nginx-secret --from-literal=NGINX_USER=JohnnyBravo --from-literal=NGINX_PASS=R4nd0m
```

Use `describe` and `get` (with yaml format)  to see details of newly created secret object. Can you read those values? If not then try to decode them using **base64**.


Next create a pod with a environment variables read from this secret

```
kubectl apply -f nginx-pod.yaml
```

Use **exec** command to log in and check if you are able to see **NGINX_* **
environment variables.

## Secret as a volume

The second, more interesting way of accessing Secret is by using volume.

Let's create a keypair first. Execute the following commands from your workstation to generate them with openssl

```
H=secure-nginx.$(minikube ip).nip.io
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/nginx-tls.key -out /tmp/nginx-tls.crt -subj "/CN=$H"
```

Then create a special secret from generated files

```
kubectl create secret tls nginx-certs --key /tmp/nginx-tls.key --cert /tmp/nginx-tls.crt
```

Use **describe** and **get -o yaml** to inspect the content of the secret.

Next create a new pod with a secret mounted as a volume

```
kubectl apply -f nginx-pod-certs.yaml
```

Apply changed file

Confirm that you can see `tls.crt` and `tls.key` files inside a container in `/etc/nginx/secret` directory.
