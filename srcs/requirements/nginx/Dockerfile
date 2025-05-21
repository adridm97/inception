
FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main\n\
	deb http://security.debian.org/debian-security bullseye-security main\n\
	deb http://deb.debian.org/debian bullseye-updates main" > /etc/apt/sources.list && \
	apt-get update && apt-get install -y nginx openssl --fix-missing \
	&& apt-get clean

RUN mkdir -p /etc/nginx/ssl /var/www/html

RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/default.conf /etc/nginx/sites-available/default
COPY conf/ssl/server.crt /etc/nginx/ssl/server.crt
COPY conf/ssl/server.key /etc/nginx/ssl/server.key
COPY conf/fastcgi-params /etc/nginx/fastcgi-params

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
