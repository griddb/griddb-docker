FROM ubuntu:18.04

# You can download griddb V5.3.0 directly at https://github.com/griddb/griddb/releases/tag/v5.3.0
ENV GRIDDB_VERSION=5.3.0
ENV GRIDDB_DOWNLOAD_SHA512=6a2fb155e549dbdd172678220c89d69e8b187bc1ae118cdbb9111dd03fff8461065dfd6152ad292fbeceee5cc041934a62024fb8cf562c1c6c0c7f468a5403a8
ENV GS_HOME=/var/lib/gridstore
# Need declare $GS_LOG to start GridDB server
ENV GS_LOG=/var/lib/gridstore/log
ENV PORT=10001
ENV DEBIAN_FRONTEND=noninteractive

# Install griddb server
RUN set -eux \
    && apt-get update \
    # Install dependencies for griddb
    && apt-get install -y systemd dpkg python3 wget jq --no-install-recommends \
    && apt-get clean all \
    # Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb_${GRIDDB_VERSION}_amd64.deb --no-check-certificate \
    # Check sha512sum package
    && echo "${GRIDDB_DOWNLOAD_SHA512} griddb_${GRIDDB_VERSION}_amd64.deb" | sha512sum --strict --check \
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
