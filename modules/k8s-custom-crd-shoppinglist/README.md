# 1. Custom shopping list as CRD

Create `ShoppingList` **CustomResourceDefinition** object

```
kubectl apply -f shopping-list-crd.1.yaml
```

Check if it's been registered as valid api

```
kubectl api-resources|grep shop
```

Create a groceries shopping list instance of `ShoppingList` CRD

```
kubectl apply -f groceries-shoppinglist.yaml
```

Get groceries object details

```
kubectl get shoppinglist
kubectl get sl
kubectl get sl groceries -o yaml
kubectl describe sl groceries
```