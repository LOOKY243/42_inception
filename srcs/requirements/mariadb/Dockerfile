FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /.

RUN chmod 755 /script.sh

ENTRYPOINT [ "bash", "/script.sh" ]