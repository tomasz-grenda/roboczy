# 1. Trap a cow in a container image

**1)** Clone a repo with code [https://gitlab.com/cloudowski/krazy-cow](https://gitlab.com/cloudowski/krazy-cow)

**2)** Open `web/templates/index.html` file and change body style - use different color for background, text or ad custom style. You can also may want to change other components: color of the grass, font type, alignment or other.

**3)** Build version **1.0**

```
docker build --build-arg VERSION=1.0 -t krazy-cow:1.0  .
```

**4)** Check if it works by run it it locally

```
docker run -ti -p 8080:8080 krazy-cow:1.0
```

and open browser at [http://localhost:8080](http://localhost:8080).

**5)** Add a registry and repository name by adding it with a `docker tag` command and push it to your container registry.