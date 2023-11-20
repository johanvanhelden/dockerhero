FROM php:8.3-fpm

LABEL maintainer="Johan van Helden <johan@johanvanhelden.com>"

ARG TZ=UTC
ENV TZ ${TZ}

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Install dependencies
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libcurl4-nss-dev \
    libc-client-dev \
    libkrb5-dev \
    firebird-dev \
    libicu-dev \
    libxml2-dev \
    libxslt1-dev \
    autoconf \
    wget \
    zip \
    unzip \
    cron \
    git \
    libzip-dev \
    locales-all \
    libonig-dev \
    wkhtmltopdf

RUN install-php-extensions \
    bcmath \
    exif \
    gd \
    imagick \
    imap \
    intl \
    mysqli \
    pdo_mysql \
    redis \
    soap \
    ssh2 \
    xdebug \
    xmlrpc \
    xsl \
    zip

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Comment out xdebug extension line per default
RUN sed -i 's/^zend_extension=/;zend_extension=/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Copy xdebug configuration for remote debugging
COPY ./includes/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Copy the php-fpm config
COPY ./includes/dockerhero.fpm.conf /usr/local/etc/php-fpm.d/zzz-dockerhero.fpm.conf
COPY ./includes/dockerhero.php.ini /usr/local/etc/php/conf.d/dockerhero.php.ini

# Setup mhsendmail
COPY ./includes/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN chmod +x /usr/local/bin/mhsendmail

# Cleanup all downloaded packages
RUN apt-get -y autoclean && apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* && apt-get update

# Set the proper permissions
RUN usermod -u 1000 www-data

# Add the startup script and set executable
COPY ./includes/.startup.sh /var/scripts/.startup.sh
RUN chmod +x /var/scripts/.startup.sh

# Run the startup script
CMD ["/var/scripts/.startup.sh"]
