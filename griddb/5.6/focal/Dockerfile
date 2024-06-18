FROM ubuntu:20.04

# You can download griddb V5.6.0 directly at https://github.com/griddb/griddb/releases/tag/v5.6.0
ENV GRIDDB_VERSION=5.6.0
ENV GRIDDB_DOWNLOAD_SHA512=1b19a75c5c60cf320ae836d495c82aad4c0eb4ea81d6666ca5c9aca33dbb8ae2e87d56fd5c784fc10e50536328c02550c22c032d175c75bd5a1b858f48b0c6f5
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
