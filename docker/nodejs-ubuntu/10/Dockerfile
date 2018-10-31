# Image name: solint/nodejs-ubuntu:10
FROM registry.misys.global.ad/solint/ubuntu:18.10

USER root

RUN apt update \
 && apt install -y \
    gnupg \
    gcc \
    g++ \
    make \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt install -y nodejs \
 && rm -rf /var/lib/apt/lists/*

USER swuser

CMD ["/bin/bash"]


#https://linuxconfig.org/how-to-install-node-js-on-ubuntu-18-04-bionic-beaver-linux