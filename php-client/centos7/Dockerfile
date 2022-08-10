FROM centos:centos7.9.2009

ENV GRIDDB_PHP_VERSION=0.8.1
ENV SWIG_VERSION=4.1.0
ENV CENTOS_VERSION=7

ENV GRIDDB_PHP_DOWNLOAD_SHA512=5a7516ef41219163e64749f19187091bcff7fb4ae07b23844688398d87213b04c1410068355b4f9ce2c011f8ca82a28a66fc47b889d02891fc783c395479f690
ENV EPEL_DOWNLOAD_SHA512=acaf8aabc5be8a8c57fb708bc38f15f3cc21f121fd4f8cb47e2fb61be222fa8bb56a55fe47880d59ebdbae90e4330daaae830f7048408fa4d304391df3f0d285
ENV REMI_DOWNLOAD_SHA512=e0787863785c1317634f10af3f90331f731fd2025870c16753f483e4a73ecff57abed04378d0124a4c85744a29b6e3f8d8c69f4d94946542102311c8007455c1

RUN set -eux \
    && yum update -y \
    # Install depencentcy for go client
    && yum install -y git wget pcre2-devel pcre-devel byacc make gcc gcc-c++ autoconf automake \
    # Add EPEL and REMI Repository
    && wget -q --no-check-certificate https://dl.fedoraproject.org/pub/epel/epel-release-latest-${CENTOS_VERSION}.noarch.rpm \
    && wget -q --no-check-certificate https://rpms.remirepo.net/enterprise/remi-release-${CENTOS_VERSION}.rpm \
    && echo "$EPEL_DOWNLOAD_SHA512 epel-release-latest-${CENTOS_VERSION}.noarch.rpm" | sha512sum --strict --check \
    && echo "$REMI_DOWNLOAD_SHA512 remi-release-${CENTOS_VERSION}.rpm" | sha512sum --strict --check \
    && rpm -ivh epel-release-latest-${CENTOS_VERSION}.noarch.rpm \
    && rpm -ivh remi-release-${CENTOS_VERSION}.rpm \
    # enable PHP 8.1 Remi repository
    && yum -y install yum-utils \
    && yum-config-manager --enable remi-php81 \
    && yum update -y \
    # install PHP 8.1
    && yum install -y php php-cli php-devel \
    && rm epel-release-latest-${CENTOS_VERSION}.noarch.rpm remi-release-${CENTOS_VERSION}.rpm \
    && yum clean all

# Install GridDB C Client
RUN cd /etc/yum.repos.d/ \
    && wget -q --no-check-certificate https://download.opensuse.org/repositories/home:knonomura/CentOS_7/home:knonomura.repo \
    && yum install -y griddb-c-client \
    && yum clean all

# Install swig v4.1.0 https://github.com/swig/swig/releases/tag/v4.1.0
RUN git clone https://github.com/swig/swig.git \
    && cd swig \
    && git checkout d22b7dfaea1f7abd4f3d0baecc1a1eddff827561 \
    && ./autogen.sh && ./configure \
    && make && make install \
    && rm -rf ../swig

WORKDIR /root
# Copy entrypoint script and sample for fixlist
COPY run-griddb.sh sample1_fixlist.php /root/

# Install GridDB PHP Client
RUN wget -q --no-check-certificate https://github.com/griddb/php_client/archive/refs/tags/${GRIDDB_PHP_VERSION}.tar.gz \
    && echo "$GRIDDB_PHP_DOWNLOAD_SHA512 ${GRIDDB_PHP_VERSION}.tar.gz" | sha512sum --strict --check \
    && tar -xzvf ${GRIDDB_PHP_VERSION}.tar.gz \
    && cd php_client-${GRIDDB_PHP_VERSION} \
    && make \
    && rm ../${GRIDDB_PHP_VERSION}.tar.gz

# Add path description
RUN mv php_client-${GRIDDB_PHP_VERSION} php_client \
    && echo extension=/root/php_client/griddb_php_client.so >> /etc/php.ini

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
