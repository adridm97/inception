#!/bin/bash
set -e

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_WP_PASSWORD=$(cat /run/secrets/db_wp_password)
export DB_WP_PASSWORD

envsubst < /init.sql.template > /init.sql

mysqld_safe --datadir=/var/lib/mysql &
sleep 5

if ! mysql -u root -p"$DB_ROOT_PASSWORD" -e 'USE wordpress;' > /dev/null 2>&1; then
	echo "Initializing wordpress database..."
	mysql -u root -p"$DB_ROOT_PASSWORD" < /init.sql
fi
wait
