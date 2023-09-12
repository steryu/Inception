FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx openssl curl

# The libfcgi0ldbl package is needed to run the wp-cli.phar file
RUN apt-get -y install libfcgi0ldbl

# Where COPY is used to copy the configuration file and start.sh from the host to the container
COPY conf/nginx.conf /etc/nginx/sites-available/default.conf
COPY start.sh .
RUN chmod +x start.sh

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/key.key -out /etc/nginx/crt.crt -subj "/CN=svan-ass.42.fr"

EXPOSE 443

ENTRYPOINT [ "./start.sh" ]