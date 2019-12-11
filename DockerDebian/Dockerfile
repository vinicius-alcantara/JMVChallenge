FROM debian:latest
LABEL description="1.0" maintainer="Vinícius Alcântara"
RUN apt-get update && \
    apt-get install vim net-tools unzip -y && \
    useradd -d /backups -m -s /bin/bash vinicius && \ 
    apt-get clean
WORKDIR /backups
USER vinicius








