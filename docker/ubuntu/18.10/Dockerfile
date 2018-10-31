# BP: Keep base image small
# Faster builds
# Less storage
# Image pulls are faster
# Potentially less attack surface
FROM ubuntu:18.10
LABEL maintainer="hasan.mohamadally@misys.com"

ARG HOME_DIST
ENV HOME_DIST=${HOME_DIST:-/home}

#BP: Use USER to specify non-root user for containers
RUN apt-get update -y -qq \
    && apt-get install -y -qq --no-install-recommends \
        curl \
    && groupadd -r swuser -g 433 \
    && useradd -u 431 -r -g swuser -d ${HOME_DIST} -s /sbin/nologin -c "Docker image user" swuser \
    && chown -R swuser:swuser ${HOME_DIST}

USER swuser