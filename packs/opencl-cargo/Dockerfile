FROM registry.misys.global.ad/solint/opencl-cargo:5.2.0.10002
EXPOSE 8181
ARG TARGETNAME
COPY --chown=swuser:swuser "$TARGETNAME" "$CARGOPATH"

USER root
ARG ELSPORT
RUN echo "els         $ELSPORT/tcp" >> /etc/services
RUN echo "els_port    $ELSPORT/tcp" >> /etc/services
USER swuser