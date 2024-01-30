FROM debian:oldstable


RUN apt update -y && apt upgrade -y

RUN apt install -y \
	mariadb-server \
	gettext-base

RUN sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' \
	-i /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld;\
	chmod 777 /var/run/mysqld /var/lib/mysql;

# Connect mariadb with the database_volume /var/lib/mysql
# we set up in docker-compose.yml
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY tools/start.sh /home/start.sh
COPY tools/start.sql /home/start.sql
RUN chmod +x /home/start.sh

EXPOSE 3306

ENTRYPOINT [ "/home/start.sh" ]

CMD [ "mariadb" ]
