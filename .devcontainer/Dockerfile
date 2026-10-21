FROM php:8.3-fpm

RUN apt-get update && apt-get install -y supervisor poolcounter zip imagemagick nginx \
	libpng-dev libsqlite3-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev \
	git curl unzip openssh-client libicu-dev \
	&& apt-get -y autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install bcmath exif gd \
	iconv intl calendar \
	mysqli pdo_mysql \
	pdo_sqlite soap \
	sockets pcntl

RUN curl -sSLf \
	-o /usr/local/bin/install-php-extensions \
	https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
	chmod +x /usr/local/bin/install-php-extensions && \
	install-php-extensions redis xmlrpc wikidiff2 xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupmod --gid "${GROUP_ID}" www-data && \
	usermod --uid "${USER_ID}" --gid "${GROUP_ID}" --home /home/www-data --shell /bin/bash www-data && \
	mkdir -p /home/www-data && \
	chown -R www-data:www-data /home/www-data /var/www /var/lib/nginx && \
	apt-get update && apt-get install -y sudo && \
	echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /home/52poke/wiki
EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
