FROM centos:centos7.8.2003

# You can download griddb V4.5.2 directly at https://github.com/griddb/griddb/releases/tag/v4.5.2
ENV GRIDDB_VERSION=4.5.2
ENV GRIDDB_DOWNLOAD_SHA512=2639cc7549f4fc151987c686c76e4deeb4b27f07b8a35dbf50b2f08954e1ee4dc39bd4a47d4407a63bb6fe7d9441508cd89009827d937d1045e25f685553cceb
ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log
ENV PORTS=10001

# Install griddb server
RUN set -eux \
    && yum update -y \
# Install dependency for griddb
    && yum install -y wget python27 \
    && yum clean all \
# Download package griddb server
    && wget -q https://github.com/griddb/griddb/releases/download/v${GRIDDB_VERSION}/griddb-${GRIDDB_VERSION}-linux.x86_64.rpm \
# Check sha512sum package
    && echo "$GRIDDB_DOWNLOAD_SHA512 griddb-${GRIDDB_VERSION}-linux.x86_64.rpm" | sha512sum --strict --check \
# Install package griddb server
    && rpm -ivh griddb-${GRIDDB_VERSION}-linux.x86_64.rpm \
# Remove package
    && rm griddb-${GRIDDB_VERSION}-linux.x86_64.rpm

VOLUME /var/lib/gridstore

# Config file for griddb
COPY start-griddb.sh /
USER gsadm
ENTRYPOINT ["/bin/bash", "/start-griddb.sh"]
EXPOSE $PORTS
CMD ["griddb"]

