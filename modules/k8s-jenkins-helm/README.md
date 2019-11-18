## Use Helm to install jenkins

1. Create a dedicated namespace **jenkins**

```shell
kubectl create ns jenkins
```

2. Install jenkins using helm and configuration provided in
[jenkins-values.yaml](jenkins-values.yaml)

Determine the IP address of your minikube with `minikube ip` command and set a proper variable that will be passed to helm (to set up Ingress). For linux/mac you can set set it with the following command:

```shell
JENKINS_HOST=jenkins.$(minikube ip).nip.io
```

Now install jenkins with single helm command

```shell
helm install --namespace jenkins -n jenkins stable/jenkins -f jenkins-values.yaml --set master.ingress.hostName=$JENKINS_HOST
```

3. Configure additional privileges for Jenkins


Allow jenkins to manage Kubernetes objects. 

> NOTICE: This method is insecure and should be used only for testing purposes as it actually grants *"root"* permissions to deployer service account used by Jenkins

```shell
kubectl create sa deployer -n jenkins
kubectl create clusterrolebinding jenkins-deployer-admin --clusterrole=cluster-admin --serviceaccount=jenkins:deployer
```

Look at the message printed by Helm to see login details. Use the to access
jenkins when it's ready.

4. Apply configuration using Configuration-as-Code plugin

Now you will add configuration using ConfigMaps stored in [casc/](casc/). They will be immediately applied by a special sidecar container running alongside Jenkins.

```
kubectl apply -f casc-configmap.yaml -n jenkins
```

5. Logging in

Now log in to your Jenkins with the credentials set in jenkins-values.yaml file (it's *admin/admin*).