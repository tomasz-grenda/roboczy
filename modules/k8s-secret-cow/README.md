# Enabling https endpoint with Secret as a file

Create a pair of tls cert and key using openssl

> **NOTICE: If you don't have openssl then you can use certificates in [../../ssl/](../../ssl/) directory.**

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cow-tls.key -out cow-tls.crt -subj "/CN=krazycow"
```

Then create a special secret from generated files

```
kubectl create secret tls cow-tls --key cow-tls.key --cert cow-tls.crt
```

Launch a cow pod with https enabled:

```
kubectl apply -f cow-https-pod.yaml
```

Enable port forwarding and check both http [http://localhost:8080](http://localhost:8080) and https [https://localhost:8443](https://localhost:8443) endpoints

```
kubectl port-forward cow-https 8443:8443 8080:8080
```

# Securing endpoint with basic authentication

Krazy Cow has a special endpoint `/setfree` which can be used to set it free (i.e. killing the container). It is unprotected and can be used by malicious people to harm your herd.

Let's protect it with basic http authentication. In file [cow-auth-secret.yaml](cow-auth-secret.yaml) there is a definition of a Secret with username and password in clear-text form.

Create a Secret object

```
kubectl apply -f cow-auth-secret.yaml
```

and launch a secured instance of cow container

```
kubectl apply -f cow-https-auth-pod.yaml
```

You should find in log output an information about secured access to /setfree

```
NOTICE Securing access to /setfree endpoint with basic http authentication
```

> **(Optional)**

Use port-forwarding and curl to set your cow free. Here's a sample curl command you can use:

```
curl -XPOST  https://LOGIN:PASS@localhost:8443/setfree
```

