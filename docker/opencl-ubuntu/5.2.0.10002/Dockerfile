# Image name: solint/opencl-ubuntu:5.2.0.10002
FROM registry.misys.global.ad/solint/java-ubuntu:8u191-jre
LABEL maintainer="hasan.mohamadally@misys.com"


ARG INSTALLER_WORKDIR=${INSTALLER_WORKDIR:-/tmp/installer}

ARG OPENCL_VERSION
ENV OPENCL_VERSION ${OPENCL_VERSION:-opencl_runtime_16.1_x64_rh_5.2.0.10002}

WORKDIR ${INSTALLER_WORKDIR}

USER root

#install tools and opencl
RUN apt-get update -y -qq \
    && apt-get install -y wget numactl libnuma1 pciutils ocl-icd-libopencl1 ocl-icd-opencl-dev cpio --no-install-recommends \
	&& apt-get -y autoclean && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && wget -nv --no-check-certificate http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/${OPENCL_VERSION}.tgz \
    && tar -xf ${OPENCL_VERSION}.tgz \
    && rm ${OPENCL_VERSION}.tgz \
    && sed "s/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g" ${OPENCL_VERSION}/silent.cfg > ${OPENCL_VERSION}/accept.cfg \
    && ${OPENCL_VERSION}/install.sh --silent ${OPENCL_VERSION}/accept.cfg --cli-mode \
    && rm -rf ${OPENCL_VERSION}

USER swuser

CMD ["/bin/bash"]