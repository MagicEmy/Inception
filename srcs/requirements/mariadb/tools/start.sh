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




# set -e  enable the exit immediately option in the shell.
# if any command in the script fails, the script will terminate immediately.
# ensuring that the script does not continue running if an error occurs.

# The exec command is used to replace the shell process with the specified command.
# This means that the shell process is terminated and the command is executed in its place.
# Important to run a command in place of the shell, rather than as a child process of the shell.
# When a command is run as a child process, the shell process remains running.
# However, when you use exec with the final command, 
# the shell replaces its own process with that command.