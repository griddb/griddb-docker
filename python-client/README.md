# Supported tags and respective Dockerfile links

# Overview GridDB python?

GridDB Python Client is developed using GridDB C Client and SWIG (Simplified Wrapper and Interface Generator).

# How to use this image

## Start a GridDB server instance

Starting a GridDB instance is simple.

Run images griddb sever default mode and default setting
```console
$ docker run --network="host" griddb/python
```
All variable of docker GridDB python client

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_USERNAME       | admin          | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | IP_NOTIFICATION_MEMBER| NULL           | STRING           |
  |                       |                |                  |

All method of docker GridDB python

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB python with connection method

### GridDB python run sample with Multicast mode

Run images GridDB python simple with multicast mode
```console
$ docker run --network="host" griddb/python
```
Run image GridDB python with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    griddb/python
```

### GridDB run sample with fixed list mode

Run images GridDB server simple with fixed list mode
```console
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/python
```

Run image GridDB server with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e IP_NOTIFICATION_MEMBER=<ip_machine_member> \
    griddb/python
```
Note :
* GridDB server version 4.5, 4.6 and 5.0 CE support 1 member for fixed list method.
* IP_NOTIFICATION_MEMBER is ip of machine griddb server
* GridDB use option --network="host" to forward ports.

# Execute a sample program (GriddB server on Ubuntu)

## Run sample python client

### Multicast method

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/python
```
Output :
```
--> Person:  name=name02 status=false count=2 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]
```

### Fixed list method

```console
$ docker run -d --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/python
```
Output :
```
--> Person:  name=name02 status=false count=2 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]
```

The more information about python client. Could please refer to [here](https://github.com/griddb/python)

# Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB python container:

```console
$ docker exec -it container-name bash
```

About use `docker exec` for excute container python:

Step 1: [Start GridDB server](https://github.com/griddb/griddb-docker)

Step 2: Run image GridDB python

```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_python griddb/python tail -f /dev/null
```

Note: After finshed to run step 2. Image GridDB python has:

1. Name container is griddb_python
2. Mount current folder into docker container.
3. Process docker image GridDB python will run hidden. Run command ```$ docker ps``` about show it.
4. In command: The `pwd` is current path when run image. The "/root/." is path into docker container. This 2 value can change with user purpose
5. With command step 2. GridDB python can docker execute for 2 method(multicast method and fixed list method)

Step 3: Sample execute
```consol
$ docker execute -it griddb_python /bin/bash -xec "Your command"
```

Example:
```consol
$ docker execute -it griddb_python /bin/bash -xec "python sample1.py 239.0.0.1 31999 dockerGridDB admin admin"
```

## Stop a GridDB python

If run sample GridDB python.

```console
$ docker run --network="host" griddb/python
```
After finshed run sample image auto finish process.

If run execute GridDB python image
```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_python griddb/python tail -f /dev/null
```
GridDB python will stop with command:

```console
$ docker container stop griddb_python
or
$ docker kill griddb_python
```

# Image Variants

The griddb python images come in many flavors, each designed for a specific use case.

## ```griddb/python```
* This is default image of GridDB python.

## ```griddb/python:<version>-focal```
* This is image of GridDB python Client on Ubuntu. This image dedicated of GridDB python on Ubuntu 20.04.

## ```griddb/python:<version>-centos7```
* This is image of GridDB python on CentOS. This image dedicated of GridDB python on CentOS 7.

## ```griddb/python:<version>-bionic```
* This is image of GridDB python on Ubuntu. This image dedicated of GridDB python on Ubuntu 18.04.

# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
