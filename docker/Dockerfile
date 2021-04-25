FROM php:7.4-fpm

RUN apt-get update && apt-get install -y supervisor zip imagemagick nginx \
    libpng-dev libsqlite3-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install bcmath exif gd \
    iconv intl \
    mysqli pdo_mysql \
    pdo_sqlite soap \
    sockets xmlrpc pcntl

RUN echo '' | pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/php.ini /usr/local/etc/php/
COPY ./docker/supervisord.conf /etc/supervisor/supervisord.conf
COPY . /home/52poke/wiki

RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && cd /home/52poke/wiki && composer install --no-dev

RUN chown -R www-data:www-data /home/52poke/wiki

WORKDIR /home/52poke/wiki
EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
