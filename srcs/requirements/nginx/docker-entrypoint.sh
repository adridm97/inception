#!/bin/sh
set -e

envsubst '\$DOMAIN_NAME\$WORDPRESS_PHP_FPM_PORT' \
	< /etc/nginx/conf.d/default.conf.template \
	> /etc/nginx/conf.d/default.conf
exec "$@"
