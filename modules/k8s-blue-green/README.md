# Blue-Green deployments

A step-by-step tutorial on how to get a blue-green deployment.

# Deploying blue app
Start with creating *blue* deployment

``` 
kubectl apply -f fussy-deployment-blue.yaml
``` 

and a main service used by clients

``` 
kubectl apply -f fussy-svc.yaml
``` 

Create also a separate services for blue and green deployments

``` 
kubectl apply -f fussy-svc-blue.yaml
kubectl apply -f fussy-svc-green.yaml
``` 

Create a test pod in a separate terminal from which you will issue requests to the service.

```
kubectl run testpod -ti --rm --image=alpine sh 
```

From a **testpod** check the service

```
wget -qO- fussy
```

You should see proper responses from *blue* app version.

## Deploying green app

Now we'll modify service to make sure only *blue* app responds 

```
kubectl patch svc fussy -p "{\"spec\":{\"selector\": {\"app\": \"fussy\", \"deploy\": \"blue\"}}}"
```

And finally deploy *green* app

```
kubectl apply -f fussy-deployment-green.yaml
```

From a **testpod** verify whether our service responds properly and only blue app serves those requests

```
wget -qO- fussy
```

Verify also that *green* app is ready

```
wget -qO- fussy-green
```

## Switching to green


To switch a service to *green* app only issue the following command which changes our main service

```
kubectl patch svc fussy -p "{\"spec\":{\"selector\": {\"app\": \"fussy\", \"deploy\": \"green\"}}}"
```

Verify from a **testpod** 

```
wget -qO- fussy
```

## Rollback to blue


To switch back to to *blue* app only issue the following command

```
kubectl patch svc fussy -p "{\"spec\":{\"selector\": {\"app\": \"fussy\", \"deploy\": \"blue\"}}}"
```
