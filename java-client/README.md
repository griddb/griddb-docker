# Supported tags and respective Dockerfile links
* [5.0.0, latest](https://github.com/griddb/griddb-docker/tree/main/java-client)
* [4.6.1](https://github.com/griddb/griddb-docker/commit/ea6d2cf874368f37ac408544aabdedac9a4e7774)
* [4.5.0](https://github.com/griddb/griddb-docker/commit/b18cd3fa341c695189f7dc84cf27729ad3912f10)

# Overview GridDB java?

(Additional information)
There is Jar Package for [java version on Maven Central Repository](https://mvnrepository.com/artifact/com.github.griddb/gridstore).

# How to use this image

## Start a GridDB java instance

Starting a GridDB instance is simple.

Run images griddb java default mode and default setting
```console
$ docker run --network="host" griddb/java
```
All variable of docker GridDB java client

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_USERNAME       | admin          | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | IP_NOTIFICATION_MEMBER| NULL           | STRING           |
  |                       |                |                  |

All method of docker GridDB java

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB java with connection method

### GridDB java run sample with Multicast mode

Run images GridDB java simple with multicast mode
```console
$ docker run --network="host" griddb/java
```
Run image GridDB java with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    griddb/java
```

### GridDB java run sample with fixed list mode

Run images GridDB java simple with fixed list mode
```console
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/java
```

Run image GridDB java with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e IP_NOTIFICATION_MEMBER=<ip_machine_member> \
    griddb/java
```
Note :
* GridDB server version 4.5, 4.6 and 5.0 CE support 1 member for fixed list method.
* GridDB use option --network="host" to forward ports.

# Execute a sample program

## Run sample java client

### Multicast method

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/java
```
Output :
```
--> Person:  name=name02 status=false count=2 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]
```

### Fixed list method

```console
$ docker run -d --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/java
```
Output :
```
--> Person:  name=name02 status=false count=2 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]
```

The more information about java client. Could please refer to [here](https://github.com/griddb/java)

# Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB java container:

```console
$ docker exec -it container-name bash
```

About use `docker exec` for excute container java:

Step 1: [Start GridDB server](https://github.com/griddb/griddb-docker)

Step 2: Run image GridDB java

```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_java griddb/java tail -f /dev/null
```

Note: After finshed to run step 2. Image GridDB java has:

1. Name container is griddb_java
2. Mount current folder into docker container.
3. Process docker image GridDB java will run hidden. Run command ```$ docker ps``` about show it.
4. In command: The `pwd` is current path when run image. The "/root/." is path into docker container. This 2 value can change with user purpose
5. With command step 2. GridDB java can docker execute for 2 method(multicast method and fixed list method)

Step 3: Sample execute
```console
$ docker execute -it griddb_java /bin/bash -xec "Your command"
```

Example:
```console
$ docker execute -it griddb_java /bin/bash -xec "java gsSample/Sample1 239.0.0.1 31999 dockerGridDB admin admin"
```

## Stop a GridDB java

If run sample GridDB java.

```console
$ docker run --network="host" griddb/java
```
After finshed run sample image auto finish process.

If run execute GridDB java image
```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_java griddb/java tail -f /dev/null
```
GridDB java will stop with command:

```console
$ docker container stop griddb_java
or
$ docker kill griddb_java
```

# Image Variants

The griddb java images come in many flavors, each designed for a specific use case.

## ```griddb/java```
* This is default image of GridDB java Client.

# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
