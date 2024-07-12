FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mysql.sh /.
RUN chmod +x /mysql.sh

RUN ./mysql.sh