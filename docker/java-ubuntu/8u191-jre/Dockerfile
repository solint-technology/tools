# Image name: solint/java-ubuntu:8u181-jre
FROM registry.misys.global.ad/solint/ubuntu:18.10
LABEL maintainer="hasan.mohamadally@misys.com"

ENV LANG en_US.UTF-8
ENV JAVA_HOME /opt/java/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

USER root

#install tools, java
RUN mkdir -p ${JAVA_HOME} \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/server-jre-8u191-linux-x64.tar.gz \
        | tar -xzC ${JAVA_HOME} --strip-components=1

USER swuser

CMD ["/bin/bash"]