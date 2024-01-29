FROM debian:oldstable

# Install latest system updates
RUN apt update && apt upgrade -y

# Install required software
RUN apt install -y mariadb-client php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip php-fpm curl unzip

# Download wp-cli (Wordpress Command Line Interface)
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/local/bin/wp
RUN sed -i "s+listen = /run/php/php7.4-fpm.sock+listen = wordpress:9000+g" /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p ./run/php

EXPOSE 9000

# Set up and run wordpress
WORKDIR /var/www/html
COPY tools/wp-config.sh /tmp/wp-config.sh

CMD ["sh", "/tmp/wp-config.sh"]


