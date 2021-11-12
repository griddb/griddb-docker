FROM ubuntu:18.04

# You can download griddb V4.6.1 directly at https://github.com/griddb/griddb/releases/tag/v4.6.1
ENV GRIDDB_VERSION=4.6.1
ENV GRIDDB_DOWNLOAD_SHA512=542b6fb97c19106842e2073bb28e18edfac44d96b996aaf505fbed8f50f8421b25f8dedc5857574632931c7ef79916017fdff3be457c0bec2f900a531324c200
ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log
ENV PORTS=10001
ENV DEBIAN_FRONTEND=noninteractive

# Install griddb server
RUN set -eux \
    && apt-get update \
    # Install dependency for griddb
    && apt-get install -y dpkg python wget jq \
    && apt-get clean all \
    # Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb_${GRIDDB_VERSION}_amd64.deb \
    # Check sha512sum package
    && echo "$GRIDDB_DOWNLOAD_SHA512 griddb_${GRIDDB_VERSION}_amd64.deb" | sha512sum --strict --check \
    # Install package griddb server
    && dpkg -i griddb_${GRIDDB_VERSION}_amd64.deb \
    # Remove package
    && rm griddb_${GRIDDB_VERSION}_amd64.deb

VOLUME $GS_HOME
WORKDIR $GS_HOME

# Config file for griddb
COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORT
CMD ["griddb"]
