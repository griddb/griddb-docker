FROM ubuntu:18.04

# You can download griddb V4.5.2 directly at https://github.com/griddb/griddb/releases/tag/v4.5.2
ENV GRIDDB_VERSION=4.5.2
ENV GRIDDB_DOWNLOAD_SHA512=92d0e382c8d694c2b37274fa37785e2bdb9d6ad8aee0f559e75a528ad171aea1221091ca24db5e2f90442fd92042a6307198d74d0eb1b5f9a23659a26ca7b609
ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log
ENV PORTS=10001

# Install griddb server
RUN set -eux \
    && apt-get update \
# Install dependency for griddb
    && apt-get install -y dpkg python wget \
    && apt-get clean all \
# Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb_${GRIDDB_VERSION}_amd64.deb \
# Check sha512sum package
    && echo "$GRIDDB_DOWNLOAD_SHA512 griddb_${GRIDDB_VERSION}_amd64.deb" | sha512sum --strict --check \
# Install package griddb server
    && dpkg -i griddb_${GRIDDB_VERSION}_amd64.deb \
# Remove package
    && rm griddb_${GRIDDB_VERSION}_amd64.deb

VOLUME /var/lib/gridstore

# Config file for griddb
COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORTS
CMD ["griddb"]
