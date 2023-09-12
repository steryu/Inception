FROM debian:buster

RUN apt-get update
RUN apt-get install -y php-fpm php-mysql wget mariadb-client

# Install WordPress Command Line Interface 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make it executable and move it to /usr/local/bin
RUN chmod u+x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Change the listen so the php-fpm can be accessed from outside the container
RUN sed 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|g' -i /etc/php/7.3/fpm/pool.d/www.conf
RUN mkdir -p /run/php

# Copy the configuration file
COPY tools/wp_setup.sh .
COPY tools/wait.sh .

# Make the script executable and run it
RUN chmod +x wp_setup.sh
RUN chmod +x wait.sh

EXPOSE 9000

ENTRYPOINT ["./wp_setup.sh"]
