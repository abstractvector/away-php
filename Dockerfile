FROM php:7.2-fpm-alpine

# install PHP extensions
RUN docker-php-ext-install mysqli

RUN apk --no-cache add coreutils freetype-dev libjpeg-turbo-dev libltdl libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# install the redis extension which isn't available in PECL
RUN apk --no-cache add git \
    && git clone -b develop https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# give it the same user ID as the main user
RUN usermod -u 1000 www-data

COPY php.ini /usr/local/etc/php/conf.d/php.ini