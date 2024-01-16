FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GRIDDB_C_VERSION=5.3.0
ENV GRIDDB_NODE_API_VERSION=0.8.5
ENV GRIDDB_C_DOWNLOAD_SHA512=a9a766c87851d1f3945fbc9706523399448d4517272cf9d9bc3415b4278d6d650b75c8c5446501d3cd6420c68b6e1887b7cb9a2cc42a6a357257cc0fd8cf6ee2
ENV GRIDDB_DOWNLOAD_SHA512=160747a49678693e3f2143584b1c53c97f00eedb69dbbf7c288f21d38361f25a35aac96a50d96cf701d6e50ab60c3f7f63f8f9376547a5c63283f014066ec85c
ENV NODE_PATH=/root/node-api-${GRIDDB_NODE_API_VERSION}

# Install griddb server
RUN set -eux \
    && apt-get update -y \
    # Install nodejs version 16.x for griddb nodejs_client
    && apt-get install --no-install-recommends -y wget curl make gcc g++ ca-certificates \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install --no-install-recommends -y nodejs \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Install GridDB C Client
RUN curl -L -k https://github.com/griddb/c_client/releases/download/v${GRIDDB_C_VERSION}/griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -o griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -sS \
    && echo "$GRIDDB_C_DOWNLOAD_SHA512 griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb" | sha512sum --strict --check \
    && apt install --no-install-recommends -y --allow-unauthenticated ./griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* && rm griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb

# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.js /root/

WORKDIR /root/

# Install nodejs client
RUN curl -L -k https://github.com/griddb/node-api/archive/refs/tags/${GRIDDB_NODE_API_VERSION}.tar.gz -o ${GRIDDB_NODE_API_VERSION}.tar.gz -sS \
    && echo "${GRIDDB_DOWNLOAD_SHA512} ${GRIDDB_NODE_API_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf ${GRIDDB_NODE_API_VERSION}.tar.gz \
    && cd node-api-${GRIDDB_NODE_API_VERSION} \
    && npm set unsafe-perm true \
    && npm install \
    && rm ../${GRIDDB_NODE_API_VERSION}.tar.gz

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
