if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db  2>/dev/null

    /usr/bin/mysqld_safe 2>/dev/null

    /etc/init.d/mariadb start;
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASS}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASS}';"
    mysql -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p $SQL_ROOT_PASS shutdown
    exec mysqld_safe
fi