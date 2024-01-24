FROM debian:oldstable

RUN apt update -y && apt upgrade -y

RUN apt install -y\
	nginx\
	openssl

RUN mkdir -p /etc/nginx/ssl &&\
	openssl req -x509 -nodes -newkey rsa:2048 \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=emlicame" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

# The req command primarily creates and processes certificate requests in PKCS#10 format. It can also create self-signed certificates.
# -newkey rsa:2048: This option creates a new certificate request and a new private key at the same time
# when creating certificate, OpenSSL will ask us for a password. If we ask for something to enter when starting the container, it will not be able to build
# -nodes option , our private key will simply end up without a password.
# must then indicate to OpenSSL where we wish to store the certificate and key of our SSL by adding the -out and -keyout options.

# modify the NGINX configuration file as desired . we could redirect certain sentences in the config file , but we will instead use the keywordCOPYofDockerfile, 
COPY conf/nginx.conf /etc/nginx/nginx.conf
# https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html 
#Sets user and group (common)used by web servers, such as NGINX and Apache, to handle web-related processes.

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

# Mount the certificates from the host to the container: 
# Instead of creating a new certificate each time you build the image, 
# you can create the certificate once on your host machine and then mount it 
# into the container when you run it1. Here’s an example of how you can do this:
# docker run -v /host/path/to/certs:/container/path/to/certs -d IMAGE_ID
# Use a script that sets up the host’s SSL certificates in the guest: 
# This method doesn’t require you to rebuild any containers1. 
# example https://github.com/AriFordsham/docker-cert/blob/master/docker
# If you don't add the line to change ownership with chown in your Dockerfile, 
# the ownership of the files and directories within your container's filesystem 
# will be set to the default values inherited from the base image or 
# the way they were added during the Docker image build process.
# Here are some potential consequences of not setting ownership explicitly:
# Default Ownership: The ownership might be set to the default values defined 
# in the base image. This could be the root user and root group, 
# depending on the base image you are using.
# Permission Issues: The web server running inside the container, 
# typically represented by the www-data user and group, 
# might not have the necessary permissions to read or write to certain files or directories. 
# This can lead to permission issues when your web application tries to access or modify files.