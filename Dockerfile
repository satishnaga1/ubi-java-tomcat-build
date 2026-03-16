ARG UBI_VERSION
ARG JAVA_VERSION
ARG TOMCAT_MAJOR
ARG TOMCAT_VERSION

FROM registry.access.redhat.com/ubi${UBI_VERSION}/ubi

RUN dnf install -y java-${JAVA_VERSION}-openjdk wget tar \
 && dnf clean all

WORKDIR /opt

RUN wget https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
 && tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
 && mv apache-tomcat-${TOMCAT_VERSION} tomcat \
 && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh","run"]
