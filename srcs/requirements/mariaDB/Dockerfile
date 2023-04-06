FROM debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE


RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/config.sql /

RUN service mysql start && mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" && \
	mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
	mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" && \
	mysql -e "FLUSH PRIVILEGES;" && \
	mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < config.sql ;


EXPOSE 3306

CMD ["mysqld",  "--bind-address=0.0.0.0"]

