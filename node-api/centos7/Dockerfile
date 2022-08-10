FROM centos:centos7.9.2009

ENV GRIDDB_NODE_API_VERSION=0.8.5
ENV GRIDDB_DOWNLOAD_SHA512=160747a49678693e3f2143584b1c53c97f00eedb69dbbf7c288f21d38361f25a35aac96a50d96cf701d6e50ab60c3f7f63f8f9376547a5c63283f014066ec85c
ENV NODE_PATH=/root/node-api-${GRIDDB_NODE_API_VERSION}

# Install griddb server
RUN set -eux \
    && yum update -y \
    # Install nodejs version 16.x and c client for griddb nodejs_client
    && yum install -y curl make python3 centos-release-scl \
    && yum install -y devtoolset-9 \
    && echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc \
    && curl -sL https://rpm.nodesource.com/setup_16.x | bash - \
    && yum install -y nodejs \
    && cd /etc/yum.repos.d/ \
    && curl https://download.opensuse.org/repositories/home:/knonomura/CentOS_7/home:knonomura.repo -o /etc/yum.repos.d/home:knonomura.repo \
    && yum install -y griddb-c-client \
    && yum clean all

SHELL ["/bin/bash", "--login", "-c"]
# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.js /root/

WORKDIR /root

# Install nodejs client
RUN curl -L https://github.com/griddb/node-api/archive/refs/tags/${GRIDDB_NODE_API_VERSION}.tar.gz -o ${GRIDDB_NODE_API_VERSION}.tar.gz -sS \
    && echo "$GRIDDB_DOWNLOAD_SHA512 ${GRIDDB_NODE_API_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf ${GRIDDB_NODE_API_VERSION}.tar.gz \
    && cd node-api-${GRIDDB_NODE_API_VERSION} \
    && npm set unsafe-perm true \
    && npm install \
    && rm ../${GRIDDB_NODE_API_VERSION}.tar.gz

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
