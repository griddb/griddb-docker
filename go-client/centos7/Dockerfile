FROM centos:centos7.9.2009

ENV GRIDDB_C_VERSION=5.3.0
ENV GRIDDB_GO_VERSION=0.8.4
ENV SWIG_VERSION=4.0.2
ENV GO_VERSION=1.16

ENV GRIDDB_C_DOWNLOAD_SHA512=b7418bfc7bab5269779012a252f5c7a8d537f02e320e8f61036afde7377426b0a3a46dac541ef075b759923d9dc061743d3799f352e9bc70494eb138a2f58559
ENV GRIDDB_GO_DOWNLOAD_SHA512=23da4e91507888132991d017277f461374b8191c8d5c16d77fc0ff44badbf0e89464eb56e666d17115334c00e4a15b56b09741673c3d9092fc94c876f68f8ff3
ENV SWIG_DOWNLOAD_SHA512=c71b860c64bc8d3148513729ef719128342318f80f5b63a43663eae4172acc3628d91f394acf2496dadebb474f2a7a710a83714b53febfb0febd3cc986dde568
ENV GO_DOWNLOAD_SHA512=6b5f6a5b95df6a9c0e54d39b2d925427720e513160f757e51d8232360f83f7f6004c3afd410f6efc5d0667b523ea21f03d8d14cd0e31902009e0246c5c2a18c8

RUN set -eux \
    && yum update -y \
    # Install depencentcy for go client
    && yum install -y wget pcre2-devel pcre-devel byacc make gcc gcc-c++ autoconf automake \
    # Install go 1.12
    && wget -q --no-check-certificate https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
    && echo "$GO_DOWNLOAD_SHA512 go${GO_VERSION}.linux-amd64.tar.gz" | sha512sum --strict --check \
    && tar -xvf go${GO_VERSION}.linux-amd64.tar.gz \
    && mv go /usr/local \
    && ln -sf /usr/local/go/bin/go /usr/bin/go \
    && rm go${GO_VERSION}.linux-amd64.tar.gz \
    && yum clean all

# Install GridDB C Client
RUN cd /etc/yum.repos.d/ \
    && wget -q --no-check-certificate https://github.com/griddb/c_client/releases/download/v${GRIDDB_C_VERSION}/griddb-c-client-${GRIDDB_C_VERSION}-linux.x86_64.rpm \
    && yum install -y ./griddb-c-client-${GRIDDB_C_VERSION}-linux.x86_64.rpm \
    && yum clean all \
    && rm griddb-c-client-${GRIDDB_C_VERSION}-linux.x86_64.rpm

# Install swig v4.0.2 https://github.com/swig/swig/releases/tag/v4.0.2
RUN wget -q --no-check-certificate https://github.com/swig/swig/archive/refs/tags/v${SWIG_VERSION}.tar.gz \
    && echo "$SWIG_DOWNLOAD_SHA512 v${SWIG_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf v${SWIG_VERSION}.tar.gz \
    && cd swig-${SWIG_VERSION} \
    && ./autogen.sh && ./configure \
    && make && make install \
    && rm ../v${SWIG_VERSION}.tar.gz \
    && rm -rf ../swig-${SWIG_VERSION}

# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.go /root/

WORKDIR /root

# Install go client https://github.com/griddb/go_client/releases/tag/0.8.3
RUN wget -q --no-check-certificate https://github.com/griddb/go_client/archive/refs/tags/${GRIDDB_GO_VERSION}.tar.gz \
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
