#!/bin/bash

sleep 10

cd /var/www/wordpress

echo "Launching database"
echo "   -user: $MYSQL_USER"
echo "   -database: $MYSQL_DATABASE"
echo "   -host: $MYSQL_HOST"