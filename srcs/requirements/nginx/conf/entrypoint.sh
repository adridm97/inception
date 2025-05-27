#!/bin/bash

DOMAIN_NAME=${DOMAIN_NAME:-localhost}

if [ ! -f /etc/nginx/ssl/server.crt ]; then
	mkdir -p /etc/nginx/ssl
	openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/ssl/server.key \
		-out /etc/nginx/ssl/server.crt \
		-subj "/C=ES/ST=42/L=Inception/O=42Barcelona/CN=${DOMAIN_NAME}"
fi

envsubst '$DOMAIN_NAME' < /etc/nginx/conf/default.conf > /etc/nginx/conf.d/default.conf

exec nginx -g "daemon off;"
