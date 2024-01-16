FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV GRIDDB_C_VERSION=5.3.0
ENV GRIDDB_GO_VERSION=0.8.4
ENV SWIG_VERSION=4.0.2
ENV GO_VERSION=1.16

ENV GRIDDB_C_DOWNLOAD_SHA512=a9a766c87851d1f3945fbc9706523399448d4517272cf9d9bc3415b4278d6d650b75c8c5446501d3cd6420c68b6e1887b7cb9a2cc42a6a357257cc0fd8cf6ee2
ENV GRIDDB_GO_DOWNLOAD_SHA512=23da4e91507888132991d017277f461374b8191c8d5c16d77fc0ff44badbf0e89464eb56e666d17115334c00e4a15b56b09741673c3d9092fc94c876f68f8ff3
ENV SWIG_DOWNLOAD_SHA512=c71b860c64bc8d3148513729ef719128342318f80f5b63a43663eae4172acc3628d91f394acf2496dadebb474f2a7a710a83714b53febfb0febd3cc986dde568
ENV GO_DOWNLOAD_SHA512=6b5f6a5b95df6a9c0e54d39b2d925427720e513160f757e51d8232360f83f7f6004c3afd410f6efc5d0667b523ea21f03d8d14cd0e31902009e0246c5c2a18c8

RUN set -eux \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y curl gcc g++ byacc libpcre3 libpcre3-dev make autoconf automake ca-certificates \
    # Install go 1.16
    && curl -L https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -o go${GO_VERSION}.linux-amd64.tar.gz -sS \
    && echo "$GO_DOWNLOAD_SHA512 go${GO_VERSION}.linux-amd64.tar.gz" | sha512sum --strict --check \
    && tar -xvf go${GO_VERSION}.linux-amd64.tar.gz \
    && mv go /usr/local \
    && ln -sf /usr/local/go/bin/go /usr/bin/go \
    && rm go${GO_VERSION}.linux-amd64.tar.gz \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Install GridDB C Client
RUN curl -L -k https://github.com/griddb/c_client/releases/download/v${GRIDDB_C_VERSION}/griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -o griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -sS \
    && echo "$GRIDDB_C_DOWNLOAD_SHA512 griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb" | sha512sum --strict --check \
    && apt install --no-install-recommends -y --allow-unauthenticated ./griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* && rm griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb

# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.go /root/

# WORKDIR /root
WORKDIR /root

# Install swig v4.0.2 https://github.com/swig/swig/releases/tag/v4.0.2
RUN curl -L -k https://github.com/swig/swig/archive/refs/tags/v${SWIG_VERSION}.tar.gz -o v${SWIG_VERSION}.tar.gz -sS \
    && echo "$SWIG_DOWNLOAD_SHA512 v${SWIG_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf v${SWIG_VERSION}.tar.gz \
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
