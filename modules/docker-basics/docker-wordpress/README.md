# 1. Launching Wordpress with a database - docker commands

It's time to create something more complex. We're going to build a wordpress solution using two containers - **mysql** database and **wordpress** official image.

First create directories for data

```
mkdir wpdb wp
```

Then start mysql

```
docker run -e MYSQL_ROOT_PASSWORD=w0rdpr3ss --name wpdb -v $PWD/wpdb:/var/lib/mysql -d mysql:5.7
```

Wait for database to start - verify by checking its logs

```
docker logs wpdb
```

Now launch wordpress with database password provided as environment variable

```
docker run --name wp --link wpdb:mysql -p 8080:80 -e WORDPRESS_DB_PASSWORD=w0rdpr3ss -d wordpress:php7.0
```

You can now finish installation using your browser - [http://localhost:8080](http://localhost:8080).

# 2. Launching Wordpress with docker-compose

Delete previously created wordpress and mysql containers and simplify the whole process by using docker-compose.

Create a file `docker-compose.yml` with the following content

```yaml
version: '3.1'

services:

  wordpress:
    image: wordpress:php7.0
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_PASSWORD: w0rdpr3ss

  mysql:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: w0rdpr3ss
    volumes:
      - $PWD/wpdb:/var/lib/mysql
```

Then use docker-compose to run those two containers in background - you must be in the same directory where you created your `docker-compose.yml` file

```
docker-compose up -d
```

Check logs with `docker-compose logs -f` and status of containers defined in `docker-compose.yml` file.

Check if wordpress is running - open [http://localhost:8080](http://localhost:8080) and see whether it works as expected.
