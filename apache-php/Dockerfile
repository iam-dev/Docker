# VERSION 0.1
# DOCKER-VERSION 17.12.0-ce, build c97c6d6

FROM ubuntu:17.10

MAINTAINER IaM <DEVELOPER>

ENV GITHUB_REPOSITORY  https://raw.githubusercontent.com/iam-dev/Docker/master
ENV DOCKER_FILE_DIR apache-php

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

# Install common / shared packages
RUN apt-get install -y \
    curl \
    git \
    zip \
    unzip \
    vim \
    locales \
    software-properties-common \
    python-software-properties

# Add repository for latest built PHP packages, e.g. 7.12which isn't otherwise available in Xenial repositories
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

# Install PHP 7.2 with FPM and other various commonly used modules, including MySQL client
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    php7.0 php7.1-fpm \
    php7.1-bcmath php7.1-bz2 php7.1-cli php7.1-common php7.1-curl \
    php7.1-dev php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-intl \
    php7.1-json php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql \
    php7.1-odbc php7.1-opcache php7.1-pgsql php7.1-phpdbg php7.1-pspell \
    php7.1-readline php7.1-recode php7.1-soap php7.1-sqlite3 \
    php7.1-tidy php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip

ADD ${GITHUB_REPOSITORY}/${DOCKER_FILE_DIR}/app.zip /var/www/html/
ADD ${GITHUB_REPOSITORY}/vendor.zip /var/www/html/

# Unzip folders
RUN unzip /var/www/html/app.zip -d /var/www/html/ \
    && unzip /var/www/html/vendor.zip -d /var/www/html/

# Move app files to html folder
RUN mv /var/www/html/app/* /var/www/html/

# Enable apache mods.
RUN a2enmod7.1
RUN a2enmod rewrite

# Manually set up the apache enviroment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data

RUN chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www /var/www/*


# cleanup install
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/*.zip /var/www/html/app/

EXPOSE 80 

CMD ["apache2ctl", "-D", "FOREGROUND"]]