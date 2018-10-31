# Image name: solint/opencl-ubuntu:5.2.0.10002
FROM registry.misys.global.ad/solint/opencl-ubuntu:5.2.0.10002
LABEL maintainer="olden.fabre@finastra.com"


ENV SHELLSCRIPT bin/server.sh
ENV RUNCMD run
ENV CARGOPATH /opt/cargoproduct

ARG POMVERSION=""

USER root

COPY entrypoint.sh /
RUN chown swuser /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER swuser

CMD ["/entrypoint.sh"]