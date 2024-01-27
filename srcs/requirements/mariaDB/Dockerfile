FROM debian:oldstable


RUN apt update -y && apt upgrade -y

RUN apt install -y \
	mariadb-server

# COPY tools/my.cnf /etc/mysql/my.cnf ?

RUN mkdir -p /var/run/mysqld;\
	chmod 777 /var/run/mysqld /var/lib/mysql;