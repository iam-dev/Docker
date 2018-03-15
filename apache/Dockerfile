# VERSION 0.1
# DOCKER-VERSION 17.12.0-ce, build c97c6d6

FROM ubuntu:17.10

MAINTAINER IaM <DEVELOPER>

RUN buildDeps='xz-utils' \
    && ARCH= && dpkgArch="$(dpkg --print-architecture)" \
    && case "${dpkgArch##*-}" in \
      amd64) ARCH='x64';; \
      ppc64el) ARCH='ppc64le';; \
      s390x) ARCH='s390x';; \
      arm64) ARCH='arm64';; \
      armhf) ARCH='armv7l';; \
      i386) ARCH='x86';; \
      *) echo "unsupported architecture"; exit 1 ;; \
    esac \
    && set -x \     && apt-get update \
    && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get install -y apache2

EXPOSE 80 

CMD ["apache2ctl", "-D", "FOREGROUND"]]