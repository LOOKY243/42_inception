sleep 10

wp config create --allow-root \
    --dbname=$SQL_DBNAME \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --allow-root \
    --url="http://gmarre.42.fr:8080" \
    --title="Your Blog Title" \
    --admin_user="admin" \
    --admin_password="password" \
    --admin_email="your-email@example.com"