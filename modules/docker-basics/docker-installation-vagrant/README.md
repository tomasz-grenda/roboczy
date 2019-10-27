# Requirements

You need to install [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) before proceeding.

# 1. Run your VM using Vagrant

Download [Vagrantfile](../../vagrant/Vagrantfile) on your host and in the directory where you've downloaded it just type the following command to create virtual machine

```
vagrant up
```

After it's started you can log in to it using `vagrant ssh` command. It already should have docker installed using provisioning described in Vagrantfile.

# 2. Run first container

See the output of the following command to see if your Docker works

```
docker run hello-world
```

# 3. Pull images

Use `docker pull` to download the following images:
  * alpine
  * ubuntu
  * nginx
