#!/usr/bin/env bash
kubectl run ubuntu --image=ubuntu -ti --restart=Never  --rm=true -- /bin/bash
