FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl genrsa -out /etc/nginx/ssl/server.key 2048

RUN openssl req \
    -new -key /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.csr -subj \
    "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42/OU=Sao Paulo/CN=cpereira.42.fr/emailAddress=cpereira@mail.com"

RUN openssl x509 -req -days 365 \
    -in /etc/nginx/ssl/server.csr \
    -signkey /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
