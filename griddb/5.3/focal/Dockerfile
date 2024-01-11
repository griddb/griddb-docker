FROM ubuntu:20.04

# You can download griddb V5.3.1 directly at https://github.com/griddb/griddb/releases/tag/v5.3.1
ENV GRIDDB_VERSION=5.3.1
ENV GRIDDB_DOWNLOAD_SHA512=d087e79665346f59fe8b9a50b9386f0805bb73da51fd3bc4f97e1737659d5f7676850abb71f7c34a038a0b48227878139f5904ac8bbc95062f4ec39887a75f12
ENV GS_HOME=/var/lib/gridstore
# Need declare $GS_LOG to start GridDB server
ENV GS_LOG=/var/lib/gridstore/log
ENV PORT=10001
ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    && apt-get -y update \
    # Install dependencies for griddb
    && apt-get install -y python3 wget dpkg systemd jq --no-install-recommends \
    # Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb_${GRIDDB_VERSION}_amd64.deb --no-check-certificate \
    # Check sha512sum package
    && echo "${GRIDDB_DOWNLOAD_SHA512} griddb_${GRIDDB_VERSION}_amd64.deb"| sha512sum --check --strict \
    # Install package griddb server
    && dpkg -i griddb_${GRIDDB_VERSION}_amd64.deb \
    # Remove package
    && rm griddb_${GRIDDB_VERSION}_amd64.deb \
    # Delete the apt-get lists after installing something
    && rm -rf /var/lib/apt/lists/*

VOLUME $GS_HOME
WORKDIR $GS_HOME


COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORT
CMD ["griddb"]
