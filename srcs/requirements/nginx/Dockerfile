
FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main\n\
	deb http://security.debian.org/debian-security bullseye-security main\n\
	deb http://deb.debian.org/debian bullseye-updates main" > /etc/apt/sources.list && \
	apt-get update && apt-get install -y nginx openssl --fix-missing \
	&& apt-get clean

RUN mkdir -p /etc/nginx/ssl /var/www/html

RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled

RUN mkdir -p conf/ssl

RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt \
	-subj "/C=ES/ST=Catalunya/L=Barcelona/O=42Barcelona/OU=Inception/CN=aduenas-.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/default.conf /etc/nginx/sites-available/default
COPY conf/fastcgi-params /etc/nginx/fastcgi-params

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
