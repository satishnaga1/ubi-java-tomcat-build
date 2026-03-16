ARG UBI_VERSION=10
FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi

ARG TOMCAT_MAJOR
ARG TOMCAT_VERSION

ENV CATALINA_HOME=/opt/tomcat

RUN dnf install -y java-21-openjdk curl tar gzip && \
    dnf clean all

# Set Java path
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

# Install Tomcat
RUN mkdir -p $CATALINA_HOME && \
    curl -fSL https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -o /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz --strip-components=1 -C $CATALINA_HOME && \
    rm -f /tmp/tomcat.tar.gz

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
