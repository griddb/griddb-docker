FROM centos:centos7

# You can download griddb V5.3.0 directly at https://github.com/griddb/griddb/releases/tag/v5.3.0
ENV GRIDDB_VERSION=5.3.0
ENV GRIDDB_DOWNLOAD_SHA512=04c6a8ccf34cfbcd31663b3d4d64b3e25c86e514153b3dc3c42e54a0e4275cd05318429ff8f5eb8405d8ca9689f795b76978e1059d74f8c01ec05a859dd26721
ENV GS_HOME=/var/lib/gridstore
# Need declare $GS_LOG to start GridDB server
ENV GS_LOG=/var/lib/gridstore/log
ENV PORT=10001

RUN set -eux \
    && yum -y update \
    # Install dependencies for griddb
    && yum install -y wget python3 epel-release \
    && yum install -y jq \
    && yum clean all \
    # Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb-${GRIDDB_VERSION}-linux.x86_64.rpm --no-check-certificate \
    # Check sha512sum package
    && echo "${GRIDDB_DOWNLOAD_SHA512} griddb-${GRIDDB_VERSION}-linux.x86_64.rpm"| sha512sum --check --strict \
    # Install package griddb server
    && rpm -i griddb-${GRIDDB_VERSION}-linux.x86_64.rpm \
    # Remove package
    && rm griddb-${GRIDDB_VERSION}-linux.x86_64.rpm

VOLUME $GS_HOME
WORKDIR $GS_HOME

COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORT
CMD ["griddb"]
