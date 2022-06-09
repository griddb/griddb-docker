#!/bin/bash

if [ -z "$GRIDDB_CLUSTER_NAME" ]; then
    GRIDDB_CLUSTER_NAME='dockerGridDB'
fi

if [ -z "$NOTIFICATION_ADDRESS" ]; then
    NOTIFICATION_ADDRESS=239.0.0.1
fi

if [ -z "$NOTIFICATION_PORT" ]; then
    NOTIFICATION_PORT=31999
fi

if [ -z "$GRIDDB_USERNAME" ]; then
    GRIDDB_USERNAME='admin'
fi

if [ -z "$GRIDDB_PASSWORD" ]; then
    GRIDDB_PASSWORD='admin'
fi

# Export classpath for java
export CLASSPATH=${CLASSPATH}:/root/./gridstore.jar

if [ -z "$IP_NOTIFICATION_MEMBER" ]; then
    echo "Run sample GridDB java client with GridDB server mode MULTICAST : $NOTIFICATION_ADDRESS $NOTIFICATION_PORT $GRIDDB_CLUSTER_NAME $GRIDDB_USERNAME $GRIDDB_PASSWORD"
    javac gsSample/Sample1.java
    java gsSample/Sample1 $NOTIFICATION_ADDRESS $NOTIFICATION_PORT $GRIDDB_CLUSTER_NAME $GRIDDB_USERNAME $GRIDDB_PASSWORD
else
    echo "Run sample GridDB java client with GridDB server mode Fixed_List : $IP_NOTIFICATION_MEMBER:10001 $GRIDDB_CLUSTER_NAME $GRIDDB_USERNAME $GRIDDB_PASSWORD"
    javac gsSample/Sample1_fixlist.java
    java gsSample/Sample1_fixlist $IP_NOTIFICATION_MEMBER:10001 $GRIDDB_CLUSTER_NAME $GRIDDB_USERNAME $GRIDDB_PASSWORD
fi
