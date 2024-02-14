FROM debian:oldstable

RUN apt update -y && apt upgrade -y

RUN apt install -y\
	nginx\
	openssl

COPY conf/nginx.conf /etc/nginx/sites-available/nginx.conf

# Removes everything in sites-enabled/
# Forces symlink of sites-available/nginx.conf under the name sites-enabled/nginx.conf
RUN rm -rf /etc/nginx/sites-enabled/* &&\
	ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Create a self-signed certificate
RUN mkdir -p /etc/nginx/ssl &&\
	openssl req -x509 -nodes -newkey rsa:2048 \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=emlicame" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt


EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]



# https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/
# The req command primarily creates and processes certificate requests in PKCS#10 format. It can also create self-signed certificates.
# -newkey rsa:2048: This option creates a new certificate request and a new private key at the same time
# when creating certificate, OpenSSL will ask us for a password. If we ask for something to enter when starting the container, it will not be able to build
# -nodes option , our private key will simply end up without a password.
# must then indicate to OpenSSL where we wish to store the certificate and key of our SSL by adding the -out and -keyout options.
