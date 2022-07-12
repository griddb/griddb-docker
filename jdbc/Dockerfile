FROM java:8

# Install maven
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_BASE=apache-maven-${MAVEN_VERSION}
ENV PATH=$PATH:/opt/maven/bin

RUN curl -OL https://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz \
    && tar zxvf ${MAVEN_BASE}-bin.tar.gz && mv $MAVEN_BASE /opt/maven

WORKDIR /root
COPY JDBCSelect.java JDBCSelect_fixlist.java run-griddb.sh /root/

RUN set -eux \
    # Set permission executable for script
    && chmod a+x run-griddb.sh \
    # Get dependency for griddb jdbc
    && mvn dependency:get -Dartifact=com.github.griddb:gridstore-jdbc:5.0.0 -Ddest=./gridstore-jdbc.jar

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
