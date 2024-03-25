FROM ubuntu:22.04

# Install maven
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_BASE=apache-maven-${MAVEN_VERSION}
ENV PATH=$PATH:/opt/maven/bin

RUN set -eux \
    && apt-get -y update \
    && apt-get install -y curl default-jdk maven

RUN curl -OL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_BASE}-bin.tar.gz \
    && tar zxvf ${MAVEN_BASE}-bin.tar.gz && mv $MAVEN_BASE /opt/maven

WORKDIR /root
COPY JDBCSelect.java JDBCSelect_fixlist.java run-griddb.sh /root/

RUN set -eux \
    # Set permission executable for script
    && chmod a+x run-griddb.sh \
    # Get dependency for griddb jdbc
    && mvn dependency:get -Dartifact=com.github.griddb:gridstore-jdbc:5.3.0 -Ddest=./gridstore-jdbc.jar

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
