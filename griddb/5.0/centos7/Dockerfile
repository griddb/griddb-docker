FROM centos:centos7

# You can download griddb V5.0.0 directly at https://github.com/griddb/griddb/releases/tag/v5.0.0
ENV GRIDDB_VERSION=5.0.0
ENV GRIDDB_DOWNLOAD_SHA512=97585fa2a4f2ad2ad8c56c5409bc8a6dcab94943519667c1c22203865a70af038038312cf7142c827be8d607fc7ab6c945d1d478f329f47b8973e78e8565ec7e
ENV GS_HOME=/var/lib/gridstore
# Need declare $GS_LOG to start GridDB server
ENV GS_LOG=/var/lib/gridstore/log
ENV PORT=10001

RUN set -eux \
    && yum -y update \
    # Install dependencies for griddb
    && yum install -y wget python3 epel-release jq \
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
