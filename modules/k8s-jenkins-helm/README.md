## Use Helm to install jenkins

Create a dedicated namespace **jenkins**

```
kubectl create ns jenkins
```
Install jenkins using helm and configuration provided in
[jenkins-values.yaml](jenkins-values.yaml)

```
helm install --namespace jenkins -n jenkins stable/jenkins -f jenkins-values.yaml
```

Look at the message printed by Helm to see login details. Use the to access
jenkins when it's ready.

Create a configmap for *Configuration as Code* Jenkins plugin

```
kubectl apply -f casc-configmap.yaml -n jenkins
```
