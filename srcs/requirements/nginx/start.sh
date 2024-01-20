#!/bin/bash

# Create the conf directory
mkdir -p /etc/nginx/conf.d

# Create nginx.conf
cat << EOF > /etc/nginx/conf.d/nginx.conf
# Paste your nginx configuration here
EOF

# Create ssl.conf
cat << EOF > /etc/nginx/conf.d/ssl.conf
# Paste your ssl configuration here
EOF

# Start Nginx
exec nginx -g 'daemon off;'

