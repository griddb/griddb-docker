FROM java:8

# Install maven
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_BASE=apache-maven-${MAVEN_VERSION}
RUN curl -OL https://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz &&\
    tar zxvf ${MAVEN_BASE}-bin.tar.gz && mv $MAVEN_BASE /opt/maven
ENV PATH=$PATH:/opt/maven/bin

WORKDIR /root
COPY JDBCSelect.java /root
COPY run-griddb.sh /root

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Get dependency for griddb jdbc
RUN mvn dependency:get -Dartifact=com.github.griddb:gridstore-jdbc:4.5.0.1 -Ddest=./gridstore-jdbc.jar

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
