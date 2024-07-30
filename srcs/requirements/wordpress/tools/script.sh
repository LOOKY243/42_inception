sleep 10


WP_PATH='/var/www/wordpress'

if [ -f "$WP_PATH/wp-config.php" ]
then
	echo "Wordpress already installed"
else

	wp core download --allow-root --path="$WP_PATH"

	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASS --dbhost="mariadb:3306" --skip-check
    wp core install --allow-root --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL

    wp user create --allow-root "$WP_USER" "$WP_USER_MAIL" --user_pass="$WP_USER_PASS" --role='contributor'

fi

exec "$@"