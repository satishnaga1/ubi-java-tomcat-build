# Build arguments
ARG UBI_VERSION=9
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.115

# Base image
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi

# Make JAVA_VERSION available in this stage
#ENV JAVA_VERSION=${JAVA_VERSION}
# Install Java 17 and tools
RUN dnf -y module reset java && \
    dnf -y module enable java-17 && \
    dnf -y install java-17-openjdk wget tar && \
    dnf clean all

WORKDIR /opt

# Download and extract Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} tomcat && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
