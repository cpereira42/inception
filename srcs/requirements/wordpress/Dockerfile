FROM debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST

RUN apt update && apt install -y curl nano \
    php7.3 php7.3-phar php7.3-fpm php7.3-opcache \
    php7.3-cli php7.3-gd php7.3-curl php7.3-mysql php7.3-mbstring

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar xvf latest.tar.gz && \
    mkdir -p /var/www/wordpress && \
    mv wordpress/* /var/www/wordpress/ && \
    rm -rf wordpress && \
    sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/7.3/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/wordpress \
	&& chmod -R 777 /var/www/wordpress

RUN mkdir -p /run/php

WORKDIR /var/www/wordpress/

RUN sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php  && \
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php && \
    sed -i "s/localhost/$MYSQL_HOST/g" wp-config-sample.php && \
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php && \
    chown -R www-data:www-data /var/www/wordpress

RUN mv wp-config-sample.php wp-config.php 



EXPOSE 9000

# Inicia php-fpm
CMD ["php-fpm7.3", "-F" ]