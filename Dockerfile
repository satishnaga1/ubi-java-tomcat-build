# -------------------------------
# Base image
# -------------------------------
ARG UBI_VERSION=9
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi:latest

# -------------------------------
# Build arguments for Tomcat
# -------------------------------
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.115

# Export as environment variables for shell access
ENV TOMCAT_MAJOR=$TOMCAT_MAJOR
ENV TOMCAT_VERSION=$TOMCAT_VERSION

# -------------------------------
# Install Java 17 and basic tools
# -------------------------------
RUN dnf -y install java-17-openjdk wget tar && \
    dnf clean all

# -------------------------------
# Download and extract Tomcat
# -------------------------------
RUN wget https://downloads.apache.org/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz && \
    tar -xzf apache-tomcat-$TOMCAT_VERSION.tar.gz && \
    mv apache-tomcat-$TOMCAT_VERSION tomcat && \
    rm apache-tomcat-$TOMCAT_VERSION.tar.gz

# -------------------------------
# Set working directory
# -------------------------------
WORKDIR /opt/

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["bin/catalina.sh", "run"]
