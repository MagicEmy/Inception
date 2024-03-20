FROM debian:oldstable

# Install required packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y \
        php7.4 \
        php7.4-fpm \
        php7.4-mysql \
        php7.4-curl \
        php7.4-gd \
        php7.4-intl \
        php7.4-mbstring \
        php7.4-soap \
        php7.4-xml \
        php7.4-zip \
        mariadb-client && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Download WordPress - The ADD command automatically handles downloading files from URLs and copying them into the image
ADD https://wordpress.org/wordpress-6.4.2.tar.gz /var/www/wordpress.tar.gz

# Extract WordPress to /var/www/
RUN tar -xzf /var/www/wordpress.tar.gz -C /var/www/ && \
    mv /var/www/wordpress/* /var/www/ && \
    rmdir /var/www/wordpress && \
    rm /var/www/wordpress.tar.gz

# Change ownership of web directory to avoid default :will be set to the user and group IDs of the user who built the image.
RUN chown -R root:root /var/www/ \
	&& chmod -R 755 /var/www/


# Download wp-cli PHP Archive to /usr/local/bin/
ADD https://raw.githubusercontent.com/wp-cli/builds/3e345df698faea02d64baebcb2fa6fc523231494/phar/wp-cli-release.phar /usr/local/bin/wp-cli

# Allow executing wp-cli
RUN chmod +x /usr/local/bin/wp-cli

# Prevent "ERROR: Unable to create the PID file (/run/php/php7.4-fpm.pid).: No such file or directory"
RUN mkdir -p /run/php

# Changes the address on which to accept FastCGI requests from the default value of "/run/php/php7.4-fpm.sock"
RUN sed 's/listen = .*/listen = wordpress:9000/' -i /etc/php/7.4/fpm/pool.d/www.conf

# Copy start script and set permissions
COPY tools/start.sh /home/start.sh
RUN chmod +x /home/start.sh

# Define the entry point
ENTRYPOINT ["/home/start.sh"]

