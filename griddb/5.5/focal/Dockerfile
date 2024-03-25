FROM ubuntu:20.04

# You can download griddb V5.5.0 directly at https://github.com/griddb/griddb/releases/tag/v5.5.0
ENV GRIDDB_VERSION=5.5.0
ENV GRIDDB_DOWNLOAD_SHA512=2985d7465189cdaedb04dd3006f60959a4f5a7b118112e87fd450e8540ef0514dcf780f92ffd3be7265ff5f3147df71b8c50ab68dd643e77c5eb812ed3496049
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
