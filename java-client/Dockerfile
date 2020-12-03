FROM java:8

# Set environment
ENV MAVEN_VERSION=3.5.2
ENV MAVEN_BASE=apache-maven-${MAVEN_VERSION}
ENV PATH=$PATH:/opt/maven/bin

# Download and install maven
RUN curl -OL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_BASE}-bin.tar.gz &&\
    tar zxvf ${MAVEN_BASE}-bin.tar.gz && mv $MAVEN_BASE /opt/maven

# Download sample for griddb java client
RUN wget https://raw.githubusercontent.com/griddb/griddb_nosql/master/docs/sample/program/Sample1.java \
    && mkdir -p /root/gsSample \
    && cp Sample1.java /root/gsSample/.

COPY run-griddb.sh /root/.

WORKDIR /root

# Set permission executable for script
RUN chmod a+x run-griddb.sh

# Get dependency for griddb java-client
RUN mvn dependency:get -Dartifact=com.github.griddb:gridstore:4.5.0 -Ddest=./gridstore.jar

# Run sample
CMD ["/bin/bash", "run-griddb.sh"]
