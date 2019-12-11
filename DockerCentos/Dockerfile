FROM centos:latest
LABEL description="1.0" maintainer="Vinícius Alcântara"
RUN yum update -y && \
    yum install vim net-tools unzip -y && \
    useradd -d /backups -m -s /bin/bash vinicius && \ 
    yum clean all
WORKDIR /backups
USER vinicius








