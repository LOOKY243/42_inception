#!/bin/bash

# Initialize the MariaDB data directory if it doesn't already exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "Data directory initialized."
fi

# Start the MariaDB server in the background
echo "Starting MariaDB server..."
mysqld_safe &
echo "Waiting for MariaDB to start..."

# Wait until the MariaDB server is fully started
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be fully operational..."
    sleep 2
done
echo "MariaDB is up and running."

# Run mysql_upgrade to upgrade system tables if needed
echo "Running mysql_upgrade..."
mysql_upgrade -u root -p${SQL_ROOT_PASS}
echo "mysql_upgrade completed."

# Create database and user
echo "Setting up database and user..."
mysql -u root -p${SQL_ROOT_PASS} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASS}';
    FLUSH PRIVILEGES;
EOSQL
echo "Database and user setup completed."

# Shutdown MariaDB server
echo "Shutting down MariaDB server..."
mysqladmin -u root -p${SQL_ROOT_PASS} shutdown
echo "MariaDB server shut down."

# Start MariaDB server in the foreground
exec mysqld_safe
