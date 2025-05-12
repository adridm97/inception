
FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=nointeractive

RUN apt-get update && apt-get install -y nginx gettext-base \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
