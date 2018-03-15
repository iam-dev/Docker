# VERSION 0.1
# DOCKER-VERSION 17.12.0-ce, build c97c6d6

FROM ubuntu:17.10

MAINTAINER IaM <DEVELOPER>

ENV GITHUB_REPOSITORY  https://raw.githubusercontent.com/iam-dev/Docker/master

# Install apache2
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

# Install tools
RUN apt-get install -y unzip

ADD ${GITHUB_REPOSITORY}/apache/app.zip /var/www/html/
ADD ${GITHUB_REPOSITORY}/vendor.zip /var/www/html/

# Unzip folders
RUN unzip /var/www/html/app.zip -d /var/www/html/ \
    && unzip /var/www/html/vendor.zip -d /var/www/html/

# Move app files to html folder
RUn mv /var/www/html/app/* /var/www/html/

RUN chown -R www-data:www-data /var/www /var/www/*


# cleanup install
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/*.zip /var/www/html/app/

EXPOSE 80 

CMD ["apache2ctl", "-D", "FOREGROUND"]]