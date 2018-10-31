FROM registry.misys.global.ad/solint/java-ubuntu:8u191-jre

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