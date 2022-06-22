# Supported tags and respective Dockerfile links
* [5.0.0](https://github.com/griddb/griddb-docker/tree/main/jdbc)
* [4.6.0, latest](https://github.com/griddb/griddb-docker/commit/ea6d2cf874368f37ac408544aabdedac9a4e7774)
* [4.5.0.1](https://github.com/griddb/griddb-docker/commit/0840c3334a1166bfe5618b512ddf2e6164d5a923)

# Overview GridDB JDBC?

The GridDB JDBC Driver provides a SQL interface for GridDB.

(Additional information)
There is Jar Package for [JDBC Driver version on Maven Central Repository](https://mvnrepository.com/artifact/com.github.griddb/gridstore-jdbc).

# How to use this image

## Start a GridDB jdbc instance

Starting a GridDB jdbc instance is simple.

Run images griddb sever default mode and default setting
```console
$ docker run --network="host" griddb/jdbc
```
All variable of docker GridDB JDBC

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_USERNAME       | admin          | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | IP_NOTIFICATION_MEMBER| NULL           | STRING           |
  |                       |                |                  |

All method of docker GridDB JDBC

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB JDBC with connection method

### GridDB JDBC run sample with Multicast mode

Run images GridDB JDBC simple with multicast mode
```console
$ docker run --network="host" griddb/jdbc
```
Run image GridDB JDBC with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    griddb/jdbc
```

### GridDB run sample with fixed list mode

Run images GridDB jdbc simple with fixed list mode
```console
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/jdbc
```

Run image GridDB jdbc with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e IP_NOTIFICATION_MEMBER=<ip_machine_member> \
    griddb/jdbc
```
Note :
* GridDB server version 4.5, 4.6 and 5.0 CE support 1 member for fixed list method.
* GridDB use option --network="host" to forward ports.

# Execute a sample program (GriddB server on Ubuntu)

## Run sample JDBC Driver

### Multicast method

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


### Fixed list method

```console
$ docker run -d --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/jdbc
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

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB jdbc container:

```console
$ docker exec -it container-name bash
```

About use `docker exec` for excute container jdbc:

Step 1: [Start GridDB server](https://github.com/griddb/griddb-docker)

Step 2: Run image GridDB jdbc

```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_jdbc griddb/jdbc tail -f /dev/null
```

Note: After finshed to run step 2. Image GridDB jdbc has:

1. Name container is griddb_jdbc
2. Mount current folder into docker container.
3. Process docker image GridDB jdbc will run hidden. Run command ```$ docker ps``` about show it.
4. In command: The `pwd` is current path when run image. The "/root/." is path into docker container. This 2 value can change with user purpose
5. With command step 2. GridDB jdbc can docker execute for 2 method(multicast method and fixed list method)

Step 3: Sample execute
```console
$ docker execute -it griddb_jdbc /bin/bash -xec "Your command"
```

Example:
```console
$ docker execute -it griddb_jdbc /bin/bash -xec "java JDBCSelect 239.0.0.1 31999 dockerGridDB admin admin"
```

## Stop a GridDB JDBC

If run sample GridDB jdbc.

```console
$ docker run --network="host" griddb/jdbc
```
After finshed run sample image auto finish process.

If run execute GridDB jdbc image
```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_jdbc griddb/jdbc tail -f /dev/null
```
GridDB jdbc will stop with command:

```console
$ docker container stop container_name
or
$ docker kill container_name
```

# Image Variants


## ```griddb/jdbc```
* This is default image of GridDB jdbc.


# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
