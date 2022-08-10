FROM centos:centos7.9.2009

ENV GRIDDB_PYTHON_API_VERSION=0.8.5
ENV SWIG_VERSION=4.0.2

ENV SWIG_DOWNLOAD_SHA512=c71b860c64bc8d3148513729ef719128342318f80f5b63a43663eae4172acc3628d91f394acf2496dadebb474f2a7a710a83714b53febfb0febd3cc986dde568
ENV GRIDDB_PYTHON_DOWNLOAD_SHA512=ac019ae5293019c946f11d775064f99a03b7e5cd84ac7fb4878994a27fc20c939070ec5bcc1360aa14c70eac6b379bd391d3f7fd3c73f35c684228c1b92ae6bc
ENV PYTHONPATH=/root/python_client-${GRIDDB_PYTHON_API_VERSION}

RUN set -eux \
    && yum update -y \
    # Install dependency for GridDB Python API
    && yum install -y wget python3-pip python3-devel make autotools-dev automake pcre pcre-devel gcc gcc-c++ byacc \
    && wget -q https://download.opensuse.org/repositories/home:knonomura/CentOS_7/home:knonomura.repo -P /etc/yum.repos.d/ \
    && yum install -y griddb-c-client \
    && python3 -m pip --no-cache-dir install numpy pandas \
    && yum clean all

WORKDIR /root
RUN wget -q https://github.com/swig/swig/archive/refs/tags/v${SWIG_VERSION}.tar.gz \
    && echo "${SWIG_DOWNLOAD_SHA512} v${SWIG_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar xvfz v${SWIG_VERSION}.tar.gz \
    && cd swig-${SWIG_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -R swig-${SWIG_VERSION} v${SWIG_VERSION}.tar.gz

RUN wget -q https://github.com/griddb/python_client/archive/refs/tags/${GRIDDB_PYTHON_API_VERSION}.tar.gz \
    && echo "${GRIDDB_PYTHON_DOWNLOAD_SHA512} ${GRIDDB_PYTHON_API_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar xvfz ${GRIDDB_PYTHON_API_VERSION}.tar.gz \
    && cd python_client-${GRIDDB_PYTHON_API_VERSION} \
    && make \
    && cd .. \
    && rm ${GRIDDB_PYTHON_API_VERSION}.tar.gz

# Copy entrypoint script and sample for fixed_list
COPY run-griddb.sh sample1_fixlist.py /root/

# Set permission executable for script
RUN chmod a+x run-griddb.sh

CMD ["/bin/bash", "run-griddb.sh"]
