# Supported tags and respective Dockerfile links

# Overview GridDB Php?

GridDB php Client is developed using GridDB C Client and SWIG (Simplified Wrapper and Interface Generator).

# How to use this image

## Start a GridDB Php instance

Starting a GridDB Php instance is simple.

Run images GridDB Php default mode and default setting
```console
$ docker run --network="host" griddb/php
```
All variable of docker GridDB Php client

  | Variable              | Value default  | Type of variable |
  |-----------------------|----------------|------------------|
  | GRIDDB_CLUSTER_NAME   | dockerGridDB   | STRING           |
  | GRIDDB_USERNAME       | admin          | STRING           |
  | GRIDDB_PASSWORD       | admin          | STRING           |
  | NOTIFICATION_PORT     | 31999          | NUMBER           |
  | NOTIFICATION_ADDRESS  | 239.0.0.1      | STRING           |
  | IP_NOTIFICATION_MEMBER| NULL           | STRING           |
  |                       |                |                  |

All method of docker GridDB Php

  | MODE        | STATUS(default) |
  |-------------|-----------------|
  | MULTICAST   |        ON       |
  | FIXED LIST  |        OFF      |
  |             |                 |

## About run GridDB Php with connection method

### GridDB Php run sample with Multicast mode

Run images GridDB Php simple with multicast mode
```console
$ docker run --network="host" griddb/php
```
Run image GridDB Php with environment config for multicast mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e NOTIFICATION_PORT=<port> \
    -e NOTIFICATION_ADDRESS=<multicast_address> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    griddb/php
```

### GridDB Php run sample with fixed list mode

Run images GridDB Php simple with fixed list mode
```console
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/php
```

Run image GridDB Php with environment config for fixed list mode

```console
docker run --name container_name \
    --network="host" \
    -e GRIDDB_CLUSTER_NAME=<clustername> \
    -e GRIDDB_USERNAME=<user> \
    -e GRIDDB_PASSWORD=<passwd> \
    -e IP_NOTIFICATION_MEMBER=<ip_machine_member> \
    griddb/php
```
Note :
* GridDB server version 4.5, 4.6 and 5.0 CE support 1 member for fixed list method.
* GridDB use option --network="host" to forward ports.

# Execute a sample program

## Run sample Php client

### Multicast method

```console
$ docker run -d --network="host" griddb/griddb
$ docker run --network="host" griddb/php
```
Output :
```
--> Person: name=name02 status=false count=2 lob=ABCDEFGHIJ
    success!
```

### Fixed list method

```console
$ docker run -d --network="host" -e NOTIFICATION_MEMBER=1 griddb/griddb
$ docker run --network="host" -e IP_NOTIFICATION_MEMBER="10.10.xx.xx" griddb/php
```
Output :
```
--> Person: name=name02 status=false count=2 lob=ABCDEFGHIJ
    success!
```

The more information about php client . Could please refer to [here](https://github.com/griddb/php_client)

# Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your GridDB php container:

```console
$ docker exec -it container-name bash
```

About use `docker exec` for excute container php:

Step 1: [Start GridDB server](https://github.com/griddb/griddb-docker)

Step 2: Run image GridDB php

```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_php griddb/php tail -f /dev/null
```

Note: After finshed to run step 2. Image GridDB php has:

1. Name container is griddb_php
2. Mount current folder into docker container.
3. Process docker image GridDB php will run hidden. Run command ```$ docker ps``` about show it.
4. In command: The `pwd` is current path when run image. The "/root/." is path into docker container. This 2 value can change with user purpose
5. With command step 2. GridDB php can docker execute for 2 method(multicast method and fixed list method)

Step 3: Sample execute
```consol
$ docker execute -it griddb_php /bin/bash -xec "Your command"
```
Note: If you want to run your other sample, remember to add the following line in your sample to include griddb_php_client.php library:
```php
include('php_client/griddb_php_client.php');
```

Example:
```consol
$ docker execute -it griddb_php /bin/bash -xec "cd php_client && php sample/sample1.go 239.0.0.1 31999 dockerGridDB admin admin"
```

## Stop a GridDB Php

If run sample GridDB Php.

```console
$ docker run --network="host" griddb/php
```
After finshed run sample image auto finish process.

If run execute GridDB Php image
```console
$ docker run -d --network="host" -v `pwd`:/root/. --name griddb_php griddb/php tail -f /dev/null
```
GridDB php will stop with command:

```console
$ docker container stop griddb_php
or
$ docker kill griddb_php
```

# Image Variants

The griddb php images come in many flavors, each designed for a specific use case.

## ```griddb/php```
* This is default image of GridDB Php Client.

## ```griddb/php:<version>-focal```
* This is image of GridDB Php Client on Ubuntu. This image dedicated of GridDB Php on Ubuntu 20.04.

## ```griddb/php:<version>-centos7```
* This is image of GridDB Php Client on CentOS. This image dedicated of GridDB Php on CentOS 7.

## ```griddb/php:<version>-bionic```
* This is image of GridDB Php Client on Ubuntu. This image dedicated of GridDB Php on Ubuntu 18.04.

# License

View [license information](https://github.com/griddb/griddb#license) for the software contained in this image.
