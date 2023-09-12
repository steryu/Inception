#!/bin/sh
# The wp_setup script installs WordPress, starts the php-fpm server, and creates a WordPress user.

./wait.sh

mkdir -p /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]
then
	cd /var/www/wordpress #go into volume
    wp core download --allow-root
    wp config create --allow-root --path= --dbname=$DB_NAME --dbuser=$ADMIN_LOGIN --dbpass=$ADMIN_PASSWORD --dbhost=mariadb --config-file=/var/www/wordpress/wp-config.php --skip-packages --skip-plugins 

    echo Created config

	wp core install --allow-root --url=$WP_URL --admin_user=$ADMIN_LOGIN --admin_password=$ADMIN_PASSWORD --title=mywordpresssite --admin_email=pleasedonotemailme@42.fr
	wp user create $NORMAL_LOGIN pleasedonotemailme2@42.fr --allow-root --user_pass=$NORMAL_PASSWORD;
	chown -R www-data:www-data /var/www/wordpress
fi
echo "Wordpress started"
php-fpm7.3 -R -F #runs on the foreground as root