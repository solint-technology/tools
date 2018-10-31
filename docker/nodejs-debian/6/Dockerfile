# Image name: solint/nodejs-debian:6
FROM node:6.14.4-slim

ARG HOME_DIST
ENV HOME_DIST=${HOME_DIST:-/home}

#BP: Use USER to specify non-root user for containers
RUN groupadd -r swuser -g 433 \
    && useradd -u 431 -r -g swuser -d ${HOME_DIST} -s /sbin/nologin -c "Docker image user" swuser \
    && chown -R swuser:swuser ${HOME_DIST}

USER swuser

CMD ["/bin/bash"]