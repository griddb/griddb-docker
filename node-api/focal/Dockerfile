FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GRIDDB_NODE_API_VERSION=0.8.5
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
RUN set -eux \
    && echo 'deb http://download.opensuse.org/repositories/home:/knonomura/xUbuntu_18.04/ /' | tee /etc/apt/sources.list.d/home:knonomura.list \
    && wget --no-check-certificate -qO - https://download.opensuse.org/repositories/home:knonomura/xUbuntu_18.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_knonomura.gpg > /dev/null \
    && apt-get -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update \
    && apt-get install --no-install-recommends -y --allow-unauthenticated griddb-c-client \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

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
