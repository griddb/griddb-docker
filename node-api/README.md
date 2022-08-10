# Supported tags and respective Dockerfile links

# Overview GridDB Node Api?

GridDB Node API is developed using GridDB C Client and node-addon-api.

# How to use this image

## Start a GridDB Node API instance

Starting a GridDB Node API instance is simple.

Run images GridDB Node API default mode and default setting
```console
$ docker run --network="host" griddb/nodeapi
```
All variable of docker GridDB nodeapi client

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_USERNAME       | admin          | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | IP_NOTIFICATION_MEMBER| NULL           | STRING           |
  |                       |                |                  |

All method of docker GridDB nodeapi

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB Node Api with connection method

### GridDB Node Api run sample with Multicast mode

Run images GridDB nodeapi simple with multicast mode
```console
$ docker run --network="host" griddb/nodeapi
```
Run image GridDB nodeapi with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    griddb/nodeapi
```

### GridDB Node Api run sample with fixed list mode

Run images GridDB Node API simple with fixed list mode
```console
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/nodeapi
```

Run image GridDB Node API with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e IP_NOTIFICATION_MEMBER=<ip_machine_member> \
    griddb/nodeapi
```
Note :
* GridDB server version 4.5, 4.6 and 5.0 CE support 1 member for fixed list method.
* GridDB use option --network="host" to forward ports.

# Execute a sample program (GriddB Node Api on Ubuntu)

## Run sample nodeapi

### Multicast method

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/nodeapi
```
Output :
```
--> [ 'name01', false, 1, <Buffer 41 42 43 44 45 46 47 48 49 4a> ]
```

### Fixed list method

```console
$ docker run -d --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/nodeapi
```
Output :
```
--> [ 'name01', false, 1, <Buffer 41 42 43 44 45 46 47 48 49 4a> ]
```

The more information about nodeapi. Could please refer to [here](https://github.com/griddb/nodeapi)

# Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB nodeapi container:

```console
$ docker exec -it container-name bash
```

About use `docker exec` for excute container nodeapi:

Step 1: [Start GridDB server](https://github.com/griddb/griddb-docker)

Step 2: Run image GridDB Node Api

```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_nodeapi griddb/nodeapi tail -f /dev/null
```

Note: After finshed to run step 2. Image GridDB nodeapi has:

1. Name container is griddb_nodeapi
2. Mount current folder into docker container.
3. Process docker image GridDB nodeapi will run hidden. Run command ```$ docker ps``` about show it.
4. In command: The `pwd` is current path when run image. The "/root/." is path into docker container. This 2 value can change with user purpose
5. With command step 2. GridDB nodeapi can docker execute for 2 method(multicast method and fixed list method)

Step 3: Sample execute
```consol
$ docker execute -it griddb_nodeapi /bin/bash -xec "Your command"
```

Example:
```consol
$ docker execute -it griddb_nodeapi /bin/bash -xec "nodeapi sample1.js 239.0.0.1 31999 dockerGridDB admin admin"
```

## Stop a GridDB Node Api

If run sample GridDB nodeapi.

```console
$ docker run --network="host" griddb/nodeapi
```
After finshed run sample image auto finish process.

If run execute GridDB nodeapi image
```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_nodeapi griddb/nodeapi tail -f /dev/null
```
GridDB nodeapi will stop with command:

```console
$ docker container stop griddb_nodeapi
or
$ docker kill griddb_nodeapi
```

# Image Variants

The griddb nodeapi images come in many flavors, each designed for a specific use case.

## ```griddb/nodeapi```
* This is default image of GridDB Node Api.

## ```griddb/nodeapi:<version>-focal```
* This is image of GridDB Node Api on Ubuntu. This image dedicated of GridDB Node Api on Ubuntu 20.04.

## ```griddb/nodeapi:<version>-centos7```
* This is image of GridDB Node Api on CentOS. This image dedicated of GridDB Node Api on CentOS 7.

## ```griddb/nodeapi:<version>-bionic```
* This is image of GridDB Node Api on Ubuntu. This image dedicated of GridDB Node Api on Ubuntu 18.04.

# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
