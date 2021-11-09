FROM php:7.2-fpm

# Change default port
# https://github.com/docker-library/php/issues/479
#RUN sed -i 's/9000/3001/' /usr/local/etc/php-fpm.d/zz-docker.conf

# Install any custom system requirements here
RUN bash -c "echo -e Updating apt-get..."
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    libicu-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libssl-dev \
    libxml2-dev \
    libbz2-dev \
    libjpeg62-turbo-dev \
    libmemcached-dev \
    zlib1g-dev \
    xvfb \
    xauth \
    libfontconfig \
    wkhtmltopdf \
    unixodbc \
    unixodbc-dev \
  && rm -rf /var/lib/apt/lists/*

# Install various PHP extensions
RUN bash -c "echo -e Installing PHP Extensions..."
RUN pecl install mcrypt-1.0.1 \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure mbstring --enable-mbstring \
    && docker-php-ext-install \
        bcmath \
        intl \
        mbstring \
        mysqli \
        pdo_mysql \
        pcntl \
        sockets \
        zip \
  && docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 \
  && docker-php-ext-install gd \
  && docker-php-ext-install opcache \
  && pecl install memcached-3.1.5 \
  && pecl install redis \
  && docker-php-ext-enable \ 
        opcache \
        mcrypt \
        memcached \
        redis \        
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl     

# Install the xdebug extension
RUN bash -c "echo -e Installing XDebug..."
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug 
# Copy xdebug configuration for remote debugging
COPY ./php7/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini

# Copy timezone configration
RUN bash -c "echo -e Configuring timezone..."
COPY ./php7/timezone.ini /usr/local/etc/php/conf.d/timezone.ini

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
RUN "date"

# Install Composer
RUN bash -c "echo -e Installing composer..."
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
