FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y wget

RUN apt install -y \
php-fpm \
php-mysql \
mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.0-fr_FR.tar.gz && rm -f wordpress-6.0-fr_FR.tar.gz

RUN	chown -R www-data:www-data /var/www/wordpress

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /
RUN chmod +x /auto_config.sh

RUN wp core install
RUN /usr/sbin/php-fpm7.3 -F

ENTRYPOINT ["sh", "-c", "/etc/init.d/php7.4-fpm start && bash /auto_config.sh"]