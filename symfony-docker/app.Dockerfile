FROM php:7.3-fpm

RUN apt-get update && apt-get install -y  \ 
	git \
	libzip-dev \ 
	zip \
	unzip

RUN docker-php-ext-configure zip --with-libzip

RUN docker-php-ext-install pdo_mysql zip

COPY composer.lock composer.json /var/www/

WORKDIR /var/www

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('sha384', 'composer-setup.php') === '8a6138e2a05a8c28539c9f0fb361159823655d7ad2deecb371b04a83966c61223adc522b0189079e3e9e277cd72b8897') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& php composer.phar install --no-dev --no-scripts \
	&& rm composer.phar

COPY . /var/www

# RUN chown -R www-data:www-data \
# 	/var/www/

