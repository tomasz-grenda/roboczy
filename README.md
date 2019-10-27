# Modules

## Introduction

* [Tools you need](quests/1.md)
* [More help](help.md)

---

## 1. Docker basics

**Exercises**

* 1.1 Install docker - [docker-basics/docker-installation](modules/docker-basics/docker-installation) (or [docker-basics/docker-installation-vagrant](modules/docker-basics/docker-installation-vagrant) if you're having problems with your workstation)
* 1.2 Basic operations with docker cli - [docker-basics/docker-basics-1](modules/docker-basics/docker-basics-1)

---

## 2. Running containers with docker

**Exercises**

* 2.1 More docker cli - [docker-basics/docker-basics-2](modules/docker-basics/docker-basics-2)
* 2.2 Configure containers with environment variables - [docker-basics/docker-config-with-env](modules/docker-basics/docker-config-with-env)
* 2.3 Expose applications ports - [docker-basics/docker-network-ports](modules/docker-basics/docker-network-ports)
* 2.4 Deploy Portainer GUI for docker - [docker-basics/docker-portainer](modules/docker-basics/docker-portainer)
* 2.5 Limiting resources - [docker-basics/docker-limit-resources](modules/docker-basics/docker-limit-resources)

---

## 3. Providing configuration and storage for containers

**Exercises**

* 3.1 Using host volumes - [docker-basics/docker-feeding-krazycow](modules/docker-basics/docker-feeding-krazycow)
* 3.2 Upgrade application using new container image - [docker-basics/docker-gogs-update](modules/docker-basics/docker-gogs-update)
* 3.3 Deploy wordpress using containers - [docker-basics/docker-wordpress](modules/docker-basics/docker-wordpress)

---

## 4. Building container images

**Exercises**

* 4.1 Building new container image based on other container - [docker-build/docker-build-from-container](modules/docker-build/docker-build-from-container)
<!-- * [docker-build-php](modules/docker-build-php) -->
* 4.2 Different approaches to building container images from Dockerfiles - [docker-build/docker-build-flaskapp](modules/docker-build/docker-build-flaskapp)
* 4.3 Publishing container images - [docker-build/docker-publish](modules/docker-build/docker-publish)
* 4.4 Building a container image with *krazy-cow* app - [docker-build/docker-build-krazycow](modules/docker-build/docker-build-krazycow)

**Quests!**

* [2](quests/2.md)
* [3](quests/3.md) ([solution](quests/solutions/3/))

---

## 5. Building container images - part 2

**Exercises**

* 5.1 Multistage builds - [docker-build/docker-multistage-build](modules/docker-build/docker-multistage-build)
* 5.2 Building Jenkins container image - [docker-build/docker-build-jenkins](modules/docker-build/docker-build-jenkins)
* 5.3 Building and running a game from container -  [docker-build/docker-croc-hunter](modules/docker-build/docker-croc-hunter)

**Quests!**

  * [4](quests/4.md) ([solution](quests/solutions/4/))

---

## 6. Kubernetes architecture and overview

**Exercises**

* 6.1 Kubernetes web dashboard introduction - [k8s-dashboard](modules/k8s-dashboard)
* 6.2 `kubectl` introduction - [k8s-cli-basics](modules/k8s-cli-basics)

---

## 7. Managing Kubernetes objects

**Exercises**

* 7.1 Launching krazy-cow app inside a pod - [k8s-launch-krazycow](modules/k8s-launch-krazycow)
* 7.2 Using healthchecks - [k8s-pod-healthcheck](modules/k8s-pod-healthcheck)
* 7.3 Using healthchecks (http) [k8s-krazycow-healthcheck](modules/k8s-krazycow-healthcheck)
* 7.4 Simple game - [k8s-coin-tossing-game](modules/k8s-coin-tossing-game)

---

## 8. Providing configuration to a Pod

**Exercises**

* 8.1 Configure krazy-cow app with `ConfigMap` - [k8s-configure-cow](modules/k8s-configure-cow)
* 8.2 Using `Secret` objects - [k8s-secret-cow](modules/k8s-secret-cow)


**Quests!**

* [5](quests/5.md) ([solution](quests/solutions/5/))
* [6](quests/6.md) ([solution](quests/solutions/6/))

---

## 9. Internal and external communication in Kubernetes (Service)

**Exercises**

* 9.1 Exposing an app with `Service` object - [k8s-service-pod](modules/k8s-service-pod)


---

## 10. Scaling pods (ReplicaSet)

**Exercises**

* 10.1 Scaling pods with `ReplicaSet` - [k8s-scaling-pods](modules/k8s-scaling-pods)
* 10.2 Running simple, scalable app -  [k8s-yelb](modules/k8s-yelb)
* 10.3 ReadinessProbe -  [k8s-readinessprobe](modules/k8s-readinessprobe)

**Quests!**

* [7](quests/7.md) ([solution](quests/solutions/7/))
* [8](quests/8.md) ([solution](quests/solutions/8/))
  
---

## 11. Storing data on persistent volumes (PersistentVolume, PersistentVolumeClaim)

**Exercises**

* 11.1 Shared volumes inside a pod - [k8s-pod-shared-volume](modules/k8s-pod-shared-volume)
* 11.2 Providing storage to krazy-cow app - [k8s-krazycow-pasture](modules/k8s-krazycow-pasture)
* 11.3 Checking resilience for stateful apps - [k8s-krazycow-dairy](modules/k8s-krazycow-dairy)

**Quests!**

* [9](quests/9.md) ([solution](quests/solutions/9/))

---

## 12. Exposing http services (Ingress)

**Exercises**

* 12.1 Configure `Ingress` for web app - [k8s-ingress](modules/k8s-ingress)
* 12.2 `Ingress` advanced configuration - [k8s-ingress-advanced](modules/k8s-ingress-advanced)

**Quests!**

* [10](quests/10.md) ([solution](quests/solutions/10/))

---

## 13. Managing application deployment from code (Deployment)

**Exercises**

* 13.1 Update an krazy-cow app in rolling-update style - [k8s-krazycow-update](modules/k8s-krazycow-update)
* 13.2 Performing update in blue-green style - [k8s-blue-green](modules/k8s-blue-green)

**Quests!**

* [11](quests/11.md) ([solution](quests/solutions/11/))
* [12](quests/12.md) ([solution](quests/solutions/12/))
* [13](quests/13.md) ([solution](quests/solutions/13/))

## 14. Installing apps using Helm and Charts

**Exercises**

* 14.1 Helm introduction - [k8s-helm-intro](modules/k8s-helm-intro)

---

## 15. Basic monitoring and logging

**Exercises**

* 15.1 Prometheus introduction - [k8s-prometheus](modules/k8s-prometheus)
