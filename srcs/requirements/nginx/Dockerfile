FROM debian:oldstable

RUN apt update -y && apt upgrade -y

RUN apt install -y\
	nginx\
	openssl

RUN mkdir -p /etc/nginx/ssl &&\
	openssl req -x509 -nodes -days 365 -newkey rsa:2048\
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=emlicame"\
	-keyout /etc/ssl/private/nginx-selfsigned.key\
	-out /etc/ssl/certs/nginx-selfsigned.crt

RUN mkdir -p /run/nginx

COPY start.sh /start.sh

EXPOSE 80 443

# CMD ["nginx", "-g", "daemon off;"]
CMD ["/bin/bash", "/start.sh"]

