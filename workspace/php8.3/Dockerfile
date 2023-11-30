FROM phusion/baseimage:focal-1.0.0

LABEL maintainer="Johan van Helden <johan@johanvanhelden.com>"

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

# Set environment variables
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

ENV NVM_DIR /home/dockerhero/.nvm

ENV PUID=1000
ENV PGID=1000

ARG TZ=UTC
ENV TZ ${TZ}

# Add the "PHP 8" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y \
    mysql-client \
    pkg-config \
    php8.3-bcmath \
    php8.3-cli \
    php8.3-common \
    php8.3-curl \
    php8.3-xml \
    php8.3-imap \
    php8.3-intl \
    php8.3-mbstring \
    php8.3-mysql \
    php8.3-pcov \
    php8.3-pgsql \
    php8.3-soap \
    php8.3-sqlite \
    php8.3-sqlite3 \
    php8.3-zip \
    php8.3-memcached \
    php8.3-gd \
    php8.3-redis \
    # php8.3-xdebug \
    php8.3-dev \
    php8.3-imagick \
    php-pear \
    wget \
    make \
    libaio1 \
    libaio-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libssl-dev \
    libxml2-dev \
    libsqlite3-dev \
    xz-utils \
    sqlite3 \
    git \
    curl \
    vim \
    nano \
    postgresql-client \
    git \
    mercurial \
    zip \
    unzip \
    vim \
    bash-completion \
    xvfb gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable imagemagick x11-apps \
    locales-all \
    wkhtmltopdf \
    && apt-get clean

# Force the proper PHP version
RUN update-alternatives --set php /usr/bin/php8.3 && \
    update-alternatives --set phar /usr/bin/phar8.3 && \
    update-alternatives --set phar.phar /usr/bin/phar.phar8.3

# Disable Xdebug per default
# RUN sed -i 's/^zend_extension=/;zend_extension=/g' /etc/php/8.3/cli/conf.d/20-xdebug.ini

#Install chrome - needed for Laravel Dusk
RUN curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

# Add a non-root user to prevent files being created with root permissions on host machine.
RUN groupadd -g $PGID dockerhero && \
    useradd -u $PUID -g dockerhero -m dockerhero

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Composer for Laravel/Codeigniter
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Install nvm (A Node Version Manager)
USER dockerhero
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.3/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 16 && \
    nvm install 17 && \
    nvm install 18 && \
    nvm install 19 && \
    nvm use 18 && \
    nvm alias default 18

# Wouldn't execute when added to the RUN statement in the above block
# Source NVM when loading bash since ~/.profile isn't loaded on non-login shell
RUN echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc

# Add NVM binaries to root's .bashrc
USER root
RUN echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="/home/dockerhero/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc

#Install Yarn
USER dockerhero
RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash; \
    echo "" >> ~/.bashrc && \
    echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.bashrc

# Add Yarn binaries to root's .bashrc
USER root
RUN echo "" >> ~/.bashrc && \
    echo 'export YARN_DIR="/home/dockerhero/.yarn"' >> ~/.bashrc && \
    echo 'export PATH="$YARN_DIR/bin:$PATH"' >> ~/.bashrc

# Copy artisan autocompleter to the proper folder
COPY ./includes/artisan-autocompletion.sh /etc/bash_completion.d/artisan

# Add an artisan alias to .bashrc
RUN echo "" >> /home/dockerhero/.bashrc && \
    echo 'alias artisan="php artisan"' >> /home/dockerhero/.bashrc

# Clean up
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default work directory
WORKDIR /var/www/projects
