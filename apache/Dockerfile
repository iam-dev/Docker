# VERSION 0.1
# DOCKER-VERSION 17.12.0-ce, build c97c6d6

FROM ubuntu:17.10

MAINTAINER IaM <DEVELOPER>

ENV GITHUB_REPOSITORY  https://github.com/iam-dev/Docker/tree/master
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

ADD ${GITHUB_REPOSITORY}/apache/index.html /var/www/html/index.html
ADD ${GITHUB_REPOSITORY}/vendor.zip /var/www/html/

# cleanup install
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
EXPOSE 80 

CMD ["apache2ctl", "-D", "FOREGROUND"]]