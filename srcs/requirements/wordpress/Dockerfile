
FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=nointeractive

RUN apt-get update && apt-get install -y php-fpm php-mysql curl unzip && rm -rf /var/lib/apt/lists/*

RUN sed -i "s|^listen = .*|listen = 0.0.0.0:${WORDPRESS_PHP_FPM_PORT}|" /etc/php/*/fpm/pool.d/www.conf

RUN mkdir -p /var/www/html && curl -sSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz \
	&& tar xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
	&& chown -R www-data:www-data /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

EXPOSE ${WORDPRESS_PHP_FPM_PORT}

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm7.4", "--nodaemonize"]

