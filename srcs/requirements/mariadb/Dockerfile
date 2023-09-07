FROM debian:buster

RUN apt-get update && apt-get install -y
RUN apt-get install -y mariadb-server mariadb-client

COPY tools/db_setup.sh /tmp/
RUN chmod +x /tmp/db_setup.sh

# so tthat the database is accessible from outside the container
RUN sed 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' -i  /etc/mysql/mariadb.conf.d/50-server.cnf 
# this enables network access to the database server
RUN sed 's/skip-networking/#skip-networking/g' -i  /etc/mysql/mariadb.conf.d/50-server.cnf

# execute the setup script
ENTRYPOINT ["/tmp/db_setup.sh"]