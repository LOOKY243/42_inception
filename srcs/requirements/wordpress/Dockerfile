FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install -y \
curl \
wget \
php7.4 \
php-fpm \
php-mysql \
mariadb-client

RUN mkdir -p /run/php
RUN chmod +x /run/php

RUN wget https://wordpress.org/latest.tar.gz -P /var/www
RUN cd /var/www && tar -xvf latest.tar.gz && rm -f latest.tar.gz

RUN	chown -R www-data:www-data /var/www/wordpress
WORKDIR	/var/www/wordpress/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/script.sh /
RUN chmod 755 /script.sh

ENTRYPOINT ["bash", "/script.sh"]

CMD [ "/usr/sbin/php-fpm7.4", "-F" ]