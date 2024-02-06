#!/bin/bash

# This lets the script exit if any command fails
set -e

# Since /var/lib/mysql is the persistent volume,
# we don't need to do this every time the container boots,
# but if the directory does not exist, it means the database has not been initialized yet.

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Initializing mariadb database"

	# envsubst fills the environment variables from start.sql
	# Bootstrap the database using start.sql and environment variables
	echo "Bootstrapping mariadbd"
	< /home/start.sql envsubst | mariadbd --bootstrap
else
	echo "mariadb database was already initialized"
fi

echo "Running mariadbd"
# exec replaces the shell process with mariadbd
exec mariadbd

# When the last command in the script is not preceded by exec, 
# the shell creates yet another process to execute it. 
# This means that the shell process itself remains, consuming resources unnecessarily.
# However, when you use exec with the final command, 
# the shell replaces its own process with that command.