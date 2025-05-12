FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=nointeractive

RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mysqld", "--user=mysql", "--console"]
