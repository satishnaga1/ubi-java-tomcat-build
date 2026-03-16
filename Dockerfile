# -------------------------------
# Base image
# -------------------------------
ARG UBI_VERSION=9
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi:latest

# -------------------------------
# Build arguments
# -------------------------------
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.115

ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# -------------------------------
# Install Java and tools
# -------------------------------
RUN dnf -y install java-17-openjdk-headless wget tar && \
    dnf clean all

# -------------------------------
# Install Tomcat
# -------------------------------
RUN mkdir -p /opt/tomcat && \
    wget https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz --strip-components=1 -C /opt/tomcat && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# -------------------------------
# Create non-root user
# -------------------------------
RUN useradd -r tomcat && \
    chown -R tomcat:tomcat /opt/tomcat

USER tomcat

WORKDIR /opt/tomcat

# -------------------------------
# Expose port
# -------------------------------
EXPOSE 8080

# -------------------------------
# Start Tomcat
# -------------------------------
CMD ["catalina.sh","run"]
