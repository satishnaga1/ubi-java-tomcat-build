ARG UBI_VERSION=9
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi:latest

ARG TOMCAT_MAJOR
ARG TOMCAT_VERSION

ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Install required packages
RUN dnf install -y java-21-openjdk curl tar gzip && \
    dnf clean all
#RUN dnf update -y && \
 #   if [ "$UBI_VERSION" = "10" ]; then \
 #       dnf install -y java-21-openjdk curl tar gzip; \
#    else \
#        dnf install -y java-17-openjdk curl tar gzip; \
 #   fi && \
#    dnf clean all

# Download Tomcat
RUN mkdir -p $CATALINA_HOME && \
    curl -fSL https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -o /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz --strip-components=1 -C $CATALINA_HOME && \
    rm -f /tmp/tomcat.tar.gz

EXPOSE 8080

CMD ["catalina.sh", "run"]
