FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server gettext && apt-get clean

RUN mkdir -p /var/lib/mysql && mkdir -p /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./init.sql.template /init.sql.template

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

CMD ["/docker-entrypoint.sh"]
