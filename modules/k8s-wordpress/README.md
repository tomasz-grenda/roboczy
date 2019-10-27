## Run wordpress
Run wordpress with database. Expose mysql as **ClusterIP** service and wordpress as **LoadBalancer**. Use **Secret** object to store information about mysql password. Use **PersistentVolume** for mysql **/var/lib/mysql** directory.
