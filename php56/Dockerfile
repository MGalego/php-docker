FROM php:5.6-fpm

RUN bash -c 'echo -e apt-get updating...'
# Install any custom system requirements here
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
  && rm -rf /var/lib/apt/lists/*


RUN bash -c 'echo -e Installing various PHP extensions...'
# Install various PHP extensions
RUN docker-php-ext-configure bcmath --enable-bcmath \
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
        mcrypt \
        zip \
  && docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 \
  && docker-php-ext-install gd \
  && docker-php-ext-install opcache \
  && pecl install memcached-2.2.0 \
  && docker-php-ext-enable \ 
        opcache \
        memcached


# Install the xdebug extension
RUN bash -c 'echo -e Installing the xdebug extension...'
RUN pecl install xdebug-2.5.5

# Copy xdebug configuration for remote debugging
RUN bash -c 'echo -e Copying xdebug configuration for remote debugging...'
COPY ./php56/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini    
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini

# Copy timezone configration
RUN bash -c "echo -e Setup the timezone..."
COPY ./php56/timezone.ini /usr/local/etc/php/conf.d/timezone.ini

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
RUN "date"

# Install Composer
RUN bash -c "echo -e Installing composer..."
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
