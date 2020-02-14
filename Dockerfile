FROM php:7.4-fpm-alpine

RUN apk --no-cache add coreutils freetype-dev libjpeg-turbo-dev libltdl libpng-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        bcmath \
		exif \
		gd \
        iconv \
		mysqli \
		opcache \
		zip

# install the redis extension which isn't available in PECL
RUN apk --no-cache add git \
    && git clone -b develop https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# give it the same user ID as the main user
RUN apk add --no-cache shadow \
    && usermod -u 1000 www-data

COPY php.ini /usr/local/etc/php/conf.d/php.ini
