#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database initialization..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
fi

echo "Temporary launch of MariaDB in safe mode for configuration..."
mysqld_safe --datadir=/var/lib/mysql --skip-networking &
pid="$!"

until mysqladmin ping --silent; do
    sleep 1
done

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO \`${MYSQL_USER}\`@'%';"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

killall mysqld_safe
wait

exec mysqld_safe