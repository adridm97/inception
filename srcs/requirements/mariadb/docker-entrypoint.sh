#!/bin/bash
set -e

ROOT_PW_FILE=/run/secrets/db_root_password
WP_PW_FILE=/run/secrets/db_wp_password

if [! -d /var/lib/mysql/mysql]; then
	echo "[entrypoint] Initializing MariaDB..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql

	echo "[entrypoint] Starting temporal server...."
	mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking & pid="$!"
	until mysqladmin ping --silent; do
		sleep 0.5
	done
	ROOT_PW="$(cat "$ROOT_PW_FILE")"
	WP_PW="$(cat "$WP_PW_FILE")"

	echo "[entrypoint] Configuring users and database..."
	mysql -u root <<-EOSQL
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PW}';
		CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${WP_PW}';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
		FLUSH PRIVILEGES;
EOSQL
	echo "[entrypoint] Stopping temporal server..."
	mysqladmin -u root -p"${ROOT_PW}" shutdown
	wait "$pid"
	echo "[entrypoint] MariaDB initialized successfully."
fi

exec "$@"
