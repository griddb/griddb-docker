FROM centos:centos8.3.2011

# You can download griddb V4.6.1 directly at https://github.com/griddb/griddb/releases/tag/v4.6.1
ENV GRIDDB_VERSION=4.6.1
ENV GRIDDB_DOWNLOAD_SHA512=06eb291f0b87f9c0e6d05fd21919685919d641da1af659fe93b4ab6af2919301a811d950c40d8cf5e80183ac1d9b2beb4f241c04121a942228072cd9f5f71674
ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log
ENV PORTS=10001

# Install griddb server
RUN set -eux \
    && yum update -y \
    # Install dependency for griddb
    && yum install -y wget python27 epel-release \
    && yum update -y \
    && yum install -y jq \
    && yum clean all \
    # Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb-${GRIDDB_VERSION}-linux.x86_64.rpm \
    # Check sha512sum package
    && echo "$GRIDDB_DOWNLOAD_SHA512 griddb-${GRIDDB_VERSION}-linux.x86_64.rpm" | sha512sum --strict --check \
    # Install package griddb server
    && rpm -ivh griddb-${GRIDDB_VERSION}-linux.x86_64.rpm \
    # Remove package
    && rm griddb-${GRIDDB_VERSION}-linux.x86_64.rpm

VOLUME $GS_HOME
WORKDIR $GS_HOME

# Config file for griddb
COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORTS
CMD ["griddb"]
