ARG UBI_VERSION=9
ARG JAVA_VERSION=17
ENV JAVA_VERSION=${JAVA_VERSION}
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.115

FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi

# Map JAVA_VERSION to module/package names
RUN if [ "$JAVA_VERSION" = "11" ]; then \
        dnf module enable -y java-11 && dnf install -y java-11-openjdk wget tar; \
    elif [ "$JAVA_VERSION" = "17" ]; then \
        dnf module enable -y java-17 && dnf install -y java-17-openjdk wget tar; \
    else \
        echo "Unsupported JAVA_VERSION: $JAVA_VERSION" && exit 1; \
    fi \
    && dnf clean all

WORKDIR /opt

RUN wget https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
 && tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
 && mv apache-tomcat-${TOMCAT_VERSION} tomcat \
 && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh","run"]
