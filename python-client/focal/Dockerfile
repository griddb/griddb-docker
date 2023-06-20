FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GRIDDB_C_VERSION=5.3.0
ENV GRIDDB_PYTHON_API_VERSION=0.8.5
ENV SWIG_VERSION=4.0.2

ENV GRIDDB_C_DOWNLOAD_SHA512=a9a766c87851d1f3945fbc9706523399448d4517272cf9d9bc3415b4278d6d650b75c8c5446501d3cd6420c68b6e1887b7cb9a2cc42a6a357257cc0fd8cf6ee2
ENV SWIG_DOWNLOAD_SHA512=c71b860c64bc8d3148513729ef719128342318f80f5b63a43663eae4172acc3628d91f394acf2496dadebb474f2a7a710a83714b53febfb0febd3cc986dde568
ENV GRIDDB_PYTHON_DOWNLOAD_SHA512=ac019ae5293019c946f11d775064f99a03b7e5cd84ac7fb4878994a27fc20c939070ec5bcc1360aa14c70eac6b379bd391d3f7fd3c73f35c684228c1b92ae6bc
ENV PYTHONPATH=/root/python_client-${GRIDDB_PYTHON_API_VERSION}

RUN set -eux \
    && apt-get update -y \
    # Install dependencies for griddb python_client
    && apt-get install --no-install-recommends -y python3 python3-pip python3-dev make autotools-dev automake gcc g++ libpcre3 libpcre3-dev byacc curl gnupg2 \
    && python3 -m pip --no-cache-dir install numpy pandas \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Install GridDB C Client
RUN curl -L -k https://github.com/griddb/c_client/releases/download/v${GRIDDB_C_VERSION}/griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -o griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb -sS \
    && echo "$GRIDDB_C_DOWNLOAD_SHA512 griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb" | sha512sum --strict --check \
    && apt install --no-install-recommends -y --allow-unauthenticated ./griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* && rm griddb-c-client_${GRIDDB_C_VERSION}_amd64.deb

WORKDIR /root
# Install SWIG v4.0.2
RUN curl -L https://github.com/swig/swig/archive/refs/tags/v${SWIG_VERSION}.tar.gz -o v${SWIG_VERSION}.tar.gz -sS \
    && echo "${SWIG_DOWNLOAD_SHA512} v${SWIG_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar xvfz v${SWIG_VERSION}.tar.gz \
    && cd swig-${SWIG_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -R v${SWIG_VERSION}.tar.gz swig-${SWIG_VERSION}

# Install GridDB python client
RUN curl -L https://github.com/griddb/python_client/archive/refs/tags/${GRIDDB_PYTHON_API_VERSION}.tar.gz -o ${GRIDDB_PYTHON_API_VERSION}.tar.gz -sS \
    && echo "${GRIDDB_PYTHON_DOWNLOAD_SHA512} ${GRIDDB_PYTHON_API_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar xvfz ${GRIDDB_PYTHON_API_VERSION}.tar.gz \
    && cd python_client-${GRIDDB_PYTHON_API_VERSION} \
    && make \
    && rm /root/${GRIDDB_PYTHON_API_VERSION}.tar.gz

WORKDIR /root
# Copy entrypoint script and sample for fixed_list
COPY run-griddb.sh sample1_fixlist.py /root/

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
