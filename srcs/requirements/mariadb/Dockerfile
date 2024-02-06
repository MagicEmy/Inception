FROM debian:oldstable

# Update and install dependencies in a single RUN command
RUN apt update -y && apt upgrade -y && \
    apt install -y mariadb-server gettext-base

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chmod 777 /var/run/mysqld /var/lib/mysql

# Configure MariaDB to allow connections using the hostname 'mariadb'
RUN sed -i 's/bind-address .*/bind-address = mariadb/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize MariaDB database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy scripts into the container
COPY tools/start.sh /home/start.sh
COPY tools/start.sql /home/start.sql
# Set execute permissions for the start.sh script
RUN chmod +x /home/start.sh

# execute the start.sh script
ENTRYPOINT ["/home/start.sh"]

# ENTRYPOINT ensures that the initialization script is executed every time the container starts, 
# regardless of any additional command-line arguments provided by users.



# FROM debian:oldstable

# RUN apt update -y && apt upgrade -y

# # gettext-base provides the envsubst command
# RUN apt install -y\
# 	mariadb-server\
# 	gettext-base

# # Not sure what this does, but removing it breaks mariadb
# RUN mkdir -p /var/run/mysqld;\
# 	chmod 777 /var/run/mysqld /var/lib/mysql;

# # Allows wordpress to connect using the name mariadb
# RUN sed 's/bind-address .*/bind-address = mariadb/' -i /etc/mysql/mariadb.conf.d/50-server.cnf

# # Connect mariadb with the database_volume /var/lib/mysql
# # we set up in docker-compose.yml
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# COPY tools/start.sh /home/start.sh
# COPY tools/start.sql /home/start.sql
# RUN chmod 777 /home/start.sh

# CMD [ "/home/start.sh" ]
