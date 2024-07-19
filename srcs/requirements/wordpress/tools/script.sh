sleep 10

wp config create --allow-root \
    --dbname=$SQL_DBNAME \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASS \
    --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --allow-root \
    --url="http://gmarre.42.fr:8080" \
    --title="Inception" \
    --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_MAIL --path='/var/www/wordpress'

exec /usr/sbin/php-fpm7.4 -F