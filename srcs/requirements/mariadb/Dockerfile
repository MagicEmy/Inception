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
# The start.sh script is responsible for starting the MariaDB server and creating the necessary database and user.
# The start.sql script is used to create the database and user.

