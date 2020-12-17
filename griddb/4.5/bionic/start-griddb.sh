#!/bin/bash

if [ "${1:0:1}" = '-' ]; then
    set -- griddb "$@"
fi

# Save variable and value to config file
save_config() {
    echo "GRIDDB_CLUSTER_NAME=\"$GRIDDB_CLUSTER_NAME\"" >> /var/lib/gridstore/conf/gridstore.conf
    echo "GRIDDB_USERNAME=\"$GRIDDB_USERNAME\""         >> /var/lib/gridstore/conf/gridstore.conf
    echo "GRIDDB_PASSWORD=\"$GRIDDB_PASSWORD\""         >> /var/lib/gridstore/conf/gridstore.conf
}

# First parameter after run images
if [ "${1}" = 'griddb' ]; then

    isSystemInitialized=0
    if [ "$(ls -A /var/lib/gridstore/data)" ]; then
        isSystemInitialized=1
    fi

    if [ $isSystemInitialized = 0 ]; then
        export GRIDDB_CLUSTER_NAME=${GRIDDB_CLUSTER_NAME:-"dockerGridDB"}
        export GRIDDB_USERNAME=${GRIDDB_USERNAME:-"admin"}
        export GRIDDB_PASSWORD=${GRIDDB_PASSWORD:-"admin"}

        # Extra modification based on environment variable
        gs_passwd $GRIDDB_USERNAME -p $GRIDDB_PASSWORD
        sed -i -e s/\"clusterName\":\"\"/\"clusterName\":\"$GRIDDB_CLUSTER_NAME\"/g \/var/lib/gridstore/conf/gs_cluster.json

        # MULTICAST mode
        if [ ! -z $NOTIFICATION_ADDRESS ]; then
            echo "MULTICAST mode address"
            sed -i -e s/\"notificationAddress\":\"239.0.0.1\"/\"notificationAddress\":\"$NOTIFICATION_ADDRESS\"/g \/var/lib/gridstore/conf/gs_cluster.json
        fi

        if [ ! -z $NOTIFICATION_PORT ]; then
            echo "MULTICAST mode port"
            sed -i -e s/\"notificationPort\":31999/\"notificationPort\":$NOTIFICATION_PORT/g \/var/lib/gridstore/conf/gs_cluster.json
        fi

        # FIXED_LIST mode
        if [ ! -z $NOTIFICATION_MEMBER ]; then
            echo "FIXED_LIST mode, not suported"
            exit 1
        fi

        # PROVIDER mode
        if [ ! -z $NOTIFICATION_PROVIDER ]; then
            echo "PROVIDER mode, not supported"
            exit 1
        fi

        # Write to config file
        save_config
    fi

    # Read config file
    . /var/lib/gridstore/conf/gridstore.conf

    # Start service
    gs_startnode -u $GRIDDB_USERNAME/$GRIDDB_PASSWORD -w
    gs_joincluster -c $GRIDDB_CLUSTER_NAME -u $GRIDDB_USERNAME/$GRIDDB_PASSWORD -w

    # Wait
    tail -f /var/lib/gridstore/log/gsstartup.log
fi
exec "$@"

