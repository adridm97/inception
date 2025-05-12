#!/bin/bash

set -e

until mysqladmin ping -h "${DB_HOST}" --silent; do
	echo "[wordpress] waiting MariaDB..."
	sleep 1
done

if [ ! -f wp-config.php ]; then
	echo "[wordpress] Generating wp-config.php..."

	cp wp-config-sample.php wp-config.php

	sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
	sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
	sed -i "s/localhost/${DB_HOST}/" wp-config.php

	WP_PW=$(cat /run/secrets/db_wp_password)
	sed -i "s/password_here/${WP_PW}/" wp-config.php
	
	SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

	printf '%s\n' "${SALTS}" >> wp-config.php

	chown www-data:www-data wp-config.php
fi
exec "$@"
