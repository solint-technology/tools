# BP: Keep base image small
# Faster builds
# Less storage
# Image pulls are faster
# Potentially less attack surface
# Image name: solint/ubuntu:18.04
FROM alpine:3.8
LABEL maintainer="hasan.mohamadally@misys.com"

ARG HOME_DIST
ENV HOME_DIST=${HOME_DIST:-/home}

RUN apk add --no-cache bash \
#BP: Use USER to specify non-root user for containers
    && addgroup -S swuser && adduser -S swuser -G swuser \
    && chown -R swuser:swuser ${HOME_DIST}

USER swuser

CMD ["/bin/bash"]