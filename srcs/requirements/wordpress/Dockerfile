
FROM debian:bullseye


RUN apt-get update \
	&& apt-get install -y \
	php php-fpm php-mysql php-cli php-curl php-mbstring php-xml php-zip \
	curl \
	unzip wget \
	mariadb-client \
	iputils-ping \
	&& apt-get clean

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	cp -r wordpress/* . && rm -rf wordpress latest.tar.gz

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]

