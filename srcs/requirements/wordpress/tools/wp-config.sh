#!/bin/sh

# This lets the script exit if any command fails
set -e

if [ ! -f "/var/www/wp-config.php" ]; then
echo "Creating config"

# until mysqladmin ping -hmariadb --silent; do
# echo "Waiting for MariaDB to come online..."
# 	sleep 1
# done

echo "Domain: ${DOMAIN_NAME}"

echo "Downloading Wordpress..."
# wp config create
wp core download --allow-root

echo "Configuring Wordpress..."
wp core config				\
	--dbhost="mariadb" 		\
	--dbname=$DB_NAME		\
	--dbuser=$DB_USER		\
	--dbpass=$DB_PASSWORD	\
	--allow-root			\
	--skip-check

echo "Setting permissions..."
chmod 644 wp-config.php


echo "Installing Wordpress..."
wp core install 						\
	--url=$DOMAIN_NAME 					\
	--admin_name=$WP_ADMIN_NAME 		\
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL 		\
	--skip-email 						\
	--allow-root

echo "Creating Wordpress user $WP_USER_NAME..."

wp user create 						\
	$WP_USER_NAME					\
	$WP_USER_EMAIL					\
	--user_pass=$WP_USER_PASSWORD	\
	--allow-root

fi

echo "Wordpress was successfully installed."

# echo "Configuring php-fpm..."
# sed -i '/^listen /c\listen = 9000' /etc/php/7.3/fpm/pool.d/www.conf

# --nodaemonize forces staying in the foreground OR use -F flag	
echo "Launching php-fpm..."
php-fpm7.4 --nodaemonize

