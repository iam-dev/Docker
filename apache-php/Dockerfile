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

# Set up locales
RUN locale-gen en_US.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
RUN /usr/sbin/update-locale

# Add repository for latest built PHP packages, e.g. 7.12which isn't otherwise available in Xenial repositories
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install PHP 7.2 with FPM and other various commonly used modules, including MySQL client
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    php7.2 php7.2-fpm libapache2-mod-php7.2 libapache2-mod-php \
    php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-common php7.2-curl \
    php7.2-dev php7.2-fpm php7.2-gd php7.2-gmp php7.2-imap php7.2-intl \
    php7.2-json php7.2-ldap php7.2-mbstring php7.2-mysql \
    php7.2-odbc php7.2-opcache php7.2-pgsql php7.2-phpdbg php7.2-pspell \
    php7.2-readline php7.2-recode php7.2-soap php7.2-sqlite3 \
    php7.2-tidy php7.2-xml php7.2-xmlrpc php7.2-xsl php7.2-zip

ADD ${GITHUB_REPOSITORY}/${DOCKER_FILE_DIR}/app.zip /var/www/html/
ADD ${GITHUB_REPOSITORY}/vendor.zip /var/www/html/

# Unzip folders
RUN unzip /var/www/html/app.zip -d /var/www/html/ \
    && unzip /var/www/html/vendor.zip -d /var/www/html/

# Move app files to html folder
RUN mv /var/www/html/app/* /var/www/html/

# Enable apache mods.
RUN a2enmod php7.2
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