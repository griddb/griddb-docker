FROM centos:centos7

# You can download griddb V5.3.1 directly at https://github.com/griddb/griddb/releases/tag/v5.3.1
ENV GRIDDB_VERSION=5.3.1
ENV GRIDDB_DOWNLOAD_SHA512=8ce6bcb2eeb952dd0fac8a055eb9cb76cd795b8d73067593e71d1b7e2eff39ee367d3f5eee610400685130b58e4b484bf56a111ada87e32228e7f7f74db25e2a
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
