FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GRIDDB_C_VERSION=5.3.0
ENV GRIDDB_PHP_VERSION=0.8.1
ENV SWIG_VERSION=4.1.0
ENV PHP_VERSION=8.1
ENV GRIDDB_C_DOWNLOAD_SHA512=a9a766c87851d1f3945fbc9706523399448d4517272cf9d9bc3415b4278d6d650b75c8c5446501d3cd6420c68b6e1887b7cb9a2cc42a6a357257cc0fd8cf6ee2
ENV GRIDDB_PHP_DOWNLOAD_SHA512=5a7516ef41219163e64749f19187091bcff7fb4ae07b23844688398d87213b04c1410068355b4f9ce2c011f8ca82a28a66fc47b889d02891fc783c395479f690

RUN set -eux \
    && apt-get update -y \
    && apt-get install -yq --no-install-recommends \
    git curl byacc libpcre3 libpcre3-dev make autoconf automake apache2 apt-utils gcc g++ software-properties-common \
    # Install php
    && add-apt-repository ppa:ondrej/php \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y php${PHP_VERSION} php${PHP_VERSION}-dev php${PHP_VERSION}-cli \
    # Move lib,path out site default php
    && cp -R /usr/include/php/20210902/* /usr/include/php \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install GridDB C Client
RUN curl -L -k https://github.com/griddb/c_client/releases/download/v${GRIDDB_C_VERSION}/griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -o griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -sS \
    && echo "$GRIDDB_C_DOWNLOAD_SHA512 griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb" | sha512sum --strict --check \
    && apt install --no-install-recommends -y --allow-unauthenticated ./griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* && rm griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb

WORKDIR /root

# Install swig v4.1.0 https://github.com/swig/swig/releases/tag/v4.1.0
RUN git config --global http.sslVerify false \
    && git clone https://github.com/swig/swig.git \
    && cd swig \
    && git checkout d22b7dfaea1f7abd4f3d0baecc1a1eddff827561 \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && rm -rf ../swig

# Install GridDB PHP Client
RUN curl -L -k https://github.com/griddb/php_client/archive/refs/tags/${GRIDDB_PHP_VERSION}.tar.gz -o ${GRIDDB_PHP_VERSION}.tar.gz -sS \
    && echo "$GRIDDB_PHP_DOWNLOAD_SHA512 ${GRIDDB_PHP_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf ${GRIDDB_PHP_VERSION}.tar.gz \
    && cd php_client-${GRIDDB_PHP_VERSION} \
    && make \
    && rm ../${GRIDDB_PHP_VERSION}.tar.gz

# Add path description
RUN mv php_client-${GRIDDB_PHP_VERSION} php_client \
    && echo extension=/root/php_client/griddb_php_client.so >> /etc/php/${PHP_VERSION}/cli/php.ini

# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh /root/.
COPY sample1_fixlist.php /root/php_client/

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
