FROM rockylinux:9.3

# You can download griddb V5.6.0 directly at https://github.com/griddb/griddb/releases/tag/v5.6.0
ENV GRIDDB_VERSION=5.6.0
ENV GRIDDB_DOWNLOAD_SHA512=2399e63a650092e226e9e027c92cceb021211cd36ae56c39425f52d2ddf094304bf92f7d4499d6b4eb02b4d1333be4b1a98eeba0d68f8040515063dc05c2b94e
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
