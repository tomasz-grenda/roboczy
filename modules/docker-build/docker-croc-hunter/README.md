## Croc Hunter Game

Let's build a simple game that you can launch from a contaner. Follow these steps to run it on your host.


* Install golang

```
sudo apt install golang
```

* Clone repostiory with the game

```
git clone https://github.com/lachie83/croc-hunter
```

* Set your docker image name by exporting a variable (see `Makefile` content for details)

```
export DOCKER_IMAGE=croc-hunter
```

* Build a game and container with `make`

```
make
```

* Finally launch it with a port forwarding set to port 8080 and a `TAG` created during a build process (look at last lines produced by make)

```
docker run -ti -p8080:8080 -d croc-hunter:TAG
```
