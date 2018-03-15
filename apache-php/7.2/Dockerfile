# VERSION 0.5
# DOCKER-VERSION 17.12.0-ce, build c97c6d6

FROM ubuntu:17.10

MAINTAINER IaM <DEVELOPER>

ENV GITHUB_REPOSITORY  https://raw.githubusercontent.com/iam-dev/Docker/master
ENV DOCKER_FILE_DIR apache-php
ENV PHP_VERSION 7.2

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

# Add repository for latest built PHP packages, e.g. 7.2 which isn't otherwise available in Xenial repositories
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install PHP 7.2 with FPM and other various commonly used modules, including MySQL client
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    php${PHP_VERSION} php${PHP_VERSION}-fpm libapache2-mod-php${PHP_VERSION} libapache2-mod-php \
    php${PHP_VERSION}-bcmath php${PHP_VERSION}-bz2 php${PHP_VERSION}-cli php${PHP_VERSION}-common php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dev php${PHP_VERSION}-fpm php${PHP_VERSION}-gd php${PHP_VERSION}-gmp php${PHP_VERSION}-imap php${PHP_VERSION}-intl \
    php${PHP_VERSION}-json php${PHP_VERSION}-ldap php${PHP_VERSION}-mbstring php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-odbc php${PHP_VERSION}-opcache php${PHP_VERSION}-pgsql php${PHP_VERSION}-phpdbg php${PHP_VERSION}-pspell \
    php${PHP_VERSION}-readline php${PHP_VERSION}-recode php${PHP_VERSION}-soap php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-tidy php${PHP_VERSION}-xml php${PHP_VERSION}-xmlrpc php${PHP_VERSION}-xsl php${PHP_VERSION}-zip

ADD ${GITHUB_REPOSITORY}/${DOCKER_FILE_DIR}/${PHP_VERSION}/app.zip /var/www/html/
ADD ${GITHUB_REPOSITORY}/vendor.zip /var/www/html/
ADD ${GITHUB_REPOSITORY}/${DOCKER_FILE_DIR}/${PHP_VERSION}/run.sh /run.sh
ADD ${GITHUB_REPOSITORY}/${DOCKER_FILE_DIR}/${PHP_VERSION}/001-docker.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/001-docker.conf /etc/apache2/sites-enabled/

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
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

RUN chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www /var/www/*
RUN chmod +x /run.sh

# cleanup install
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/*.zip /var/www/html/app/

EXPOSE 80 

CMD ["apache2ctl", "-D", "FOREGROUND"]]