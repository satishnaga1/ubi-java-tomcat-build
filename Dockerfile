# Build arguments
ARG UBI_VERSION=9
ARG JAVA_VERSION=17
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.115

# Base image
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi

# Make JAVA_VERSION available in this stage
ENV JAVA_VERSION=${JAVA_VERSION}

# Install Java
RUN dnf -y module reset java && \
    if [ "$JAVA_VERSION" = "11" ]; then \
        dnf -y module enable java-11; \
        dnf -y install java-11-openjdk wget tar; \
    elif [ "$JAVA_VERSION" = "17" ]; then \
        dnf -y module enable java-17; \
        dnf -y install java-17-openjdk wget tar; \
    else \
        echo "Unsupported JAVA_VERSION: $JAVA_VERSION" && exit 1; \
    fi && \
    dnf clean all

WORKDIR /opt

# Download and extract Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} tomcat && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
