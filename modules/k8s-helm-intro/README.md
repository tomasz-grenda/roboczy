# Install Helm

Simply follow the instructions on [Helm site](https://docs.helm.sh/using_helm/#installing-helm) and install **helm** client on the station you've already installed **kubectl**.

## Initialize Tiller

You must *initialize* server part of Helm - **Tiller** by issuing the following command

```
helm init
```

After a minute or so you should be able to issue helm commands - for example checking version of both client and server (tiller component) versions

```
# helm version

Client: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
```

## Adding Incubator repository

Many applications are placed in **incubator** Helm repository and thus are not available by default. Let's add this repository to have more Charts to choose from

```
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
```

Now sync our repositories

```
helm repo update
```

That's it - you're now ready to use Helm and install apps using Charts!

## Installing your first app

### Dokuwiki - default settings

Install dokuwiki from stable repository with default settings provided by Chart's developers

```
helm install stable/dokuwiki
```

Notice that under **NOTES** section of helm's output you will find command to help you determine URL and password. Unfortunately dokuwiki uses *LoadBalancer* service type by default and you won't be able to use it on your minikube cluster.

Check installed releases of your Charts

```
helm ls
```

You should see something similar to this one:

```
NAME       	REVISION	UPDATED                 	STATUS  	CHART         	APP VERSION            	NAMESPACE
jazzy-heron	1       	Sat Sep 29 21:57:03 2018	DEPLOYED	dokuwiki-3.0.1	0.20180422.201805030840	default
```

You can check the status of your installed release with the following command (change *jazzy-heron* with your release name)

```
helm status jazzy-heron
```

### Dokuwiki - custom settings

Let's install a second release of dokuwiki - this time with our own settings. You will use [dokuwiki-values.yaml](dokuwiki-values.yaml) file that configures *Ingress* and other parameters. Adjust it to your needs and install Dokuwiki with your own release name

```
helm install stable/dokuwiki -n dokuwiki -f dokuwiki-values.yaml
```

After a while you should be able to view Dokuwiki page - [http://wiki.192.168.99.100.nip.io](http://wiki.192.168.99.100.nip.io). Use login and password provided in your config file (*dokuwiki-values.yaml*).

You might decide to delete previous release of dokuwiki - just use delete command, but also include `--purge` option

```
helm delete --purge jazzy-heron
```

### GOGS

In the same way you can install your own Git site with **GOGS**. Use [gogs-values.yaml](gogs-values.yaml) to enable Ingress and define your own release name

```
helm install incubator/gogs -n git -f gogs-values.yaml
```

Similarly you can access it via Ingress - [http://git.192.168.99.100.nip.io](http://git.192.168.99.100.nip.io)
