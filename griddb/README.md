# Supported tags and respective Dockerfile links
* [5.6.0-jammy, latest](https://github.com/griddb/griddb-docker/blob/main/griddb/5.6/jammy/Dockerfile)
* [5.6.0-focal](https://github.com/griddb/griddb-docker/blob/main/griddb/5.6/focal/Dockerfile)
* [5.6.0-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/5.6/centos7/Dockerfile)
* [5.6.0-rockylinux9](https://github.com/griddb/griddb-docker/blob/main/griddb/5.6/rockylinux9/Dockerfile)
* [5.5.0-jammy](https://github.com/griddb/griddb-docker/blob/main/griddb/5.5/jammy/Dockerfile)
* [5.5.0-focal](https://github.com/griddb/griddb-docker/blob/main/griddb/5.5/focal/Dockerfile)
* [5.5.0-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/5.5/centos7/Dockerfile)
* [5.3.1-focal](https://github.com/griddb/griddb-docker/blob/main/griddb/5.3/focal/Dockerfile)
* [5.3.1-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/5.3/centos7/Dockerfile)
* [5.0.0-bionic](https://github.com/griddb/griddb-docker/blob/main/griddb/5.0/bionic/Dockerfile)
* [5.0.0-focal](https://github.com/griddb/griddb-docker/blob/main/griddb/5.0/focal/Dockerfile)
* [5.0.0-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/5.0/centos7/Dockerfile)
* [4.6.1-bionic](https://github.com/griddb/griddb-docker/blob/main/griddb/4.6/bionic/Dockerfile)
* [4.6.1-focal](https://github.com/griddb/griddb-docker/blob/main/griddb/4.6/focal/Dockerfile)
* [4.6.1-centos8](https://github.com/griddb/griddb-docker/blob/main/griddb/4.6/centos8/Dockerfile)
* [4.6.1-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/4.6/centos7/Dockerfile)
* [4.5.2-bionic](https://github.com/griddb/griddb-docker/blob/main/griddb/4.5/bionic/Dockerfile)
* [4.5.2-centos7](https://github.com/griddb/griddb-docker/blob/main/griddb/4.5/centos7/Dockerfile)

# What is GridDB?

[GridDB](https://github.com/griddb/griddb) is Database for IoT with both NoSQL interface and SQL Interface.
Please refer to [GridDB Features Reference](https://github.com/griddb/docs-en/blob/master/manuals/GridDB_FeaturesReference.md) for functionality.
This repository includes server and Java client. And [jdbc repository](https://github.com/griddb/jdbc) includes JDBC Driver.

# How to use this image

## Start a GridDB server instance

Starting a GridDB instance is simple.

Run images griddb sever default mode and default setting
```console
$ docker run --network="host" griddb/griddb
```
All variable of docker GridDB

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | NOTIFICATION_MEMBER   | NULL           | NUMBER           |
  |                       |                |                  |

All method of docker GridDB

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB with connection method

### GridDB run with Multicast mode

Run images GridDB server simple with multicast mode
```console
$ docker run --network="host" griddb/griddb
```

Run image GridDB server with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    griddb/griddb
```

Start docker GridDB via docker-compose

Example docker-compose.yaml for GridDB:

```yaml
version: '3'

services:
  griddb:
    container_name: griddb_server
    image: griddb/griddb
    network_mode: "host"
    volumes:
      - "vol:/var/lib/gridstore"

volumes:
    vol:

```
Try command line in current folder :

```console
$ docker-compose up
```

### GridDB run with fixed list mode

Run images GridDB server simple with fixed list mode
```console
$ docker run --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
```

Run image GridDB server with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e NOTIFICATION_MEMBER=1 \
    griddb/griddb
```
Note :
* GridDB CE of the version since 4.5 supports only 1 member for fixed list method.
* GridDB use option --network="host" to forward ports.

# Execute a sample program (GriddB server on Ubuntu)

## Run sample Client (Java)

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/java-client
```
Output:
```
--> Person:  name=name02 status=false count=2 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]
```
The more information about griddb server and java client. Could please refer to [here](https://github.com/griddb/griddb)

## Run sample JDBC Driver

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/jdbc
```
Output :
```
--> SQL Create Table name=SampleJDBC_Select
    SQL Insert count=5
    SQL row(id=3, value=test3)
    SQL row(id=4, value=test4)
    success!
```

The more information about JDBC Driver. Could please refer to [here](https://github.com/griddb/jdbc)

# Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB container:

```console
$ docker exec -it container-name bash
```

Check status container for griddb sever:
```console
$ docker exec container_name /bin/bash -c "gs_stat -u admin/admin"
```

The log is available through Docker's container log:

```console
$ docker logs container_name
```
## About data from volume

```console
$ docker run --name container_name \
  -v my_vol:/var/lib/gridstore \
  griddb/griddb
```

With:
    my_vol is volume ( $ docker volume ls )
Or you can see more infor in path: "/var/lib/docker/volumes/my_vol/_data"

## Stop a GridDB server

Use ```docker exec``` for stop griddb sever:
```console
$ docker exec container_name /bin/bash -c "gs_stopcluster -u admin/admin"
$ docker exec container_name /bin/bash -c "gs_stopnode -u admin/admin"
```

```console
$ docker container stop container_name
or
$ docker kill container_name
```

Note: You can restart griddb server and you can add flag "-i" into command for more information. Using command in below:
```
$ docker container start container_name -i
```

# Image Variants

The griddb images come in many flavors, each designed for a specific use case.

## ```griddb/griddb```
* This is default image of GridDB server.

## ```griddb/griddb:<version>-jammy```
* This is image of GridDB server on Ubuntu. This image dedicated of GridDB server on Ubuntu 22.04.

## ```griddb/griddb:<version>-focal```
* This is image of GridDB server on Ubuntu. This image dedicated of GridDB server on Ubuntu 20.04.

## ```griddb/griddb:<version>-centos7```
* This is image of GridDB server on CentOS. This image dedicated of GridDB server on CentOS 7.

## ```griddb/griddb:<version>-rockylinux9```
* This is image of GridDB server on RockyLinux. This image dedicated of GridDB server on RockyLinux 9.

# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
