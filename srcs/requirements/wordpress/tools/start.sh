#!/bin/bash

# Exit immediately if any command fails
set -e

# Check if WordPress configuration file exists
if [ ! -f "/var/www/wp-config.php" ]; then
    echo "Creating WordPress configuration"
	# Create WordPress configuration using wp-cli
    wp-cli config create \
        --allow-root \
        --path=/var/www/	\
        --dbhost="$DB_HOST" \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD"

    echo "Installing WordPress"

    # Install WordPress using wp-cli
    wp-cli core install \
        --allow-root \
        --path=/var/www/ \
        --skip-email \
        --title="$WP_ADMIN_TITLE" \
        --admin_name="$WP_ADMIN_NAME" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --url="$WP_ADMIN_URL"

    echo "Creating additional user"

    # Create additional WordPress user using wp-cli
    wp-cli user create \
        "$WP_USER_NAME" \
        "$WP_USER_EMAIL" \
        --allow-root \
        --path=/var/www/ \
        --user_pass="$WP_USER_PASSWORD"
else
    echo "WordPress configuration already exists. Skipping installation."
fi

# Start PHP-FPM
echo "Starting PHP-FPM"
# --nodaemonize forces staying in the foreground
exec php-fpm7.4 --nodaemonize