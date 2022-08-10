FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV GO_VERSION=1.16
ENV GRIDDB_GO_VERSION=0.8.4
ENV SWIG_VERSION=4.0.2

ENV GRIDDB_GO_DOWNLOAD_SHA512=23da4e91507888132991d017277f461374b8191c8d5c16d77fc0ff44badbf0e89464eb56e666d17115334c00e4a15b56b09741673c3d9092fc94c876f68f8ff3
ENV SWIG_DOWNLOAD_SHA512=c71b860c64bc8d3148513729ef719128342318f80f5b63a43663eae4172acc3628d91f394acf2496dadebb474f2a7a710a83714b53febfb0febd3cc986dde568

RUN set -eux \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y curl byacc libpcre3 libpcre3-dev make autoconf automake gcc g++ \
    && apt-get install --no-install-recommends -y --assume-yes software-properties-common \
    # Install go
    && add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y --assume-yes golang-${GO_VERSION} \
    && ln -sf /usr/lib/go-${GO_VERSION}/bin/go /usr/bin/go \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Install GridDB C Client
RUN echo 'deb http://download.opensuse.org/repositories/home:/knonomura/xUbuntu_18.04/ /' | tee /etc/apt/sources.list.d/home:knonomura.list \
    && curl -fsSL https://download.opensuse.org/repositories/home:knonomura/xUbuntu_18.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_knonomura.gpg > /dev/null \
    && apt-get -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update \
    && apt-get install --no-install-recommends -y --allow-unauthenticated griddb-c-client \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.go /root/

WORKDIR /root

# Install swig v4.0.2 https://github.com/swig/swig/releases/tag/v4.0.2
RUN curl -L -k https://github.com/swig/swig/archive/refs/tags/v${SWIG_VERSION}.tar.gz -o v${SWIG_VERSION}.tar.gz -sS \
    && echo "${SWIG_DOWNLOAD_SHA512} v${SWIG_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar xvfz v${SWIG_VERSION}.tar.gz \
    && cd swig-${SWIG_VERSION} \
    && ./autogen.sh && ./configure \
    && make && make install \
    && rm ../v${SWIG_VERSION}.tar.gz \
    && rm -rf ../swig-${SWIG_VERSION}

# Install go client https://github.com/griddb/go_client/releases/tag/0.8.4
RUN curl -L -k https://github.com/griddb/go_client/archive/refs/tags/${GRIDDB_GO_VERSION}.tar.gz -o ${GRIDDB_GO_VERSION}.tar.gz -sS \
    && echo "$GRIDDB_GO_DOWNLOAD_SHA512 ${GRIDDB_GO_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf ${GRIDDB_GO_VERSION}.tar.gz \
    && go env -w GO111MODULE=off  \
    && cd go_client-${GRIDDB_GO_VERSION} \
    && ./run_swig.sh && go install \
    && rm ../${GRIDDB_GO_VERSION}.tar.gz

RUN mkdir -p go/src/github.com/griddb \
    && mv go_client-${GRIDDB_GO_VERSION} go/src/github.com/griddb/go_client

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
